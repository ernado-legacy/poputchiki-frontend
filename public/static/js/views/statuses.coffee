app.views.Statuses = Backbone.View.extend

    el: '.mainContentProfile'

    events: 
        # 'click .like': 'like'
        'click .statusesContainer .filterBlock .box': 'sexfilter'
        'click .statusesContainer .filterBlock .search_by_place': 'getstatuses'


    
    sexfilter: (e)->
        do @loadingstatuses
        # @$el.find('.box').removeClass 'checked'
        box = $(e.currentTarget)
        box.toggleClass 'checked'
        if not box.hasClass 'checked'
            box.addClass 'checked'
        else
            box.removeClass 'checked'
        do @rerender

    render: ->
        do @loadingstatuses
        history.pushState null, 'poputchiki', '/statuses/'
        $ @$el.html jade.templates.statuses()
        app.models.myuser.get (user) =>
            app.views.main_status.render user

        @pagination = new app.views.Pagination
            el: @$el.find('.pagination')[0]

        do @rerender
        sc = @$el.find '.searchCountry'
        scv = new app.views.AutocompleteCountry
            el: sc
        sct = @$el.find '.searchCity'
        sctv = new app.views.AutocompleteCity
            el: sct

    rerender: ->
        @getstatuses 1, (statuses) =>
            @pagination.render 1 + statuses.size()/20
            @pagination.setreaction (i) => @getstatuses i

    getstatuses: (i, callback) ->
        do @loadingstatuses
        that = @
        statuses = new app.models.Statuses
        i = i - 1
        offset = i * 20
        statusfilterdata = 
            offset: offset
            count: 20

        if $('.manBox .checked').length == 1
            statusfilterdata.sex = 'male'
        if $('.womanBox .checked').length == 1
            statusfilterdata.sex = 'female'
        if $('.womanBox .checked').length == 1 and $('.manBox .checked').length == 1
            statusfilterdata.sex = ''
        if @$el.find('.searchCountry input').val()
            statusfilterdata.country = @$el.find('.searchCountry input').val()
        if @$el.find('.searchCity input').val()
            statusfilterdata.city = @$el.find('.searchCity input').val()
        statuses.fetch
            data: statusfilterdata
            processData: true
            success: ->
                that.$el.find('.statusBlockWrap').html jade.templates.statusesitem
                    statuses: statuses
                _.each that.$el.find('.statusBlock'), (item) ->
                    view = new app.views.Status 
                        el: item
                    do view.updatelike
                callback(statuses) if callback
                # usersidlist = _.uniq statuses.map (item) ->
                #     item.get 'user'
                # index = 0
                # size = _.size usersidlist
                # users = {}
                # _.each usersidlist, (id) ->
                #     users[id] = new app.models.User
                #     users[id].set 'id', id
                #     users[id].fetch
                #         success: ->
                #             index += 1
                #             if index == size
                #                 console.log statuses.models
                #                 that.$el.find('.statusBlockWrap').html jade.templates.statusesitem
                #                     users: users
                #                     statuses: statuses
                #                 _.each that.$el.find('.statusBlock'), (item) ->
                #                     view = new app.views.Status 
                #                         el: item
                #                     do view.updatelike
    loadingstatuses: ->
        $('.statusBlockWrap').html("<img src='http://poputchiki/static/img/searchpreloader.GIF' class='loading-gif')'>")
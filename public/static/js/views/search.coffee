app.views.Search = Backbone.View.extend _.extend app.mixins.SlideRigtBlock,

    el: '.mainContentProfile'

    events:
        # 'click .searchBox button': 'search'
        'click .profile-search': 'search'
        'click a.ldblock': 'link'
        'click .box': 'toogle'

    search: ->


        that = this

        query =
            offset: 0
            count: 20
            sex: 'female'

        from = $('#search-age-from').val()
        to = $('#search-age-to').val()

        searchFormData = {}

        if from
            searchFormData['likings_age_min'] = from*1
            query.agemin = from
        if to
            searchFormData['likings_age_max'] = to*1
            query.agemax = to

        query.sex = if $('.manBox .checked').length == 1 then 'male' else 'female'

        searchFormData['likings_sex'] = query.sex

        app.models.myuser.get (user) ->
            # user.set searchFormData
            console.log searchFormData
            # do user.save searchFormData,{patch: true}

            user.set searchFormData
            user.save searchFormData, patch: true if _.size(user.changed)>0


        query.sex = if $('.manBox .checked').length == 1 then 'male' else 'female'

        @query = query

        @research 1, (data) =>
            @pagination.render 1 + data.count/20
            @pagination.setreaction (i) => @research i

        that = @
        app.models.searchphoto query,
            (data) ->
                that.slideHideAndShow ()->
                    do app.views.searchside.render
                    app.views.searchside.renderitems data
        #do @render

    research: (item, callback) ->
        query = @query
        item = item - 1
        query.offset = item * 20
        query.count = 20
        app.models.search query, (data) =>
            @$el.find('.gallery ul').html ''
            @renderSearchingUser  new app.models.User user for user in data.result
                # that.$el.find('.gallery').html jade.templates.search_users 
                #     users: data
            @$el.find('.results small').text(' попутчик')
            @$el.find('.results small').first().text('найден ')
            @$el.find('.results span.count').text(data.count)
            callback(data) if callback

    renderSearchingUser: (user) ->
        listUserView = new app.views.UserListView 
            model:user,
            template:jade.templates.search_user_list
        # $('.guests .chatLine').append listUserView.render()
        @$el.find('.gallery ul').append listUserView.render()

    toogle: (event) ->
        $(event.currentTarget).toggleClass('checked')

    link: (event) ->
        event.preventDefault()
        app.views.guestprofile.set_user $(event.currentTarget).attr 'data-user-id'
        do app.views.guestprofile.render

    render: ->
        that = @
        history.pushState null, 'poputchiki', '/search/'
        app.views.profile.get_my_user (user) =>
            $ that.$el.html jade.templates.search
                user: user.attributes
            that.pagination = new app.views.Pagination
                el: that.$el.find('.pagination')[0]
            #ms = @$el.find '.mainSelectElement'
            #_.each ms, (item) ->
            #    autocomplete = new app.views.Autocomplete
            #        el: item
            sc = @$el.find '.searchCountry'
            scv = new app.views.AutocompleteCountry
                el: sc
            sct = @$el.find '.searchCity'
            sctv = new app.views.AutocompleteCity
                el: sct
            sctv.country = scv
        # do @.search

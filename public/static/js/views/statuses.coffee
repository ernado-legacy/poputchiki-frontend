app.views.Statuses = Backbone.View.extend

    el: '.mainContentProfile'

    events: 
        'click #edit-status': 'editstatus'
        'click #write-new-main-status': 'newstatus'

    render: ->
        history.pushState null, 'poputchiki', '/statuses/'
        $ @$el.html jade.templates.statuses()
        do @getstatuses

    getstatuses: ->
        that = @
        statuses = new app.models.Statuses
        statuses.fetch
            data:
                offset: 0
                count: 100
            processData: true
            success: ->
                usersidlist = _.uniq statuses.map (item) ->
                    item.get 'user'
                index = 0
                size = _.size usersidlist
                users = {}
                _.each usersidlist, (id) ->
                    users[id] = new app.models.User
                    users[id].set 'id', id
                    users[id].fetch
                        success: ->
                            index += 1
                            if index == size
                                that.$el.find('.statusBlockWrap').html jade.templates.statusesitem
                                    users: users
                                    statuses: statuses

    editstatus: ->
        $("#main-status").slideUp "slow"
        $(".statusBoxEdit").slideDown "slow"

    newstatus: ->
        that = @
        status = new app.models.Status
        status.set 'text', $('#new-status').val()
        #status.user = app.models.myuser.getid()
        status.save null,
            success: =>
                do that.getstatuses
                $('#main-status .status').text status.get 'text'
                $("#main-status").slideDown "slow"
                $(".statusBoxEdit").slideUp "slow"
        #$.ajax
        #    type: "PUT",
        #    url: "/api/status",
            #success: callback
            #error: error
        #    dataType: "json"
        #    data:
        #        text: "hello"
        #        user: app.models.myuser.getid()
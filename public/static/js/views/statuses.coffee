app.views.Statuses = Backbone.View.extend

    el: '.mainContentProfile'

    events: 
        'click .like': 'like'

    render: ->
        history.pushState null, 'poputchiki', '/statuses/'
        $ @$el.html jade.templates.statuses()
        app.models.myuser.get (user) =>
            app.views.main_status.render user
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
                that.$el.find('.statusBlockWrap').html jade.templates.statusesitem
                    statuses: statuses
                _.each that.$el.find('.statusBlock'), (item) ->
                    view = new app.views.Status 
                        el: item
                    do view.updatelike
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
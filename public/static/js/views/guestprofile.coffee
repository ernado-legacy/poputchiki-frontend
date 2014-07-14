app.views.GuestProfile = Backbone.View.extend

    el: '.mainContentProfile'

    events:
        'click .write': 'write'

    initialize: ->
        id = window.location.href.split('/').slice(4)[0]
        @.model = new app.models.User 
            id: id
        @.model.fetch()
        return

    get_my_user: (callback) ->
        user = new app.models.User 
            id: window.location.href.split('/').slice(4)[0]
        user.fetch
            success: ->
                callback user

    set_user: (id) ->
        history.pushState null, 'poputchiki', '/user/' + id

    render: ->
        that = @
        @get_my_user (user) ->
            $ that.$el.html jade.templates.guest_profile
                user: user.attributes

    write: ->
        do app.views.message.render
        do app.views.messageside.render
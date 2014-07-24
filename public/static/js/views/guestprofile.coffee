app.views.GuestProfile = Backbone.View.extend

    el: '.mainContentProfile'

    events:
        'click .write': 'write'
        'click .add_to_fav': 'add_to_fav'
        'click .remove_from_fav': 'remove_from_fav'

    initialize: ->
        id = window.location.href.split('/').slice(4)[0]
        @.model = new app.models.User 
            id: id
        @.model.fetch()
        return

    get_user: (callback) ->
        user = new app.models.User 
            id: window.location.pathname.split('/').slice(2)[0]
        user.fetch
            success: ->
                callback user

    set_user: (id) ->
        history.pushState null, 'poputchiki', '/user/' + id

    render: ->
        that = @
        @get_user (user) ->
            app.models.myuser.get_favs (favs)->
                is_fav = false 
                is_fav = true if favs.get(user.id)
                that.model = user
                app.views.user_photo_block.render(window.location.pathname.split('/').slice(2)[0])
                user_id = app.models.myuser.getid()
                user.visit_user_by()  if user_id
                $ that.$el.html jade.templates.guest_profile
                    user: user.attributes,
                    is_fav: is_fav

    write: ->
        app.views.message.set_url window.location.pathname.split('/').slice(2)[0]
        do app.views.message.render
        do app.views.messageside.render

    add_to_fav: ->
        do @model.add_to_fav
        alert 'user added to favourites'

    remove_from_fav: ->
        do @model.add_to_fav
        alert 'user removed from favourites'

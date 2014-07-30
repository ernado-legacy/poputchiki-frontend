app.views.Favs = Backbone.View.extend


    el: '.mainContentProfile'


    # get_my_user: (callback) ->
    #     collection = app.models.Guests
    #         id: $.cookie 'user'
    #     user.fetch
    #         success: ->
    #             callback user

    get_favs: (callback) ->
        app.models.myuser.get_favs callback

    render: ->
        that = @
        history.pushState null, 'poputchiki', '/favourites/'
        app.models.myuser.get (user) ->
            app.models.myuser.get_favs (collection) ->
                $ that.$el.html jade.templates.favs
                        user: user.attributes
                        favs: collection.toJSON()
                that.renderFav fav for fav in collection.models

    renderFav: (user) ->
        listUserView = new app.views.UserListView 
            model:user,
            template:jade.templates.fav_user_list
        $('.guests .chatLine').append listUserView.render()

    doAction: (view)->
        console.log view

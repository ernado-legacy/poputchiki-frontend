app.views.Favs = Backbone.View.extend


    el: '.mainContentProfile'
    events:
        'click #get-followers.custom-link': 'renderFollowers'
        'click #get-favourites.custom-link': 'renderFavs'
        


    # get_my_user: (callback) ->
    #     collection = app.models.Guests
    #         id: $.cookie 'user'
    #     user.fetch
    #         success: ->
    #             callback user

    get_favs: (callback) ->
        app.models.myuser.get_favs callback

    render: ->
        do @renderFavs

    renderFollowers: ->
        that = @
        history.pushState null, 'poputchiki', '/followers/'
        app.models.myuser.get (user) ->
            collection = new app.models.Followers [], id:user.get('id')
            collection.fetch().done () ->
                $ that.$el.html jade.templates.favs
                        user: user.attributes
                        favs: collection.toJSON()
                that.renderFav fav for fav in collection.models
                $('#menu-favorites').addClass 'current'
                $('#get-followers').removeClass('custom-link')
                $('#get-favourites').addClass('custom-link')
                

    renderFavs: ->
        that = @
        history.pushState null, 'poputchiki', '/favourites/'
        app.models.myuser.get (user) ->
            app.models.myuser.get_favs (collection) ->
                $ that.$el.html jade.templates.favs
                        user: user.attributes
                        favs: collection.toJSON()
                that.renderFav fav for fav in collection.models
                $('#menu-favorites').addClass 'current'
                $('#get-followers').addClass('custom-link')
                $('#get-favourites').removeClass('custom-link')


    renderFav: (user) ->
        
        listUserView = new app.views.UserListView 
            model:user,
            template:jade.templates.fav_user_list
        $('.guests .chatLine').append listUserView.render()

    doAction: (view)->
        console.log view

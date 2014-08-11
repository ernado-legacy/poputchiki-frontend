app.views.Guests = Backbone.View.extend


    el: '.mainContentProfile'


    # get_my_user: (callback) ->
    #     collection = app.models.Guests
    #         id: $.cookie 'user'
    #     user.fetch
    #         success: ->
    #             callback user

    render: ()->
        that = @
        history.pushState null, 'poputchiki', '/guests/'
        app.views.profile.get_my_user (user) ->
            collection = new app.models.Guests [], id:user.get('id')
            collection.fetch().done () ->
                $ that.$el.html jade.templates.guests
                    user: user.attributes
                    guests: collection.toJSON()
                that.renderGuest guest for guest in collection.models
                $('#menu-photos').addClass 'current'

    renderGuest: (user) ->

        listUserView = new app.views.UserListView 
            model:user,
            template:jade.templates.guest_user_list
        $('.guests .chatLine').append listUserView.render()

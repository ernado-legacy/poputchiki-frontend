app.views.Guests = Backbone.View.extend


    el: '.mainContentProfile'


    # get_my_user: (callback) ->
    #     collection = app.models.Guests
    #         id: $.cookie 'user'
    #     user.fetch
    #         success: ->
    #             callback user

    render: ->
        that = @
        history.pushState null, 'poputchiki', '/guests/'
        app.views.profile.get_my_user (user) ->
            collection = new app.models.Guests [], id:user.get('id')
            #     id: '53afdfad1e74cb0001000004'
            # do collection.fetch
            collection.fetch().done () ->
                # console.log  collection.toJSON()
                $ that.$el.html jade.templates.guests
                    user: user.attributes
                    guests: collection.toJSON()
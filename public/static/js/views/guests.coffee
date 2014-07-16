app.views.Guests = Backbone.View.extend

    el: '.mainContentProfile'

    render: ->
        that = @
        history.pushState null, 'poputchiki', '/guests/'
        app.views.profile.get_my_user (user) ->
            $ that.$el.html jade.templates.guests
                user: user.attributes
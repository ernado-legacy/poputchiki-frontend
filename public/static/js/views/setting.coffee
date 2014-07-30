app.views.Setting = Backbone.View.extend

    el: '.mainContentProfile'

    render: ->
        history.pushState null, 'poputchiki', '/settings/'
        $('.photoVideoBlock').remove()
        that = @
        app.models.myuser.get (user) ->
            # $('.photoVideoBlock').remove()
            $ that.$el.html jade.templates.settings
                user: user.attributes
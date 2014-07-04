app.views.Entered = Backbone.View.extend

    el: 'body'

    render: ->
        $ @.$el.html jade.templates.entered()
        $('body').removeClass 'loginRegisterBody'

    initialize: ->
        that = this
        app.views.login.check_status (result) ->
            if not result
                app.views.login.render()
            else
                do that.render
                app.views.message = new app.views.Message
                app.views.profile = new app.views.Profile
                if window.location.pathname == '/' or window.location.pathname == '/profile/'
                    do app.views.profile.render
                if window.location.pathname == '/message/'
                    do app.views.message.render

$ ->
    app.views.entered = new app.views.Entered
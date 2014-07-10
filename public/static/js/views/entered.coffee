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
                # app.views.messageside = new app.views.MessageSide
                app.views.profile = new app.views.Profile
                app.views.guestprofile = new app.views.GuestProfile
                if window.location.pathname == '/' or window.location.pathname == '/profile/'
                    do app.views.profile.render
                if window.location.pathname == '/message/'
                    do app.views.message.render
                    # do app.views.messageside.render
                if window.location.pathname.search('/user/') != -1
                    do app.views.guestprofile.render
$ ->
    app.views.entered = new app.views.Entered
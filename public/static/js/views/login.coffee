app.views.Login = Backbone.View.extend

    el: 'body'

    events:
        "click .blogin": "login"
        "click #header-exit": "logout"

    check_status: (callback) ->
        if Boolean $.cookie 'token'
            app.models.myuser.check 'token', callback
        else
            callback false

    logout: ->
        $.removeCookie 'token',  path: '/' 
        $.removeCookie 'user',  path: '/'
        
        do @render

    render: ->
        $ @.$el.html jade.templates.login()
        $('body').addClass 'loginRegisterBody'
        history.pushState null, 'poputchiki', '/login/'

    # initialize: ->
    #    that = @
    #    @check_status (result) ->
    #        if not result
    #            that.render()
    #        else
    #            app.views.entered = new app.views.Entered
    #            do app.views.entered.render
    #            app.views.profile = new app.views.Profile
    #            do app.views.profile.render

    login: ->
        $('.loginRegisterBlock').removeClass 'shiv-block'
        app.models.login $(".loginRegisterBlock").serialize()
            , (data) ->
                # $.cookie 'token', data['token']
                # $.cookie 'user', data['id']

                $.cookie('token', data['token'], { expires: 7, path: '/' });
                # $.cookie('user', data['id'], { expires: 7, path: '/' });
                app.models.myuser.check data.id

                do app.views.entered.render
                app.views.profile = new app.views.Profile
                do app.views.profile.render
                console.log data
            , (data) ->
                $('.loginRegisterBlock').addClass 'shiv-block'
                do $('span.error').show 
                return

    seturl: ->


$ ->
    app.views.login = new app.views.Login
    if window.location.pathname == '/login/'
        do app.views.login.render
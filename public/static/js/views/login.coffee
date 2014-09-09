app.views.Login = Backbone.View.extend

    el: 'body'

    events:
        "click .blogin": "login"
        "click #header-exit": "logout"
        "click #forgot-password": "forgot_password"
        'click .box': 'remember'

    check_status: (callback) ->
        if Boolean $.cookie 'token'
            app.models.myuser.check 'token', callback
        else
            callback false

    logout: ->
        $.removeCookie 'token',  path: '/' 
        #$.removeCookie 'user',  path: '/'
        do app.models.myuser.clear
        do @render

    render: ->
        $ @.$el.html jade.templates.login()
        $('body').addClass 'loginRegisterBody'
        history.pushState null, 'poputchiki', '/login/'

    forgot_password: ->
        that = @
        app.models.login $(".loginRegisterBlock").serialize()
            ,(data)=>
                $('.loginRegisterBlock').toggleClass 'shiv-block'
                console.log  'имейл уже зарегистрирован'
                return
            ,(data)=>
                if data.status!=404
                    console.log 'forgor'
                    forgotemail = new app.models.ForgotEmail
                    forgotemail.set 'email', $('#login').val()
                    forgotemail.save {},
                        success: ->
                            that.$el.find('.enterContainer').html jade.templates.forgot_password_success()
                            # $('span.error .error-text').text 'Вам на почту должно уведомление'
                            # do $('span.error').show
                else
                    $('span.error .error-text').text ' Пользователя с таким email не сущетсвует'
                    do $('span.error').show


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

                do app.views.entered.init
                #do app.views.entered.render
                app.views.profile = new app.views.Profile
                do app.views.profile.render
                #console.log data
            , (data) ->
                $('.loginRegisterBlock').addClass 'shiv-block'
                do $('span.error').show
                return

    remember: (event) ->
        $(event.target).toggleClass('checked')

    seturl: ->


$ ->
    app.views.login = new app.views.Login
    if window.location.pathname == '/login/'
        do app.views.login.render
app.views.Register = Backbone.View.extend

    el: 'body'

    events:
        'click #header-profile': 'bregister'
        'click .regstepone': 'regstepone'
        'click .regsteptwo': 'regsteptwo'
        'click .regstepthree': 'regstepthree'
        'click .loginbutton': 'loginbutton'

    render: (n) ->
        switch n
            when 1
                $ @.$el.html jade.templates.registration()
            when 2 
                $ @.$el.html jade.templates.reg2()
            when 3
                $ @.$el.html jade.templates.reg3()
            when 4
                $ @.$el.html jade.templates.reg4()

    regstepone: ->
        @reghash = $('form.loginRegisterBlock').serialize()
        @render 2

    regsteptwo: ->
        arr = $('form.loginRegisterBlock').serializeArray()
        @updatehash = arr[0].value + ' ' + arr[1].value
        @render 3

    regstepthree: ->
        that = @
        app.models.register @reghash
            , (data) ->
                that.render 4
            # , (data) ->
            #    alert 'Неправильный пароль'

    bregister: ->
        @render 1

    loginbutton: ->
        app.views.login.render()
        event.preventDefault()

$ ->
    app.views.register = new app.views.Register
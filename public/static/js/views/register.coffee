app.views.Register = Backbone.View.extend

    el: 'body'

    events:
        'click #header-profile': 'bregister'
        'click .regstepone': 'regstepone'
        'click .regsteptwo': 'regsteptwo'
        'click .regstepthree': 'regstepthree'

    render: (n) ->
        switch n
            when 1
                $ @.$el.html jade.templates.registration()
            when 2 
                $ @.$el.html jade.templates.reg2()
            when 3
                $ @.$el.html jade.templates.reg3()

    regstepone: ->
        @reghash = $('form.loginRegisterBlock').serialize()
        @render 2

    regsteptwo: ->
        arr = $('form.loginRegisterBlock').serializeArray()
        @updatehash = arr[0].value + ' ' + arr[1].value
        @render 3

    # regstepthree: ->

    bregister: ->
        @render 1

$ ->
    app.views.register = new app.views.Register
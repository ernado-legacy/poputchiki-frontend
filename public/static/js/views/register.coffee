app.views.Register = Backbone.View.extend

    el: 'body'

    events:
        'click #header-profile': 'bregister'
        'click .regstepone': 'regstepone'
        'click .regsteptwo': 'regsteptwo'
        'click .regstepthree': 'regstepthree'
        'click .loginbutton': 'loginbutton'
        'click .photo-load button': 'photoload'
        'change #imgfile': 'changeimg'

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
        $('body').addClass 'loginRegisterBody'  

    regstepone: ->
        @reghash = $('form.loginRegisterBlock').serialize()
        @render 2
        @newtag '#year-select'
        @newtag '#month-select'
        @newtag '#day-select'
        @newtag '#city-select'
        $('.box').click ->
            $('.box').toggleClass('checked')

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

    photoload: ->
        do event.preventDefault
        $ '#imgfile'
            .trigger 'click'

    changeimg: ->    
        do event.preventDefault
        form = $ '.loginRegisterBlock'
        data = new FormData form.get(0)
        that = this
        $.ajax
            'url': '/api/photo',
            'type': 'POST',
            'data': data,
            'cache': false,
            'processData': false,
            'contentType': 'false',
            success: (data) ->
                console.log data

    newtag: (box) ->
        hide = (box) ->


        $(box).click ->
            if $(box).hasClass("opened")
                $(box).children(".du").css display: "none"
                $(box).children(".dd").css display: "block"
                $(box).children(".droped").slideUp "slow"
                $(box).addClass "withShadow"
                $(box).removeClass "opened"
            else
                $(".opened").each ->
                    $(this).addClass "withShadow"
                    $(this).removeClass "opened"
                    $(this).children(".droped").slideUp "slow"
                    $(this).children(".du").css display: "none"
                    $(this).children(".dd").css display: "block"

                $(box).children(".dd").css display: "none"
                $(box).children(".du").css display: "block"
                $(box).children(".droped").slideDown "slow"
                $(box).removeClass "withShadow"
                $(box).addClass "opened"

        $(box).children('.droped').children('.dl').click ->
            text = $(this).text()
            $(this).parent().parent().children('span').text(text)
            # event.preventDefault()
            # event.stopPropagation()

$ ->
    app.views.register = new app.views.Register
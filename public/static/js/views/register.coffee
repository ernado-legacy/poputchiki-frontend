app.views.Register = Backbone.View.extend _.extend app.mixins.UserValidationMixin,

    el: 'body'

    events:
        'click .header-profile-register': 'bregister'
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
        history.pushState null, 'poputchiki', '/register/'
        $("#ri-grid").gridrotator
            rows: 6
            columns: 8
            maxStep: 2
            interval: 2000
            w1024:
                rows: 6
                columns: 6

            w768:
                rows: 8
                columns: 5

            w480:
                rows: 9
                columns: 4

            w320:
                rows: 8
                columns: 2

            w240:
                rows: 5
                columns: 1

    addErrorToInputContainer: (inputtag,error_message)->
        emailinput = inputtag.parent('.input')
        emailinput.addClass 'error'
        emailinput.children('.error-text').text error_message

    removeErrorToInputContainer: (inputtag)->
        emailinput = inputtag.parent('.input')
        emailinput.removeClass 'error'

    addErrorToFormLine: (inputtag,error_message)->
        emailinput = inputtag.parent('.form-line')
        emailinput.addClass 'error'
        error_text = emailinput.children('.error-text')
        error_info = error_text.children('.error-info')
        error_info.text error_message

    removeErrorToFormLine: (inputtag)->
        emailinput = inputtag.parent('.form-line')
        emailinput.removeClass 'error'

    regstepone: ->
        @reg_attrs = {}
        @reg_attrs['email'] =  $(".loginRegisterBlock #email").val()
        @reg_attrs['password'] =  $(".loginRegisterBlock #password-reg").val()

        errors =  @validate @reg_attrs
        if errors
            $('.loginRegisterBlock').toggleClass 'shiv-block'
            if 'email' in _.keys(errors)
                @addErrorToInputContainer $('#email'), errors.email
            else
                @removeErrorToInputContainer $('#email')
            if 'password' in _.keys(errors)
                @addErrorToInputContainer $('#password-reg'), errors.password
            else
                @removeErrorToInputContainer $('#password-reg')


        if _.size(errors) < 1
            app.models.login $(".loginRegisterBlock").serialize()
                ,(data)=>
                    $('.loginRegisterBlock').toggleClass 'shiv-block'
                    @addErrorToInputContainer $('#email'), 'имейл уже зарегистрирован'
                    return
                ,(data)=>
                    if data.status!=404
                        $('.loginRegisterBlock').toggleClass 'shiv-block'
                        @addErrorToInputContainer $('#email'), 'имейл уже зарегистрирован'
                        return
                    else
                        @reghash = $('form.loginRegisterBlock').serialize()
                        @render 2
                        @newtag '#year-select'
                        @newtag '#month-select'
                        @newtag '#day-select'
                        #@newtag '#city-select'
                        sc = @$el.find '.countryEdit'
                        scv = new app.views.AutocompleteCountry
                            el: sc
                        sct = @$el.find '.cityEdit'
                        sctv = new app.views.AutocompleteCity
                            el: sct
                        sctv.country = scv
                        $('.box').click ->
                            $('.box').toggleClass('checked')

    getDate: (date_block)->
        d = date_block.find('#day-edit-select').text()
        m = date_block.find('#month-edit-select').text()
        m = $("li:contains('"+m+"')").attr 'month'
        y = date_block.find('#year-edit-select').text()
        y+"-"+m+"-"+d+"T00:00:00Z"

    regsteptwo: ->
        arr = $('form.loginRegisterBlock').serializeArray()
        date_block = $('#birdth-reg')
        d = date_block.find('#day-edit-select').text()
        m = date_block.find('#month-edit-select').text()
        m = $("li:contains('"+m+"')").attr 'month'
        y = date_block.find('#year-edit-select').text()
        birthday = y+"-"+m+"-"+d+"T00:00:00Z"

        user = new app.models.User
        attrs =
            name: arr[0].value
            birthday: birthday
            city: $('#city-select input').val()
            phone: $('#tel').val()
            country: $('#country-reg input').val()
            city: $('#city-select input').val()
            sex: if $('form.loginRegisterBlock .man .box').hasClass('checked') then 'male' else 'female'

        @validate attrs
        errors = @validate attrs
        if errors
            $('.loginRegisterBlock').toggleClass 'shiv-block'
            console.log errors
            if 'name' in _.keys(errors)
                @addErrorToFormLine $('input[name=name]'), errors.name
            else
                @removeErrorToFormLine $('input[name=name]')

            if 'phone' in _.keys(errors)
                @addErrorToFormLine $('#tel'), errors.phone
            else
                @removeErrorToFormLine $('#tel')

            if 'city' in _.keys(errors)
                console.log 'city errors'
                @addErrorToFormLine $('#city-select'), errors.city
            else
                @removeErrorToFormLine $('#city-select')

            if 'country' in _.keys(errors)
                console.log 'country errors'
                @addErrorToFormLine $('#country-select'), errors.country
            else
                @removeErrorToFormLine $('#country-select')

            # if 'password' in _.keys(errors)
            #     @addErrorToInputContainer $('#password-reg'), errors.password
            # else
            #     @removeErrorToInputContainer $('#password-reg')
        else
            user.set attrs

            @updatehash = attrs
               # name: arr[0].value + ' ' + arr[1].value
               # birthday: $('#day-edit-select').text() + ' ' + $('#month-edit-select').text() + ' ' + $('#year-edit-select').text()
               # city: $('#city-edit-select').text()
               # phone: $('#tel').text()
            that = @
            app.models.register @reghash, (data) ->
                $.cookie 'token', data['token']
                that.id = data['id']
                arr = $('form.loginRegisterBlock').serializeArray()

                # date_block = $('#birdth-reg')
                # d = date_block.find('#day-edit-select').text()
                # m = date_block.find('#month-edit-select').text()
                # m = $("li:contains('"+m+"')").attr 'month'
                # y = date_block.find('#year-edit-select').text()
                # birthday = y+"-"+m+"-"+d+"T00:00:00Z"

                user = new app.models.User that.updatehash
                user.set 'id', that.id
                    # id: $.cookie 'user'
                    # name: arr[0].value + ' ' + arr[1].value
                    # birthday: birthday
                    # city: $('#city-edit-select').text()
                    # phone: $('#tel').text()
                # user.set 'avatar', data.id
                user.save()
                that.render 3
# # =======
# #         that = @
# #         app.models.register @reghash, (data) ->
# #             $.cookie 'token', data['token']
# #             that.id = data['id']
# #             #$.cookie 'user', data['id']
# #             arr = $('form.loginRegisterBlock').serializeArray()

# #             date_block = $('#birdth-reg')
# #             d = date_block.find('#day-edit-select').text()
# #             m = date_block.find('#month-edit-select').text()
# #             m = $("li:contains('"+m+"')").attr 'month'
# #             y = date_block.find('#year-edit-select').text()
# #             birthday = y+"-"+m+"-"+d+"T00:00:00Z"

# #             user = new app.models.User
# #                 id: that.id
# #                 name: arr[0].value + ' ' + arr[1].value
# #                 birthday: birthday
# #                 city: $('#city-edit-select').text()
# #                 phone: $('#tel').text()
# #             user.set 'avatar', data.id
# #             user.save()
# #             that.render 3
# # >>>>>>> e9372896a8888898652128ccfef7ee31c7014894
# =======
#         # @updatehash = 
#         #    name: arr[0].value + ' ' + arr[1].value
#         #    birthday: $('#day-edit-select').text() + ' ' + $('#month-edit-select').text() + ' ' + $('#year-edit-select').text()
#         #    city: $('#city-edit-select').text()
#         #    phone: $('#tel').text()
#         that = @
#         app.models.register @reghash, (data) ->
#             $.cookie 'token', data['token']
#             that.id = data['id']
#             #$.cookie 'user', data['id']
#             arr = $('form.loginRegisterBlock').serializeArray()

#             date_block = $('#birdth-reg')
#             d = date_block.find('#day-edit-select').text()
#             m = date_block.find('#month-edit-select').text()
#             m = $("li:contains('"+m+"')").attr 'month'
#             y = date_block.find('#year-edit-select').text()
#             birthday = y+"-"+m+"-"+d+"T00:00:00Z"

#             user = new app.models.User
#                 id: that.id
#                 name: arr[0].value + ' ' + arr[1].value
#                 birthday: birthday
#                 city: $('#city-select .search-select').val()
#                 country: $('#country-select .search-select').val()
#                 phone: $('#tel').text()
#             user.set 'avatar', data.id
#             user.save()
#             that.render 3
# >>>>>>> 9078d3c2353977a73b35156f5c4aa1f7c1774373

    

    regstepthree: ->
        # that = @
        # app.models.register @reghash
        #    , (data) ->
        #        that.render 4
            # , (data) ->
            #    alert 'Неправильный пароль'
        @render 4

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
            'contentType': false,
            dataType: "json"
            success: (data) ->
                user = new app.models.User
                    id: that.id
                user.set 'avatar', data.id
                user.save()
                $('.img img').attr 'src', data.url

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
    if window.location.pathname == '/register/'
        app.views.register.render 1
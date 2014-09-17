app.views.Stripe = Backbone.View.extend

    el: '.mainTopContainer'

    events:
        'click .crsItem': 'clickstripe'
    #     #'click .audio': 'play_audio'
    #     #'click .video': 'play_video'

    set_coockie: ->
        # detect webp support
        if Modernizr.webp
            $.cookie "webp", "1",
                path: '/'
        else
            $.cookie "webp", "0",
                path: '/'

        # detect html5 audio format support

        # priority to aac
        #q = true
        #$.cookie "audio", "mp3", { path: '/' } if Modernizr.audio.mp3
        if Modernizr.audio.ogg
            $.cookie "audio", "ogg", { path: '/' }
        else
            $.removeCookie 'audio',  path: '/' 
            #q = false
        #if Modernizr.audio.m4a
            #$.cookie "audio", "m4a", { path: '/' }
            #q = false
        #is_safari = navigator.userAgent.indexOf("Safari") > -1
        #$.cookie "audio", "m4a", { path: '/' }  if q

        # detect html5 video support
        $.cookie "video", "mp4", { path: '/' } if Modernizr.video.h264

        # priority to webm
        $.cookie "video", "webm", { path: '/' } if Modernizr.video.webm

    ###
    stopMedia: ->
        $('.audio').children().each ->
            this.pause()
            this.currentTime = 0
        $('.video').parent().children('.videoBox').children('video').each ->
            this.pause()
            this.currentTime = 0
            $('.video').parent().parent().children().children('img').removeAttr 'style'
            $('.video').parent().parent().children().children('.videoBox').removeAttr 'style'

    showProgress: (button) ->
        $('.wrapper').removeClass('wrapper1')
        $('.c_left').removeClass('circle1')
        $('.c_right').removeClass('circle2')
        $(button).parent().children('.wrapper').addClass('wrapper1')
        $(button).parent().children('.wrapper').children('.c_left').addClass('circle1')
        $(button).parent().children('.wrapper').children('.c_right').addClass('circle2')

    play_audio: (event) ->
        #@stopMedia()
        @showProgress event.target
        z = $(event.target)
        
        if z.hasClass('audio-change-avatar')
            z.children().bind 'timeupdate', ->
                track_length = $(event.target).children().get(0).duration
                secs = $(event.target).children().get(0).currentTime
                progress = (secs/track_length) * 100
                $(event.target).next().children().css 'width', progress + '%'
        setTimeout (->
                z.children().get(0).play()
                return
            ), 2000
        return

    play_video: (event) ->
        @stopMedia()
        animImg = $(event.target).parent().children("img")
        animVideo = $(event.target).parent().children(".videoBox")
        @showProgress event.target
        animImg.css "opacity", "0"
        setTimeout (->
            animVideo.children("video").get(0).play()
            return
        ), 2000
        animVideo.children("video").get(0).onended = ->
            setTimeout (->
                animVideo.removeAttr "style"
                animImg.removeAttr "style"
                $(".wrapper").removeClass "wrapper1"
                $(".c_left").removeClass "circle1"
                $(".c_right").removeClass "circle2"
                return
            ), 1000
        return
    ###

    render: ->
        @set_coockie()
        stripes = new app.models.Stripes()
        stripes.fetch
            success: =>
                app.models.myuser.get (user) =>
                    @$el.html jade.templates.top_bar
                        items: stripes.models
                        user: user
                        caudio: $.cookie "audio"
                        cvideo: $.cookie "video"
                        cwebp: $.cookie "webp"
                    # console.log 'stripe item'
                    # console.log stripes.models[2]
                    $('.promoPopup .changeAvatarBox .crsItem').remove()
                    $('.promoPopup .changeAvatarBox #promo-add-photo').attr 'src',user.get 'avatar_url'
                    $('.promoPopup .price span').text user.get 'balance'
                    $('.carouselBox .crsItem').first().hide()
                    $('.carouselBox .crsItem').first().show('slide',{dicrection:'left'})
                    $('.promoPopup .choose-photo').addClass('active')
                    $('.promoPopup .choose-audio').addClass('active')
                    $('.promoPopup .choose-video').addClass('active')
                    for i in [0..2]
                        $('.promoPopup .changeAvatarBox').append jade.templates.top_bar_crs_item
                            item:stripes.models[i]
                            caudio: $.cookie "audio"
                            cvideo: $.cookie "video"
                            cwebp: $.cookie "webp"
                    if $(window).width() >= 1730
                        $('.carouselBox').css 'width', '1496px'
                    else
                        wdth = ($('.topContainer').width() - 210).toString() + 'px'
                        $('.carouselBox').css 'width', wdth
                    cw = ($('.mainCrs').length * 136 - 408).toString() + 'px'
                    $(".carousel").css "width", cw

    clickstripe: (event) ->
        # console.log 123
        et = $(event.target)
        if et.hasClass('audio') or et.hasClass('video')
            return true
        link = $(event.currentTarget).find('.link-to-user').data 'href'
        #window.location.href = link
        history.pushState null, 'poputchiki', link
        do app.views.guestprofile.render

        # app.views.guestprofile.set_user $(event.currentTarget).attr 'data-user-id'
        # do app.views.guestprofile.render

app.views.StripePopup = Backbone.View.extend

    el: '.promoPopup'

    events:
        'click .upload-new-audio': 'audio'
        'click .add-to-promo': 'addtopromo'
        'click .chooseBox .regButton': 'addtopromo'
        

    audio: ->
        app.models.myuser.get (user) =>
            #console.log user
            if user.get 'audio_url'
                do @clearpromo
                box = @$el.find '.playerBox'
                audio = box.find 'audio'
                audio.html ''
                audio.html '<source src="' + user.get('audio_url') + '">'
                #source.attr 'src', user.get 'audio_url'
                box.css 'display', 'block'
                $('.promoPopup .changeAvatarBox #promo-add-photo').attr 'src',user.get 'avatar_url'
                $('.promoPopup .choose-photo').removeClass 'active'
                $('.promoPopup .choose-audio').removeClass 'active'
                $('.promoPopup .choose-video').removeClass 'active'
                $('.promoPopup .choose-audio').addClass 'active'

    clearpromo: ->
        box = @$el.find '.playerBox'
        box.css 'display', 'none'
        $('.promoPopup .changeAvatarBox').removeAttr 'data-id'
        $('.promoPopup .videoContainer').removeAttr 'data-id'

    addtopromo: ->
        box = @$el.find '.playerBox'
        if box.css('display')=='block'
            app.models.myuser.get (user) =>
                id = user.get 'audio'
                type = 'audio'
                model = new app.models.Stripe
                    id: id
                    type: type
                model.url = -> "/api/stripe"
                model.save {},
                    success: ->
                        app.views.entered.closepopuprun()
                        do app.views.stripe.render
                        

                    error: (data, textStatus, jqXHR) =>
                        element = @$el.find('.price')
                        element.html('Недостаточно <small>попиков</small>')
                        element.addClass 'alert'

        photoatr = $('.promoPopup .changeAvatarBox').attr 'data-id'
        if photoatr
            id = photoatr
            type = 'photo'
            model = new app.models.Stripe
                id: id
                type: type
            model.url = -> "/api/stripe"
            model.save {},
                success: ->
                    app.views.entered.closepopuprun()
                    do app.views.stripe.render
        videoatr = $('.promoPopup .videoContainer').attr 'data-id'
        if videoatr
            id = videoatr
            type = 'video'
            model = new app.models.Stripe
                id: id
                type: type
            model.url = -> "/api/stripe"
            model.save {},
                success: ->
                    app.views.entered.closepopuprun()
                    do app.views.stripe.render

app.views.StripechopPopup = Backbone.View.extend _.extend app.mixins.UploadPhoto,

    el: '.chopPopup'

    events:
        'click .upl': 'upl'
        'change .photovideoformfile': 'uplc'

    upl: ->
        do event.preventDefault
        @$el.find '.photovideoformfile'
            .trigger 'click'

    uplc: ->
        url = if @param.video then '/api/video' else '/api/photo'
        @uploadphoto url, '.uplfrm', (data) =>
            @update @param.video, @param.ava

    update: (video, ava) ->
        @param =
            video: video
            ava: ava
        id = app.models.myuser.getid()
        if video
            collection = new app.models.Videos id
        else
            collection = new app.models.Photos id
        collection.fetch().done () =>
            hash = collection.groupBy (val, index) ->
                Math.floor index / 3
            arrays = _.map hash, (item) -> item
            @$el.find('form .wrp').html jade.templates.popup_choose_item
                arrays: arrays
                video: video
            _.each @$el.find('.imgBox'), (item) ->
                activaPromoChoice = (id) ->
                    $('.promoPopup .choose-photo').removeClass 'active'
                    $('.promoPopup .choose-audio').removeClass 'active'
                    $('.promoPopup .choose-video').removeClass 'active'
                    $('.promoPopup .'+id).addClass 'active'
                view = new app.views.StripePhoto
                    el: item
                    #clck: ->
                    #    id = @$el.attr 'data-id'
                    #    $('.changeAvatarBox').attr 'data-id', id
                    #    $('.popup').fadeIn('slow')
                    #    $('.chopPopup').fadeOut('slow')
                if not video
                    if not ava
                        view.change = ->
                            do app.views.stripepopup.clearpromo
                            id = @$el.attr 'data-id'
                            img_src = @$el.data 'media-url'
                            $(".promoPopup #promo-add-photo").attr 'src', img_src
                            console.log @$el
                            $('.promoPopup .changeAvatarBox').attr 'data-id', id
                            $('.popup').fadeOut('slow')
                            $('.promoPopup').fadeIn('slow')
                            activaPromoChoice 'choose-photo'
                    else
                        view.change = ->
                            app.models.myuser.get (user) =>
                                id = @$el.attr 'data-id'
                                user.set 'avatar', id
                                user.save {},
                                    success: ->
                                        user.fetch
                                            success: ->
                                                do app.views.profile.render
                                do app.views.entered.closepopuprun
                else
                    view.change = ->
                        do app.views.stripepopup.clearpromo
                        id = @$el.attr 'data-id'
                        thumb_src = @$el.data 'thumb-url'
                        video_src = @$el.data 'media-url'
                        # $('.promoPopup .videoBox video source').attr 'src', video_src
                        $('.promoPopup .videoBox video').remove()
                        $('.promoPopup .videoBox').append('<video><source src="'+video_src+'"></video>')
                        $('.promoPopup .videoContainer .crsItem img').attr 'src', thumb_src
                        $(".promoPopup #promo-add-photo").attr 'src', thumb_src
                        # $('.promoPopup .videoBox video').append '<source src="'+video_src+'"></source>'
                        $('.promoPopup .videoContainer').attr 'data-id', id
                        $('.popup').fadeOut('slow')
                        $('.promoPopup').fadeIn('slow')
                        activaPromoChoice 'choose-video'


app.views.StripePhoto = Backbone.View.extend

    events:
        'click': 'clck'

    clck: ->
        do @change


    #clck: ->
    #    id = @$el.attr 'data-id'
    #    if @$el.attr('data-video') == 'true'
    #        type = 'video'
    #    else
    #        type = "photo"
    #    model = new app.models.Stripe
    #        id: id
    #        type: type
    #    model.url = -> "/api/stripe"
    #    model.save {},
    #        success: ->
    #            app.views.entered.closepopuprun()
    #            do app.views.stripe.render
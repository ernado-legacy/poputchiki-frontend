app.views.Stripe = Backbone.View.extend

    el: '.mainTopContainer'

    events:
        'click .crsItem': 'clickstripe'
        #'click .audio': 'play_audio'
        #'click .video': 'play_video'

    set_coockie: ->
        # detect webp support
        if Modernizr.webp
          $.cookie "webp", "1"
        else
          $.cookie "webp", "0"

        # detect html5 audio format support
        $.cookie "audio", "ogg"  #if Modernizr.audio.ogg

        # priority to aac
        #$.cookie "audio", "aac"  if Modernizr.audio.aac

        # detect html5 video support
        #$.cookie "video", "mp4"  if Modernizr.video.h264

        # priority to webm
        $.cookie "video", "webm"  #if Modernizr.video.webm

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

    clickstripe: (event) ->
        app.views.guestprofile.set_user $(event.currentTarget).attr 'data-user-id'
        do app.views.guestprofile.render

app.views.StripePopup = Backbone.View.extend

    el: '.promoPopup'

    events:
        'click .upload-new-audio': 'audio'
        'click .add-to-promo': 'addtopromo'

    audio: ->
        app.models.myuser.get (user) =>
            #console.log user
            if user.get 'audio_url'
                box = @$el.find '.playerBox'
                audio = box.find 'audio'
                audio.html ''
                audio.html '<source type="audio/ogg" src="' + user.get('audio_url') + '">'
                #source.attr 'src', user.get 'audio_url'
                box.css 'display', 'block'

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

app.views.StripechopPopup = Backbone.View.extend

    el: '.chopPopup'

    #events:
    #    '': ''

    update: (video) ->
        id = app.models.myuser.getid()
        if video
            collection = new app.models.Videos id
        else
            collection = new app.models.Photos id
        collection.fetch().done () =>
            hash = collection.groupBy (val, index) ->
                Math.floor index / 3
            arrays = _.map hash, (item) -> item
            @$el.find('form').html jade.templates.popup_choose_item
                arrays: arrays
                video: video
            _.each @$el.find('.imgBox'), (item) ->
                view = new app.views.StripePhoto
                    el: item

app.views.StripePhoto = Backbone.View.extend

    events:
        'click': 'clck'

    clck: ->
        id = @$el.attr 'data-id'
        if @$el.attr('data-video') == 'true'
            type = 'video'
        else
            type = "photo"
        model = new app.models.Stripe
            id: id
            type: type
        model.url = -> "/api/stripe"
        model.save {},
            success: ->
                app.views.entered.closepopuprun()
                do app.views.stripe.render
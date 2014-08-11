app.views.Stripe = Backbone.View.extend

    el: '.mainTopContainer'

    events:
        'click .audio': 'play_audio'
        'click .video': 'play_video'

    set_coockie: ->
        # detect webp support
        if Modernizr.webp
          $.cookie "webp", "1"
        else
          $.cookie "webp", "0"

        # detect html5 audio format support
        $.cookie "audio", "ogg"  if Modernizr.audio.ogg

        # priority to aac
        $.cookie "audio", "aac"  if Modernizr.audio.aac

        # detect html5 video support
        $.cookie "video", "mp4"  if Modernizr.video.h264

        # priority to webm
        $.cookie "video", "webm"  if Modernizr.video.webm

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

app.views.StripePopup = Backbone.View.extend

    el: '.promoPopup'


app.views.StripechopPopup = Backbone.View.extend

    el: '.chopPopup'

    #events:
    #    '': ''

    update: ->
        collection = new app.models.Photos app.models.myuser.getid()
        collection.fetch().done () =>
            hash = collection.groupBy (val, index) ->
                Math.floor index / 3
            arrays = _.map hash, (item) -> item
            @$el.find('form').html jade.templates.popup_choose_item
                arrays: arrays
            _.each @$el.find('.imgBox'), (item) ->
                view = new app.views.StripePhoto
                    el: item

app.views.StripePhoto = Backbone.View.extend

    events:
        'click': 'clck'

    clck: ->
        id = @$el.attr 'data-id'
        model = new app.models.Stripe
            id: id
            type: "photo"
        model.url = -> "/api/stripe"
        model.save {},
            success: ->
                app.views.entered.closepopuprun()
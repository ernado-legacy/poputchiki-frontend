app.views.Entered = Backbone.View.extend

    el: 'body'

    events:
        'click #header-journeys': 'search'
        # 'click .header-profile-statuses': 'guests'
        'click .header-profile-statuses': 'statuses'
        'click .audio': 'play_audio'
        'click .video': 'play_video'
        'click .leftMenu li': 'changemenu'

    showMenu: (end) ->
        anim = document.getElementById("left-menu")
        anim.addEventListener(end, ( event ) ->
            if $('.leftMenu li').width() > 60
                $('.leftMenu li span').addClass 'visibleSpan'
            else
                $('.leftMenu li span').removeClass 'visibleSpan'
            
        ,false)

    setmenuitem: (item) ->
        $('.leftMenu li').removeClass('current');
        $(item).addClass('current');

    changemenu: (event) ->
        menuhash =
            'menu-messgaes': app.views.message
            'menu-favorites': app.views.favorite
            # 'menu-photos': app.views.photo
            'menu-rating': app.views.rating
            'menu-tools': app.views.setting

        id = event.currentTarget.id
        view = menuhash[id]
        do view.render

    render: ->
        $ @.$el.html jade.templates.entered()
        $('body').removeClass 'loginRegisterBody'
        @showMenu 'webkitTransitionEnd'
        @showMenu 'oTransitionEnd'
        @showMenu 'MSAnimationEnd'
        @showMenu 'transitionend'

    init: ->
        that = this
        app.views.login.check_status (result) ->
            if not result
                app.views.login.render()
            else
                do that.render
                app.views.message = new app.views.Message
                app.views.messageside = new app.views.MessageSide

                app.views.profile = new app.views.Profile
                app.views.guestprofile = new app.views.GuestProfile
                app.views.search = new app.views.Search

                app.views.statuses = new app.views.Statuses
                app.views.user_photo_block = new app.views.UserPhotoBlock
                
                app.views.favorite = app.views.Favorite
                # app.views.photo = app.views.Photo
                app.views.rating = app.views.Rating
                app.views.setting = app.views.Setting

                app.views.guests = new app.views.Guests

                if window.location.pathname == '/' or window.location.pathname == '/profile/'
                    do app.views.profile.render
                if window.location.pathname.search('/message/') != -1
                    do app.views.message.render
                    do app.views.messageside.render
                if window.location.pathname.search('/user/') != -1
                    do app.views.guestprofile.render

                if window.location.pathname.search('/guests/') != -1
                    do app.views.guestprofile.render

    search: ->
        # app.models.search
        #    offset: 0
        #    count: 20
        #    , ->
                do app.views.search.render
                app.views.searchside = new app.views.SearchSide
                do app.views.searchside.render

    statuses: ->
        do app.views.statuses.render

    guests: ->
        do app.views.guests.render

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
        @stopMedia()
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
$ ->
    app.views.entered = new app.views.Entered
    app.views.entered.init()

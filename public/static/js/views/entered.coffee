app.views.Entered = Backbone.View.extend

    el: 'body'

    events:
        'click #header-journeys': 'search'
        # 'click .header-profile-statuses': 'guests'
        'click .header-profile-statuses': 'statuses'
        'click .audio': 'play_audio'
        'click .video': 'play_video'
        'click .leftMenu li': 'changemenu'
        'click #profile-arrow-left': 'carousel_left'
        'click #profile-arrow-right': 'carousel_right'
        'click #profile-arrow-up': 'carousel_up'
        'click #profile-arrow-down': 'carousel_down'
        'click .closeChat': 'closechat'
        'click #profile-rating': 'rating_popup'
        'click .userBox img': 'promo_popup'
        'click #change-avatar': 'chava_popup'
        'click #menu-go': 'letsgo_popup'
        'click .videoBox img': 'video_popup'
        'click .imgGrid .photo-wrapper': 'imggrid_popup'
        'click #search-slideup': 'left_sup'
        'click #search-slidedown': 'left_sdown'
        'click .season': 'season'
        'click #my-profile .money-icon': 'moneyIcon'
        'click .nearBox .money-icon': 'moneyIcon'
        'click #my-profile .house-icon': 'houseIcon'
        'click .nearBox .house-icon': 'houseIcon'
        'click .videoHeader': 'video_header'
        'click .photoHeader': 'photo_header'
        'click .searchBody .dd': 'open_box'
        'click .searchBody .du': 'close_box'
        'click .searchBody .dl': 'select_box'
        'focus .ageBox input': 'activeAgeBox'
        'focusout .ageBox input': 'deactiveAgeBox'
        'click #profile-slidedown': 'show_about'
        'click #profile-slideup': 'hide_about'

    showMenu: (end) ->
        anim = document.getElementById("left-menu")
        anim.addEventListener(end, ( event ) ->
            if $('.leftMenu li').width() > 60
                $('.leftMenu li span').addClass 'visibleSpan'
            else
                $('.leftMenu li span').removeClass 'visibleSpan'
            
        ,false)

    resizeonload: ->
        $(window).load ->
            if $(window).width() >= 1730
                $('.carouselBox').css 'width', '1440px'
            else
                wdth = ($('.topContainer').width() - 210).toString() + 'px'
                $('.carouselBox').css 'width', wdth
            cw = ($('.mainCrs').length * 160).toString() + 'px'
            $(".carousel").css "width", cw

        $(window).resize ->
            if $(window).width() >= 1730
                $('.carouselBox').css 'width', '1440px'
            else
                wdth = ($('.topContainer').width() - 210).toString() + 'px'
                $('.carouselBox').css 'width', wdth

    removetag: ->
        $(document).on "click", ".close", ->
            $(this).parent().remove()  unless $(this).parent().hasClass("newTag")

    scrollmenu: ->
        $(window).scroll ->
            if window.pageYOffset >= 270
                $(".menuBox").css "top", "30px"
                $(".menuBox").css "position", "fixed"
            else
                $(".menuBox").removeAttr "style"

    setmenuitem: (item) ->
        $('.leftMenu li').removeClass('current');
        $(item).addClass('current');

    changemenu: (event) ->
        menuhash =
            'menu-messgaes': app.views.message
            'menu-favorites': app.views.favs
            'menu-photos': app.views.guests
            'menu-rating': app.views.rating
            'menu-tools': app.views.setting

        $('.leftMenu li').removeClass 'current'
        $(event.currentTarget).addClass 'current'

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
        @resizeonload()
        @scrollmenu()
        @removetag()
        @closepopup '#send-lg-popup'
        @closepopup '.closepopup'
        @closepopup '.save-new-ava-audio'

        $("#edit-status").click ->
            $("#main-status").slideUp "slow"
            $(".statusBoxEdit").slideDown "slow"

        $('.promo-photo').click ->
            $('.popup').fadeOut('slow')
            $('.chopPopup').fadeIn('slow')

        $('.choose-promo-photo').click ->
            $('.popup').fadeOut('slow')
            $('.promoPopup').fadeIn('slow')

        $('.imgRow .imgBox').click ->
            $('.imgRow .imgBox').removeClass 'chosenImg'
            $(this).addClass 'chosenImg'

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

                app.views.searchside = new app.views.SearchSide

                app.views.statuses = new app.views.Statuses
                app.views.user_photo_block = new app.views.UserPhotoBlock
                
                app.views.favorite = app.views.Favorite
                # app.views.photo = app.views.Photo
                app.views.rating = app.views.Rating
                app.views.setting = new app.views.Setting

                app.views.guests = new app.views.Guests
                app.views.favs = new app.views.Favs

                if window.location.pathname == '/' or window.location.pathname == '/profile/'
                    do app.views.profile.render
                if window.location.pathname.search('/message/') != -1
                    do app.views.message.render
                    do app.views.messageside.render
                if window.location.pathname.search('/user/') != -1
                    do app.views.guestprofile.render

                if window.location.pathname.search('/guests/') != -1
                    do app.views.guestprofile.render
                if window.location.pathname.search('/statuses/') != -1
                    do app.views.statuses.render

                if window.location.pathname.search('/favourites/') != -1
                    do app.views.guestprofile.render

    search: ->
        # app.models.search
        #    offset: 0
        #    count: 20
        #    , ->
                do app.views.search.render
                do app.views.searchside.render

    season: ->
        if $(event.target).hasClass('season')
            $(event.target).toggleClass 'seasonChecked'
        else
            $(event.target).parent().toggleClass 'seasonChecked'

    moneyIcon: ->
        $(event.target).toggleClass 'mg-icon'

    houseIcon: ->
        $(event.target).toggleClass 'hg-icon'

    statuses: ->
        do app.views.statuses.render

    guests: ->
        do app.views.guests.render

    open_box: ->
        $(event.target).css display: "none"
        $(event.target).next().css display: "block"
        $(event.target).next().next().slideDown "slow"
        $(event.target).parent().addClass "opened"

    close_box: ->
        $(event.target).css display: "none"
        $(event.target).prev().css display: "block"
        $(event.target).next().slideUp "slow"
        $(event.target).parent().removeClass "opened"

    select_box: ->
        text = $(event.target).text()
        country = $(event.target).parent().parent().children("input")
        country.val text
        country.focus()
        $(event.target).parent().parent().children(".du").css display: "none"
        $(event.target).parent().parent().children(".dd").css display: "block"
        $(event.target).parent().parent().children(".droped").slideUp "slow"
        $(event.target).parent().parent().removeClass "opened"
        country.focus ->
            @selectionStart = @selectionEnd = @value.length

    show_about: ->
        $(event.target).css "display", "none"
        $(".profileInfoBox .infoView").slideDown "slow"
        $("#profile-slideup").css "display", "block"

    hide_about: ->
        $(event.target).css display: "none"
        $("#profile-slidedown").css display: "block"
        $(".profileInfoBox .infoView").slideUp "slow"

    video_header: ->
        $('.activeHeader').removeClass 'activeHeader'
        if $(event.target).hasClass '.videoHeader'
            $(event.target).addClass 'activeHeader'
        else if $(event.target).hasClass '.title'
            $(event.target).parent().addClass 'activeHeader'
        else
            $(event.target).parent().parent().addClass 'activeHeader'
        $('.photoBox').hide()
        $('.videoBox').show()

    photo_header: ->
        $('.activeHeader').removeClass 'activeHeader'
        if $(event.target).hasClass '.photoHeader'
            $(event.target).addClass 'activeHeader'
        else if $(event.target).hasClass '.title'
            $(event.target).parent().addClass 'activeHeader'
        else
            $(event.target).parent().parent().addClass 'activeHeader'
        $('.videoBox').hide()
        $('.photoBox').show()

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

    carousel_left: ->
        $(".carouselBox").animate
            scrollLeft: "+=480"
            , "slow"

    carousel_right: ->
        $(".carouselBox").animate
            scrollLeft: "-=480"
            , "slow"

    carousel_up: ->
        z = $('.photoHeader')
        if z.hasClass 'activeHeader'
            $('.photoBox .photoBoxWrapper').animate
                scrollTop: "-=480"
                , "slow"
        else
           $('.videoBox .photoBoxWrapper').animate
                scrollTop: "-=480"
                , "slow"

    carousel_down: ->
        z = $('.photoHeader')
        if z.hasClass 'activeHeader'
            $('.photoBox .photoBoxWrapper').animate
                scrollTop: "+=480"
                , "slow"
        else
           $('.videoBox .photoBoxWrapper').animate
                scrollTop: "+=480"
                , "slow"

    closechat: (event) ->
        $(event.target).parent().parent().remove()

    showpopup: (popup) ->
        #$(cnt).click ->
        $('body').addClass 'bodyPopup'
        $('.popupBack').fadeIn('slow')
        $('.popupWrapper').fadeIn('slow')
        $(popup).fadeIn('slow')

    closepopup: (btn) ->
        $(btn).click ->
            $('body').removeClass 'bodyPopup'
            $('.popup').fadeOut('slow')
            $('.popupWrapper').fadeOut('slow')
            $('.popupBack').fadeOut('slow')

    rating_popup: ->
        @showpopup('.ratingPopup')

    promo_popup: ->
        @showpopup('.promoPopup')

    chava_popup: ->
        @showpopup('.chavaPopup')

    letsgo_popup: ->
        @showpopup('.letsgoPopup')

    video_popup: ->
        @showpopup('.videoPopup')

    imggrid_popup: ->
        @showpopup('.photoPopup')

    left_sup: ->
        $("#my-folowers").slideUp "slow"
        $("#my-wishes").slideDown "slow"

    left_sdown: ->
        $("#my-folowers").slideDown "slow"
        $("#my-wishes").slideUp "slow"

    activeAgeBox: ->
        $(event.target).parent().addClass 'activeAgeBox'
        
    deactiveAgeBox: ->
        $(event.target).parent().removeClass 'activeAgeBox'
$ ->
    app.views.entered = new app.views.Entered
    app.views.entered.init()

app.views.Entered = Backbone.View.extend _.extend app.mixins.SlideRigtBlock,

    el: 'body'

    events:
        'click .show-vip': 'vip_popup'
        'click #header-journeys': 'search'
        # 'click .header-profile-statuses': 'guests'
        'click .header-profile-statuses': 'statuses'
        'click .go-to-statuses': 'statuses'
        'click .audio': 'play_audio'
        'click .video': 'play_video'
        'click .leftMenu li': 'changemenu'
        'click #profile-arrow-left': 'carousel_left'
        'click #profile-arrow-right': 'carousel_right'
        'click #profile-arrow-up': 'carousel_up'
        'click #profile-arrow-down': 'carousel_down'
        'click .closeChat': 'closechat'
        'click #profile-rating': 'rating_popup'
        'click #menu-rating': 'rating_popup'
        'click .userBox': 'promo_popup'
        'click .open-promo': 'promo_popup'
        'click #change-avatar': 'chava_popup'
        'click #menu-go': 'letsgo_popup'
        'click .menu-settings': 'settings'
        'click .imgGrid .photo-wrapper': 'imggrid_popup'
        'click #search-slideup': 'left_sup'
        'click #search-slidedown': 'left_sdown'
        # 'click .season': 'season'
        'click #searchBox .nearBox .money-icon': 'moneyIcon'
        'click #searchBox .nearBox .house-icon': 'houseIcon'
        # 'click .searchBody .dd': 'open_box'
        'click .searchBody .du': 'close_box'
        #'click .searchBody .dl': 'select_box'
        'focus .ageBox input': 'activeAgeBox'
        'focusout .ageBox input': 'deactiveAgeBox'
        'click #profile-slidedown': 'show_about'
        'click #profile-slideup': 'hide_about'
        'click .letsFilter': '_filters'
        'focus .bottomPart input': 'activeChat'
        'click #folowers-tags .searchCountry ul .dl': 'addSearchTag'
        'click .popup-info': 'info_popup'
        'click .mainCrs .wrapper': 'stopMedia'
        'click .likes': 'likers_popup'
        'click .openprofile': 'profilerender'
        'click .box': 'check_box'
        'click .letsgoPopup .popupHeader': 'change_letsgo_header'
        'click .carousel > div': 'play_video'

    change_letsgo_header: (e)->
        $('.letsgoPopup .popupHeader').removeClass 'activeHeader'
        $(e.currentTarget).addClass 'activeHeader'

    check_box: (e)->
        $(e.currentTarget).toggleClass('checked')

    showMenu: (end) ->
        anim = document.getElementById("left-menu")
        anim.addEventListener(end, ( event ) ->
            if $('.leftMenu li').width() > 60
                $('.leftMenu li span').addClass 'visibleSpan'
            else
                $('.leftMenu li span').removeClass 'visibleSpan'
            
        ,false)

    resizeonload: ->
        #$(window).load ->
        #    if $(window).width() >= 1730
        #        $('.carouselBox').css 'width', '1440px'
        #    else
        #        wdth = ($('.topContainer').width() - 210).toString() + 'px'
        #        $('.carouselBox').css 'width', wdth

        $(window).resize ->
            if $(window).width() >= 1730
                $('.carouselBox').css 'width', '1440px'
            else
                wdth = ($('.topContainer').width() - 210).toString() + 'px'
                $('.carouselBox').css 'width', wdth
            h = $('.photoPopup .imgBox img').height()
            w = $('.photoPopup .imgBox img').width()
            x = w*500/h + 40
            if  $(window).width()>= x
            #$('.photoPopup').outerWidth()
                $('.photoPopup .imgBox img').removeClass 'resizePopupImg'
                $('.photoPopup .imgBox').removeClass 'resizePopupImgBox'
                $('.photoPopup').removeClass 'resizePopupPhoto'
                n = ($(window).width() - $('.photoPopup').outerWidth())/2
                $('.photoPopup').css 'margin-left', n
            else
                $('.photoPopup .imgBox img').addClass 'resizePopupImg'
                $('.photoPopup .imgBox').addClass 'resizePopupImgBox'
                $('.photoPopup').addClass 'resizePopupPhoto'
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
        do @slideHide
        menuhash =
            'menu-messgaes': app.views.dialogs
            'menu-favorites': app.views.favs
            'menu-photos': app.views.guests
            'menu-rating': @rating_popup
            'menu-tools': app.views.setting
            'menu-profile': app.views.profile

        $('.leftMenu li').removeClass 'current'
        # $(event.currentTarget).addClass 'current'

        id = event.currentTarget.id
        if id != 'menu-rating'
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
        # @closepopup '#send-lg-popup'
        @closepopup '.closepopup'
        @closepopup '.save-new-ava-audio'
        @closepopup '.popupInnerBack'


        $("#edit-status").click ->
            $("#main-status").slideUp "slow"
            $(".statusBoxEdit").slideDown "slow"

        $(".newStatus").click ->
            $("#main-status").slideUp "slow"
            $(".statusBoxEdit").slideDown "slow"

        $('.promo-photo').click ->
            $('.popup').fadeOut('slow')
            $('.chopPopup').fadeIn('slow')
            app.views.stripechoppopup.update false

        $('.upload-new-video').click ->
            $('.popup').fadeOut('slow')
            $('.chopPopup').fadeIn('slow')
            app.views.stripechoppopup.update true

        #$('.choose-promo-photo').click ->
        #    $('.popup').fadeOut('slow')
        #    $('.promoPopup').fadeIn('slow')p

        $('.imgRow .imgBox').click ->
            $('.imgRow .imgBox').removeClass 'chosenImg'
            $(this).addClass 'chosenImg'

        sc = $ '.letsgoPopup .searchCountry'
        scv = new app.views.AutocompleteCountry
            el: sc

    init: ->
        that = this
        app.views.login.check_status (result) ->
            if not result
                app.views.login.render()
            else
                app.models.myuser.get (user)->
                    if not user.get('avatar')
                        app.views.register.id = user.get('id')
                        app.views.register.render(3)
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

                app.views.dialogs = new app.views.Dialogs
                app.views.guests = new app.views.Guests
                app.views.favs = new app.views.Favs
                app.views.popupphoto = new app.views.PopupPhoto
                app.views.stripepopup = new app.views.StripePopup
                app.views.stripechoppopup = new app.views.StripechopPopup
                app.views.popupaudio = new app.views.PopupAudio
                app.views.stripe = new app.views.Stripe
                app.views.vip = new app.views.VipStatus
                app.views.likers = new app.views.Likers
                app.views.main_status = new app.views.userMainStatus
                app.views.lets_go = new app.views.LetsGo
                

                


                if window.location.pathname == '/guests/'
                    do app.views.guests.render

                if window.location.pathname == '/' or window.location.pathname == '/profile/'
                    do app.views.profile.render
                if window.location.pathname.search('/message/') != -1
                    do app.views.message.render
                    do app.views.messageside.render
                if window.location.pathname.search('/user/') != -1
                    do app.views.guestprofile.render

                if window.location.pathname == '/guests/'
                    do app.views.guests.render
                if window.location.pathname.search('/statuses/') != -1
                    do app.views.statuses.render

                if window.location.pathname.search('/favourites/') != -1
                    do app.views.favs.render

                if window.location.pathname.search('/followers/') != -1
                    do app.views.favs.renderFollowers

                if window.location.pathname.search('/search/') != -1
                    do app.views.search.render
                    # do app.views.searchside.render

                if window.location.pathname.search('/settings/') != -1
                    do app.views.setting.render

                if window.location.pathname.search('/dialogs/') != -1
                    do app.views.dialogs.render

                do app.views.stripe.render

    search: ->
        # app.models.search
        #    offset: 0
        #    count: 20
        #    , ->
        $('.leftMenu li').removeClass 'current'
        do @slideHide
        do app.views.search.render

    settings: (e)->
        @closepopuprun()
        $('.leftMenu li').removeClass 'current'
        do @slideHide
        app.views.setting.render e
                
    addSearchTag: -> 
        newCountry = $(event.target).text()
        #$(this).val ""
        z = "<div class='mainSelectElement searcTagPlaces withShadow'><span class='tagCountry'>" + newCountry + "</span><div class='close'></div></div>"
        $('#tb-f').append z
        $('#folowers-new-tag').val("")
        $(event.target).parent().slideUp('slow')
        $(event.target).parent().prev().css 'display', 'none'
        $(event.target).parent().prev().prev().css 'display', 'block'


    moneyIcon: ->
        if $(event.target).hasClass 'money-icon'
            $(event.target).toggleClass 'mg-icon'

    houseIcon: ->
        if $(event.target).hasClass 'house-icon'
            $(event.target).toggleClass 'hg-icon'

    statuses: ->
        $('.leftMenu li').removeClass 'current'
        do @slideHide
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

    

    stopMedia: ->
        $('.audio').children().each ->
            this.pause()
            #this.currentTime = 0
        $('.video').parent().children('.videoBox').children('video').each ->
            this.pause()
            #this.currentTime = 0
            $('.video').parent().parent().children().children('a').children('img').removeAttr 'style'
            $('.video').parent().parent().children().children('.videoBox').removeAttr 'style'
        $('.vblck video').each ->
            this.pause()

    showProgress: (button) ->
        $('.wrapper').removeClass('wrapper1')
        $('.c_left').removeClass('circle1')
        $('.c_right').removeClass('circle2')
        $(button).parent().children('.wrapper').addClass('wrapper1')
        $(button).parent().children('.wrapper').children('.c_left').addClass('circle1')
        $(button).parent().children('.wrapper').children('.c_right').addClass('circle2')

    play_audio: (event) ->
        console.log 'play audio'
        z = $(event.target)
        if z.children()[0].paused
            @stopMedia()
            @showProgress event.target
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
        else
            @stopMedia()

    play_video: (event) ->
        do event.preventDefault
        animImg = $(event.target).parent().children("a").children("img")
        animVideo = $(event.target).parent().children(".videoBox")
        if animVideo.children("video").get(0).paused
            @stopMedia()
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
        else
            @stopMedia()

    carousel_left: ->
        $(".carouselBox").animate
            scrollLeft: "+=544"
            , "slow"

    carousel_right: ->
        $(".carouselBox").animate
            scrollLeft: "-=544"
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
        $(btn).click (event) =>
            do event.preventDefault
            @closepopuprun()

    closepopuprun: ->
        $('body').removeClass 'bodyPopup'
        $('.popup').fadeOut('slow')
        $('.popupWrapper').fadeOut('slow')
        $('.popupBack').fadeOut('slow')        

    rating_popup: ->
        @showpopup('.ratingPopup')

    vip_popup: ->
        @showpopup('.vipPopup')
        return false


    promo_popup: ->
        @showpopup('.promoPopup')

    chava_popup: ->
        do app.views.popupaudio.render
        # @showpopup('.chavaPopup')

    letsgo_popup: ->
        @showpopup('.letsgoPopup')

    likers_popup: (e)->
        that = @
        likers_url = $(e.currentTarget).data 'likers-url'
        if likers_url
            app.views.likers.render likers_url,()->
                that.showpopup('.popupLikers')
        

    info_popup: (e)->

        $('.popupInfo .infopopup-title').text $(e.currentTarget).data 'infopopup-title'
        $('.popupInfo .infopopup-text').text $(e.currentTarget).data 'infopopup-text'
        @showpopup('.popupInfo')

    info_popup_custom: (header,text)->
        $('.popupInfo .infopopup-title').text header
        $('.popupInfo .infopopup-text').text text
        @showpopup('.popupInfo')

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

    activeChat: ->
        if !($(event.target).parent().parent().hasClass 'darkBlock')
            $('.chatBlock').removeClass 'darkBlock'
            $(event.target).parent().parent().addClass 'darkBlock'

    _filters: ->
        $(event.target).toggleClass 'open-filters'
        if $(event.target).hasClass 'open-filters'
            do @show_filters
        else
            do @hide_filters

    show_filters: ->
        $(event.target).parent().parent().children('.filters').slideDown('slow')

    hide_filters: ->
        $(event.target).parent().parent().children('.filters').slideUp('slow')
    profilerender: ->
        @closepopuprun()
        do app.views.profile.render

$ ->
    app.views.entered = new app.views.Entered
    app.views.entered.init()

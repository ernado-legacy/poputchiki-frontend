app.views.Profile = Backbone.View.extend

    el: '.mainContentProfile'

    get_my_user: (callback) ->
        user = new app.models.User 
            id: $.cookie 'user'
        user.fetch
            success: ->
                callback user

    render: ->
        that = @
        @get_my_user (user) ->
            $ that.$el.html jade.templates.profile
                user: user
            do profile_script

            that.newtag '#year-select'
            that.newtag '#month-select'
            that.newtag '#day-select'
            that.newtag '#city-select'
            that.newtag '#country-select'
            that.showMenu 'webkitTransitionEnd'
            that.showMenu 'oTransitionEnd'
            that.showMenu 'MSAnimationEnd'
            that.showMenu 'transitionend'
            that.activeAgeBox '.ageFrom'
            that.activeAgeBox '.ageTo'
            that.moneyIcon '#my-profile .money-icon'
            that.houseIcon '#my-profile .house-icon'
            that.moneyIcon '.nearBox .money-icon'
            that.houseIcon '.nearBox .house-icon'
            that.showpopup '#menu-go', '.letsgoPopup'
            that.showpopup '.view', '.photoPopup'
            that.showpopup '.videoBox img', '.videoPopup'
            that.closepopup '#send-lg-popup'
            that.closepopup '.closepopup'
            that.season '.season'

            $('.box').click ->
                $(this).toggleClass 'checked'

            $('.videoHeader').click ->
                $('.activeHeader').removeClass 'activeHeader'
                $(this).addClass 'activeHeader'
                $('.photoBox').hide()
                $('.videoBox').show()

            $('.photoHeader').click ->
                $('.activeHeader').removeClass 'activeHeader'
                $(this).addClass 'activeHeader'
                $('.videoBox').hide()
                $('.photoBox').show()


    season: (season) ->
        $(season).click ->
            $(this).toggleClass 'seasonChecked'

    showpopup: (cnt, popup) ->
        $(cnt).click ->
            $('body').addClass 'bodyPopup'
            $('.popupWrapper').fadeIn('slow')
            $(popup).fadeIn('slow')

    closepopup: (btn) ->
        $(btn).click ->
            $('body').removeClass 'bodyPopup'
            $('.popup').fadeOut('slow')
            $('.popupWrapper').fadeOut('slow')

    moneyIcon: (cnt) ->
        $(cnt).click ->
            $(this).toggleClass 'mg-icon'

    houseIcon: (cnt) ->
        $(cnt).click ->
            $(this).toggleClass 'hg-icon'

    newtag: (box) ->
        hide = (box) ->

        $(box).click ->
            if $(box).hasClass("opened")
                $(box).children(".du").css display: "none"
                $(box).children(".dd").css display: "block"
                $(box).children(".droped").slideUp "slow"
                #$(box).addClass "withShadow"
                $(box).removeClass "opened"
            else
                $(".opened").each ->
                    #$(this).addClass "withShadow"
                    $(this).removeClass "opened"
                    $(this).children(".droped").slideUp "slow"
                    $(this).children(".du").css display: "none"
                    $(this).children(".dd").css display: "block"

                $(box).children(".dd").css display: "none"
                $(box).children(".du").css display: "block"
                $(box).children(".droped").slideDown "slow"
                #$(box).removeClass "withShadow"
                $(box).addClass "opened"

        $(box).children('.droped').children('.dl').click ->
            text = $(this).text()
            $(this).parent().parent().children('span').text(text)
            # event.preventDefault()
            # event.stopPropagation()

    showMenu: (end) ->
        anim = document.getElementById("left-menu")
        anim.addEventListener(end, ( event ) ->
            if $('.leftMenu li').width() > 60
                $('.leftMenu li span').addClass 'visibleSpan'
            else
                $('.leftMenu li span').removeClass 'visibleSpan'
            
        ,false)

    activeAgeBox: (cell) ->
        $(cell).children('input').focus( ->
            $(cell).addClass 'activeAgeBox'
        )
        $(cell).children('input').focusout( ->
            $(cell).removeClass 'activeAgeBox'
        )
$ ->
    app.views.profile = new app.views.Profile
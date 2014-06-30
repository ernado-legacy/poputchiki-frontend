app.views.Profile = Backbone.View.extend

    el: '.mainContentProfile'

    get_my_user: (callback) ->
        user = new app.models.User 
            id: $.cookie 'user'
        user.fetch
            success: ->
                console.log user

    render: ->
        user = @get_my_user
        $ @.$el.html jade.templates.profile
            user: user
        do profile_script

        @newtag '#year-select'
        @newtag '#month-select'
        @newtag '#day-select'
        @newtag '#city-select'
        @newtag '#country-select'
        @showMenu 'webkitTransitionEnd'
        @showMenu 'oTransitionEnd'
        @showMenu 'MSAnimationEnd'
        @showMenu 'transitionend'

    newtag: (box) ->
        hide = (box) ->
            $(this).toggleClass('checked')

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

    showMenu: (end) ->
        anim = document.getElementById("left-menu")
        anim.addEventListener(end, ( event ) ->
            if $('.leftMenu li').width() > 60
                $('.leftMenu li span').addClass 'visibleSpan'
            else
                $('.leftMenu li span').removeClass 'visibleSpan'
            
        ,false)

$ ->
    app.views.profile = new app.views.Profile
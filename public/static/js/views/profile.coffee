app.views.Profile = Backbone.View.extend

    el: '.mainContentProfile'

    initialize: ->
        @.model = new app.models.User 
            id: $.cookie 'user'
        @.model.fetch()

        @.listenTo @.model, 'change:name', ->
            name_container = @.$el.find '.name-in-profile'
            name_container.text @model.get 'name'
        return

    get_my_user: (callback) ->
        user = new app.models.User 
            id: $.cookie 'user'
        user.fetch
            success: ->
                callback user

    render: ->
        that = @
        history.pushState null, 'poputchiki', '/profile/'
        @get_my_user (user) ->
            console.log user.id
            app.views.user_photo_block.render(user.id)

            $ that.$el.html jade.templates.profile
                user: user.attributes
            do profile_script
            that.newtag '#year-select'
            that.newtag '#month-select'
            that.newtag '#day-select'
            that.newtag '#city-select'
            that.newtag '#country-select'
            # that.showMenu 'webkitTransitionEnd'
            # that.showMenu 'oTransitionEnd'
            # that.showMenu 'MSAnimationEnd'
            # that.showMenu 'transitionend'
            that.activeAgeBox '.ageFrom'
            that.activeAgeBox '.ageTo'
            that.moneyIcon '#my-profile .money-icon'
            that.houseIcon '#my-profile .house-icon'
            that.moneyIcon '.nearBox .money-icon'
            that.houseIcon '.nearBox .house-icon'
            that.showpopup '#menu-go', '.letsgoPopup'
            that.showpopup '.view', '.photoPopup'
            that.showpopup '.videoBox img', '.videoPopup'
            that.showpopup '#change-avatar', '.chavaPopup'
            that.showpopup '.userBox img', '.promoPopup'
            that.showpopup '#profile-rating', '.ratingPopup'
            that.closepopup '#send-lg-popup'
            that.closepopup '.closepopup'
            that.closepopup '.save-new-ava-audio'
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

            $('.promo-photo').click ->
                $('.popup').fadeOut('slow')
                $('.chopPopup').fadeIn('slow')

            $('.choose-promo-photo').click ->
                $('.popup').fadeOut('slow')
                $('.promoPopup').fadeIn('slow')

            $('.imgRow .imgBox').click ->
                $('.imgRow .imgBox').removeClass 'chosenImg'
                $(this).addClass 'chosenImg'

    season: (season) ->
        $(season).click ->
            $(this).toggleClass 'seasonChecked'

    showpopup: (cnt, popup) ->
        $(cnt).click ->
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

    # showMenu: (end) ->
    #    anim = document.getElementById("left-menu")
    #    anim.addEventListener(end, ( event ) ->
    #        if $('.leftMenu li').width() > 60
    #            $('.leftMenu li span').addClass 'visibleSpan'
    #        else
    #            $('.leftMenu li span').removeClass 'visibleSpan'
    #        
    #    ,false)

    activeAgeBox: (cell) ->
        $(cell).children('input').focus( ->
            $(cell).addClass 'activeAgeBox'
        )
        $(cell).children('input').focusout( ->
            $(cell).removeClass 'activeAgeBox'
        )

    events: 
        "click #profile-edit-slideup span": 'saveProfile'
        "click #my-profile .money-icon": 'setSponsor'
        "click #my-profile .house-icon": 'setHost'
        "click .myProfileContainer .season": 'setSeasons'

    setSeasons: ()->
        @model.set('seasons',[])
        seasons = @$el.find '#my-seasons .season'
        @model.get('seasons').push(season.id)  for season in seasons when $(season).hasClass('seasonChecked')
        # console.log($(season).id)  for season in seasons
        do @model.save
        return

    saveProfile: ->
        formData = {}

        inputs = $('.infoEdit input')
        about_text = $('.infoEdit textarea').val()

        appendFormData = (el) ->
            int_value = parseInt $(el).val()
            value = if isNaN int_value then $(el).val() else int_value
            # value =  if isNaN parseInt($(el).val()) then  $(el).val()) else parseInt($(el).val())
            formData[el.name] = value

        appendFormData input for input in inputs when $(input).val()

        formData['country'] = $('#country-edit-select').text()
        formData['city'] = $('#city-edit-select').text()
        formData['birthday'] = @getDate $('#birtday-edit')
        formData['about'] = about_text
        @model.set(formData)
        @model.save()
        return

    setSponsor: ->
        @model.save 'is_sponsor', @$el.find('.money-icon').hasClass 'mg-icon' 
    setHost: ->
        @model.save 'is_host', @$el.find('.house-icon').hasClass 'hg-icon'
    getDate: (date_block)->
        d = date_block.find('#day-edit-select').text()
        m = date_block.find('#month-edit-select').text()
        m = $("li:contains('"+m+"')").attr 'month'
        y = date_block.find('#year-edit-select').text()
        y+"-"+m+"-"+d+"T00:00:00Z"

$ ->
    app.views.profile = new app.views.Profile
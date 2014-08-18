app.views.Profile = Backbone.View.extend _.extend app.mixins.SlideRigtBlock,

    el: '.mainContentProfile'

    initialize: ->
        # @.model = new app.models.User 
        #     id: $.cookie 'user'
        # @.model.fetch()

        # @.listenTo @.model, 'change:name', ->
        #     name_container = @.$el.find '.name-in-profile'
        #     name_container.text @model.get 'name'
        return

    get_my_user: (callback) ->
        app.models.myuser.get callback

    render: ->
        that = @
        history.pushState null, 'poputchiki', '/profile/'
        @get_my_user (user) =>
            user.updateDate {},'birthday'
            that.model = user
            app.views.user_photo_block.render(user.id, true)

            $ that.$el.html jade.templates.profile
                user: user.attributes

            app.views.main_status.render user
            # do profile_script
            that.newtag '#year-select'
            that.newtag '#month-select'
            that.newtag '#day-select'
            #that.newtag '#city-select'
            #that.newtag '#country-select'
            that.showInputDrop '.newCountry'
            that.hideInputDrop '.newCountry'
            that.openTagWithInput '.newCountry'
            #that.addSearchTag '.newCountry ul .dl', '#profile-new-tag', '#profile-tags', 1

            sc = @$el.find '.countryEdit'
            scv = new app.views.AutocompleteCountry
                el: sc
            sct = @$el.find '.cityEdit'
            sctv = new app.views.AutocompleteCity
                el: sct
            sctv.country = scv

            $("#edit-profile").click ->
                $("#about-in-info").css "display", "none"
                $("#profile-slideup").css "display", "none"
                $(".profileInfoBox .infoView").css "display", "none"
                $(".profileInfoBox .infoEdit").slideDown "slow"
                $("#profile-slidedown").css display: "none"
                $("#profile-edit-slideup").css "display", "block"

            $("#profile-edit-slideup").click ->
                $(this).css "display", "none"
                $(".profileInfoBox .infoEdit").slideUp "slow"
                $("#profile-slidedown").css display: "block"
                $("#about-in-info").css "display", "block"

            $("#write-new-main-status").click ->
                status = $("#new-status").val()
                $("#main-status").children(".status").text status
                $("#main-status").slideDown "slow"
                $(".statusBoxEdit").slideUp "slow"

            sc = @$el.find '.newTagBox .newCountry'
            scv = new app.views.AutocompleteCountry
                el: sc
            scv.oldtags = '#profile-tags'
            scv.afterchange = () ->
                newCountry = @$el.find('input').val()
                unless newCountry is ""
                    $(this).val ""
                    z = "<div class='mainSelectElement searcTagPlaces withShadow'><span class='tagCountry'>" + newCountry + "</span><div class='close'></div></div>"
                    #if variant is 1
                    $(@oldtags).append z
                    #else
                    #    $(@oldtags).prepend z
                    @$el.find('input').val ''
                #$(newtag).val("")

            # sc = @$el.find '.searchCountry'
            # scv = new app.views.AutocompleteCountry
            #     el: sc
            # sct = @$el.find '.searchCity'
            # sctv = new app.views.AutocompleteCity
            #     el: sct

    addSearchTag: (list, newtag, oldtags, variant) ->
        $(list).click ->
            newCountry = $(this).text()
            unless newCountry is ""
                $(this).val ""
                z = "<div class='mainSelectElement searcTagPlaces withShadow'><span class='tagCountry'>" + newCountry + "</span><div class='close'></div></div>"
                if variant is 1
                    $(oldtags).append z
                else
                    $(oldtags).prepend z
            $(newtag).val("")



    showInputDrop: (box) ->
        $(box).children(".dd").click ->
            $(this).css display: "none"
            $(this).next().css display: "block"
            $(this).next().next().slideDown "slow"
            $(this).parent().addClass "opened"

    hideInputDrop: (box) ->
        $(box).children(".du").click ->
            $(this).css display: "none"
            $(this).prev().css display: "block"
            $(this).next().slideUp "slow"
            $(this).parent().removeClass "opened"

    openTagWithInput: (box) ->
        $(box).children(".droped").children(".dl").click ->
            text = $(this).text()
            country = $(this).parent().parent().children("input")
            country.val text
            country.focus()
            $(box).children(".du").css display: "none"
            $(box).children(".dd").css display: "block"
            $(box).children(".droped").slideUp "slow"
            $(box).removeClass "opened"
            country.focus ->
                @selectionStart = @selectionEnd = @value.length

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

    events: 
        "click #profile-edit-slideup span": 'saveProfile'
        "click #my-profile .money-icon": 'setSponsor'
        "click #my-profile .house-icon": 'setHost'
        "click #my-seasons .season": 'setSeasons'
        # 'click #my-profile .money-icon': 'moneyIcon'
        # 'click #my-profile .house-icon': 'houseIcon'

    setSeasons: (e)->
        if $(e.currentTarget).hasClass('season')
            $(e.currentTarget).toggleClass 'seasonChecked'
        else
            $(e.currentTarget).parent().toggleClass 'seasonChecked'

        seasons = @$el.find '#my-seasons .season.seasonChecked'
        new_seasons = []
        new_seasons.push(season.id) for season in seasons

        formData = {}
        formData['seasons'] = new_seasons
        @model.save formData, patch: true
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
        # @model.set()
        @model.save formData, patch: true
        do @render

    setSponsor: (e)->
        $(e.currentTarget).toggleClass 'mg-icon'
        formData = {}
        formData['is_sponsor'] = @$el.find('.money-icon').hasClass 'mg-icon' 
        @model.save formData, patch: true
    setHost: (e)->
        $(e.currentTarget).toggleClass 'hg-icon'
        formData = {}
        formData['is_host'] = @$el.find('.house-icon').hasClass 'hg-icon'
        @model.save formData, patch: true


        # moneyIcon: ->
        # if $(event.target).hasClass 'money-icon'
        #     $(event.target).toggleClass 'mg-icon'

    getDate: (date_block)->
        d = date_block.find('#day-edit-select').text()
        d = '0'+d if d.length == 1
        m = date_block.find('#month-edit-select').text()
        m = $("li:contains('"+m+"')").attr 'month'
        y = date_block.find('#year-edit-select').text()
        y+"-"+m+"-"+d+"T00:00:00Z"

$ ->
    app.views.profile = new app.views.Profile
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

    render: (after)->
        that = @
        history.pushState null, 'poputchiki', '/profile/'
        @get_my_user (user) =>
            app.views.entered.setmenuitem '#menu-profile'
            user.updateDate 'birthday'
            user.updateDate 'vip_till'
            that.model = user
            app.views.user_photo_block.render(user.id, true)

            $ that.$el.html jade.templates.profile
                user: user.attributes

            $('.chavaPopup .changeAvatarBox img').attr 'src',user.get('avatar_url')

            app.views.main_status.render user
            # do profile_script
            that.newtag '#year-select'
            that.newtag '#month-select'
            that.newtag '#day-select'
            that.newtag '#orientation-select'
            that.newtag '#relation-select'
            that.newtag '#children-select'
            that.newtag '#education-select'
            that.newtag '#attitude_to_smoking-select'
            that.newtag '#attitude_to_alcohol-select'
            that.newtag '#wealth-select'
            that.newtag '#accommodation-select'
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

            # sc = @$el.find '#my-folowers .searchCountry'
            # scv = new app.views.AutocompleteCountry
            #     el: sc

            $("#edit-profile").click ->
                $("#about-in-info").css "display", "none"
                $("#profile-slideup").css "display", "none"
                $(".profileInfoBox .infoView").css "display", "none"
                $(".profileInfoBox .infoEdit").slideDown "slow"
                $("#profile-slidedown").css display: "none"
                $("#profile-edit-slideup").css "display", "block"

            $(".edit-profile").click ->
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
                el: sc,
                all_tags: true
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
            app.views.presents.renderUserPresents user.get "id"
            if after
                do after
            # sc = @$el.find '.searchCountry'
            # scv = new app.views.AutocompleteCountry
            #     el: sc
            # sct = @$el.find '.searchCity'
            # sctv = new app.views.AutocompleteCity
            #     el: sct
            do $('#profile-slidedown').click

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
        "click .myProfileContainer .money-icon": 'setSponsor'
        "click .myProfileContainer .house-icon": 'setHost'
        "click .myProfileContainer .invisible-icon": 'setInvisible'
        "click #my-seasons .season": 'setSeasons'
        "click #my-destinations .droped .dl": 'setDestinations'
        "click #my-destinations .close": 'removeDestinations'
        'click #myLeftBox .imgBox': 'chava_popup'
        # 'click #my-profile .money-icon': 'moneyIcon'
        # 'click #my-profile .house-icon': 'houseIcon'

    chava_popup: ->
        do app.views.popupaudio.render

    setDestinations: (e)->
        new_destination = $(e.currentTarget).text()
        destinations = if @model.get('destinations') then @model.get('destinations') else []
        if not _.contains(destinations, new_destination)
            destinations.push new_destination
            @model.set 'destinations', destinations
            @model.save
                success:=>
                    $('#profile-tags').html jade.templates.user_destinations
                        user: @model.attributes


        $('#profile-tags').html jade.templates.user_destinations
            user: @model.attributes

    removeDestinations: (e) ->
        d = $(e.currentTarget).closest('.withShadow').text()
        destinations = @model.get('destinations')
        destinations =  _.without(destinations, d)
        @model.save 
            'destinations': destinations,
            success:=>
                $('#profile-tags').html jade.templates.user_destinations
                    user: @model.attributes
        

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

        formData['country'] = $('#country-select input').val()
        formData['city'] = $('#city-select input').val()
        formData['birthday'] = @getDate $('#birtday-edit')
        formData['about'] = about_text
        additional_fields = 
            'orientation': 'orientation-edit-select',
            'relations': 'relation-edit-select',
            'children': 'relation-edit-select',
            'education': 'education-edit-select',
            'attitude_to_smoking': 'attitude_to_smoking-edit-select',
            'attitude_to_alcohol': 'attitude_to_alcohol-edit-select',
            'wealth': 'wealth-edit-select',
            'accommodation': 'accommodation-edit-select',
            'children':'children-edit-select'
        for key in  _.keys(additional_fields)
            console.log $('#'+additional_fields[key]).text()
            formData[key] = $('#'+additional_fields[key]).text()
        console.log formData
        @model.save formData, patch: true
        do @render

    setSponsor: (e)->
        # if $(e.currentTarget).hasClass 'mg-icon'
        $(e.currentTarget).toggleClass 'mg-icon'
        formData = {}
        formData['is_sponsor'] = @$el.find('.money-icon').hasClass 'mg-icon' 

        @model.save formData, patch: true
    setHost: (e)->
        $(e.currentTarget).toggleClass 'hg-icon'
        formData = {}
        formData['is_host'] = @$el.find('.house-icon').hasClass 'hg-icon'
        @model.save formData, patch: true

    setInvisible: (e)->
        if @model.get('vip')
            $(e.currentTarget).toggleClass 'ig-icon'
            formData = {}
            formData['invisible'] = @$el.find('.invisible-icon').hasClass 'ig-icon' 

            @model.save formData, patch: true
        else
            do app.views.entered.vip_popup

    getDate: (date_block)->
        d = date_block.find('#day-edit-select').text()
        d = '0'+d if d.length == 1
        m = date_block.find('#month-edit-select').text()
        m = $("li:contains('"+m+"')").attr 'month'
        y = date_block.find('#year-edit-select').text()
        y+"-"+m+"-"+d+"T00:00:00Z"

$ ->
    app.views.profile = new app.views.Profile
app.views.Search = Backbone.View.extend _.extend app.mixins.SlideRigtBlock,

    el: '.mainContentProfile'

    events:
        # 'click .searchBox button': 'search'
        'click .profile-search': 'dosearchbubuttonclick'
        # 'click .profile-search': 'render'
        'click a.ldblock': 'link'
        #'click .searchBox .box': 'toogle'
        "click #my-folowers .season": 'setSeasons'
        "click .gallery li": 'link_to_user'
    link_to_user: (e)->
        window.location.href = "/user/"+$(e.currentTarget).data 'user-id'

    dosearchbubuttonclick: ->
        if $('.pagination').length==0 
            do @render
        else 
            do @search 


    setSeasons: (e)->
        if $(e.currentTarget).hasClass('season')
            $(e.currentTarget).toggleClass 'seasonChecked'
        else
            $(e.currentTarget).parent().toggleClass 'seasonChecked'

    search: ->
        $('.pagination').html("<img src='http://poputchiki/static/img/searchpreloader.GIF' class='loading-gif')'>")
        that = this

        query =
            offset: 0
            count: 20
            sex: ""

        from = $('#search-age-from').val()
        to = $('#search-age-to').val()

        searchFormData = {}

        if from
            searchFormData['likings_age_min'] = from*1
            query.agemin = from
        if to
            searchFormData['likings_age_max'] = to*1
            query.agemax = to
        query.sex = if $('.manBox .checked').length == 1 then 'male' else 'female'
        if ($('.manBox .checked').length == 1) and ($('.womanBox .checked').length == 1)
            query.sex = ''
        # query.sex = if ($('.manBox .checked').length == 1) and ($('.womanBox .checked').length == 1)  then ''
        searchFormData['likings_sex'] = query.sex

        # searchFormData['country'] = query.sex $('#search-country-input').val() if  query.sex $('#search-country-input').val()
        # searchFormData['city'] = query.sex $('#search-country-input').val() if query.sex $('#search-country-input').val()
        country = $('#search-country-input').val()
        if country
            searchFormData['likings_country'] = country
            query.country = country
        else
            searchFormData['likings_country'] = ''

        city = $('#search-city-input').val()
        if city
            searchFormData['likings_city'] = city
            query.city = city
        else
            searchFormData['likings_city'] = ''

        host =  $('#my-wishes .house-icon').hasClass 'hg-icon'
        sponsor =  $('#my-folowers .money-icon').hasClass 'mg-icon'
        console.log sponsor
        if host
            query.host = true
        if sponsor
            query.sponsor = true

        destinations = []
        _.each $('.searchBox .tagCountry'), (value, key, list)=>
            console.log value
            destinations.push($(value).text())

        if _.size(destinations) > 0
            searchFormData['likings_destinations'] = destinations
            query.destinations_list = destinations
        else
            searchFormData['likings_destinations'] = []

        seasons = @$el.find '#my-folowers .season.seasonChecked'
        new_seasons = []
        new_seasons.push(season.id) for season in seasons
        query.seasons_list =  new_seasons
        searchFormData['likings_seasons'] = new_seasons

        app.models.myuser.get (user) ->
            # user.set searchFormData
            # do user.save searchFormData,{patch: true}
            user.set searchFormData
            user.save searchFormData, patch: true if _.size(user.changed)>0

        query.avatar = true
        @query = query
        @research 1, (data) =>
            @pagination.render 1 + data.count/20
            @pagination.setreaction (i) => @research i

        that = @
        app.models.searchphoto query,
            (data) ->
                if data.length > 0
                    that.slideHideAndShow ()->
                        do app.views.searchside.render
                        app.views.searchside.renderitems data
                else
                    that.slideHide ()->
        #do @render

    research: (item, callback) ->
        query = @query
        item = item - 1
        query.offset = item * 20
        query.count = 20
        app.models.search query, (data) =>
            @$el.find('.gallery ul').html ''
            @renderSearchingUser  new app.models.User user for user in data.result
                # that.$el.find('.gallery').html jade.templates.search_users 
                #     users: data
            if data.count == 0
                @$el.find('.results small').text('')
                @$el.find('.results small').first().text('Нет пользователей удовлетворяющих запросу')
                @$el.find('.results span.count').text('')
            else
                @$el.find('.results small').text(' попутчик')
                @$el.find('.results small').first().text('найден ')
                @$el.find('.results span.count').text(data.count)
            callback(data) if callback

    renderSearchingUser: (user) ->
        listUserView = new app.views.UserListView 
            model:user,
            template:jade.templates.search_user_list
        # $('.guests .chatLine').append listUserView.render()
        @$el.find('.gallery ul').append listUserView.render()

    toogle: (event) ->
        $(event.currentTarget).toggleClass('checked')

    link: (event) ->
        event.preventDefault()
        app.views.guestprofile.set_user $(event.currentTarget).attr 'data-user-id'
        do app.views.guestprofile.render

    render: ->
        that = @
        history.pushState null, 'poputchiki', '/search/'
        app.views.profile.get_my_user (user) =>
            $ that.$el.html jade.templates.search
                user: user.attributes
            that.pagination = new app.views.Pagination
                el: that.$el.find('.pagination')[0]
            #ms = @$el.find '.mainSelectElement'
            #_.each ms, (item) ->
            #    autocomplete = new app.views.Autocomplete
            #        el: item
            sc = @$el.find '#my-wishes .searchCountry'
            scv = new app.views.AutocompleteCountry
                el: sc
            sct = @$el.find '#my-wishes .searchCity'
            sctv = new app.views.AutocompleteCity
                el: sct
            sctv.country = scv

            sc = @$el.find '#my-folowers .searchCountry'
            scv = new app.views.AutocompleteCountry
                el: sc
            do that.search
        # do @.search

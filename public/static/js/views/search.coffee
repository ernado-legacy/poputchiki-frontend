app.views.Search = Backbone.View.extend

    el: '.mainContentProfile'

    events:
        # 'click .searchBox button': 'search'
        'click .profile-search': 'search'
        'click a.ldblock': 'link'
        'click .box': 'toogle'

    search: ->


        that = this

        query =
            offset: 0
            count: 100
            sex: 'female'

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

        searchFormData['likings_sex'] = query.sex

        app.models.myuser.get (user) ->
            # user.set searchFormData
            console.log searchFormData
            # do user.save searchFormData,{patch: true}
            user.save searchFormData, patch: true


        query.sex = if $('.manBox .checked').length == 1 then 'male' else 'female'

        app.models.search query,
            (data) ->
                that.$el.find('.gallery').html jade.templates.search_users 
                    users: data
        do @render

    toogle: (event) ->
        $(event.currentTarget).toggleClass('checked')

    link: (event) ->
        event.preventDefault()
        app.views.guestprofile.set_user $(event.currentTarget).attr 'data-user-id'
        do app.views.guestprofile.render

    render: ->
        that = @
        history.pushState null, 'poputchiki', '/search/'
        app.views.profile.get_my_user (user) ->
            $ that.$el.html jade.templates.search
                user: user.attributes
        # do @.search

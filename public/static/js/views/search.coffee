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

        if from
            query.agemin = from

        if to
            query.agemax = to

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
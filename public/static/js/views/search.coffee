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

            user.set searchFormData
            user.save searchFormData, patch: true if _.size(user.changed)>0


        query.sex = if $('.manBox .checked').length == 1 then 'male' else 'female'

        app.models.search query,
            (data) ->
                that.renderSearchingUser  new app.models.User user for user in data.result
                # that.$el.find('.gallery').html jade.templates.search_users 
                #     users: data
                that.$el.find('.results small').text(' попутчик')
                that.$el.find('.results small').first().text('найден ')
                that.$el.find('.results span.count').text(data.count)
        do @render

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
        app.views.profile.get_my_user (user) ->
            $ that.$el.html jade.templates.search
                user: user.attributes
        # do @.search

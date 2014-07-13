app.views.Search = Backbone.View.extend

    el: '.mainContentProfile'

    events:
        'click .searchBox button': 'search'
        'click a.ldblock': 'link'
        'click .box': 'toogle'

        $('.box').click ->
            $('.box').toggleClass('checked')

    search: ->
        that = this

        query =
            offset: 0
            count: 100
            sex: 'male'

        form = $('#search-age-from').val()
        to = $('#search-age-to').val()

        if from:
            query.agemin = from

        id to:
            query.agemax = to

        app.models.search
            , (data) ->
                that.$el.find('.gallery').html jade.templates.search_users 
                    users: data

    toogle: (event) ->
        $(event.currentTarget).toggleClass('checked')

    link: (event) ->
        event.preventDefault()
        app.views.guestprofile.set_user $(event.currentTarget).attr 'data-user-id'
        do app.views.guestprofile.render

    render: ->
        $ @$el.html jade.templates.search()
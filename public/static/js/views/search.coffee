app.views.Search = Backbone.View.extend

    el: '.mainContentProfile'

    events:
        'click .searchBox button': 'search'
        'click a.ldblock': 'link'

    search: ->
        that = this
        app.models.search
            offset: 0
            count: 100
            sex: 'male'
            , (data) ->
                that.$el.find('.gallery').html jade.templates.search_users 
                    users: data

    link: (event) ->
        event.preventDefault()
        app.views.guestprofile.set_user $(event.currentTarget).attr 'data-user-id'
        do app.views.guestprofile.render

    render: ->
        $ @$el.html jade.templates.search()
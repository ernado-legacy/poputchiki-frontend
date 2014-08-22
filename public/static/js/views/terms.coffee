app.views.Terms = Backbone.View.extend

    el: 'body'

    render: ->
        app.views.login.check_status (result) =>
            $ @.$el.html jade.templates.terms
                login: result
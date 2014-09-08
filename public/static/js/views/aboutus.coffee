app.views.AboutUs = Backbone.View.extend

    el: 'body'

    render: ->
        app.views.login.check_status (result) =>
            $ @.$el.html jade.templates.aboutus
                login: result
                footerenter: true
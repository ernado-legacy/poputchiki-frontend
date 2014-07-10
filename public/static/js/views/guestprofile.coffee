app.views.GuestProfile = Backbone.View.extend

    el: '.mainContentProfile'

    render: ->
        $ @$el.html jade.templates.guest_profile()
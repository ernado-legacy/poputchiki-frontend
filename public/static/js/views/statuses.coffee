app.views.Statuses = Backbone.View.extend

    el: '.mainContentProfile'

    render: ->
        history.pushState null, 'poputchiki', '/statuses/'
        $ @$el.html jade.templates.statuses()
app.views.Search = Backbone.View.extend

    el: '.mainContentProfile'

    render: ->
        $ @$el.html jade.templates.search()
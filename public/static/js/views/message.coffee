app.views.Message = Backbone.View.extend

    el: '.mainContentProfile'

    generate: ->
        

    render: ->
        history.pushState null, 'poputchiki', '/message/'
        $ @$el.html jade.templates.dialog()

$ ->
    app.views.message = new app.views.Message
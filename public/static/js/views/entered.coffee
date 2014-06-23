app.views.Entered = Backbone.View.extend

    el: 'body'

    render: ->
        $ @.$el.html jade.templates.entered()

$ ->
    app.views.entered = new app.views.Entered
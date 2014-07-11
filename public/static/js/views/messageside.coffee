app.views.MessageSide = Backbone.View.extend

    el: '.photoVideoBlock'

    render: ->
        $ @.$el.html jade.templates.chat_line()
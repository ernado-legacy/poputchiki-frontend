Dialogs = app.models.Dialogs

app.views.MessageSide = Backbone.View.extend

    el: '.photoVideoBlock'

    render: ->
        that = @
        dialogs = new Dialogs
        dialogs.fetch
            success: () ->
                $ that.$el.html jade.templates.chat_line
                    dialogs: dialogs
app.views.MessageSide = Backbone.View.extend

    el: '.photoVideoBlock'

    events: 
        'click ul.chatLine li': 'newdialog'

    render: ->
        $ @$el.html jade.templates.chat_line
            dialogs: app.views.message.dialogs

    newdialog: (event) ->
        app.views.message.newdialog event
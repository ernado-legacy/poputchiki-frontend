app.views.MessageSide = Backbone.View.extend

    el: '.photoVideoBlock'

    events: 
        'click ul.chatLine li': 'newdialog'
        'click #profile-arrow-up': 'carousel_up'
        'click #profile-arrow-down': 'carousel_down'

    render: ->
        $ @$el.html jade.templates.chat_line
            dialogs: app.views.message.dialogs

    newdialog: (event) ->
        app.views.message.newdialog event

    carousel_up: ->
        $('.chatLine').animate
                scrollTop: "-=256"
                , "slow"

    carousel_down: ->
        $('.chatLine').animate
                scrollTop: "+=256"
                , "slow"
app.views.MessageSide = Backbone.View.extend

    el: '.photoVideoBlock'

    events: 
        'click ul.chatLine li': 'newdialog'
        'click #profile-arrow-up': 'carousel_up'
        'click #profile-arrow-down': 'carousel_down'
    initialize: ->
        do @check_unread
        that = @
        @message_interval = setInterval ->
                do that.check_unread
            , 4000

    check_unread: ->
        $.get '/api/user/539ee75ba2f2b60001000006/unread',
            (data)->
                if isNaN(parseInt($('#menu-messgaes .menuIcon.new div').text())) 
                    $('#menu-messgaes .menuIcon.new div').text data.count
                else 
                    if (parseInt($('#menu-messgaes .menuIcon.new div').text()) < data.count)
                        do playSoundNotification
                        $('#menu-messgaes .menuIcon.new div').text data.count

            ,
            'json'

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
app.views.Message = Backbone.View.extend

    el: '.mainContentProfile'

    events:
        'click .pstMsg': 'postmsg'

    render: ->
        history.pushState null, 'poputchiki', '/message/'
        $ @$el.html jade.templates.dialog()

    new_massage: (id) ->
        message = new app.models.Message
        message.url = '/api/user/' + id + '/messages'
        message.set
            id: '539ee75ba2f2b60001000006'
            user: "539ee75ba2f2b60001000006"
            origin: "539ee75ba2f2b60001000006"
            destination: "539ee75ba2f2b60001000006"                 
            text: "mess"
            time: (new Date).toISOString()
        do message.save

    postmsg: () ->
        $('.centerPart').append jade.templates.dialog_record
            text: $('.bottomPart input').val()
        $('.bottomPart input').val ''

$ ->
    app.views.message = new app.views.Message
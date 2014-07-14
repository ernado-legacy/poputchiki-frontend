app.views.Message = Backbone.View.extend

    el: '.mainContentProfile'

    events:
        'click .pstMsg': 'postmsg'

    set_url: (url) ->
        if not url
            url = ''
        url = '/message/' + url
        history.pushState null, 'poputchiki', url

    render: ->
        $ @$el.html jade.templates.dialog()

    new_massage: (id, mess) ->
        url = '/api/user/' + id + '/messages'
        data =
            text: mess
        app.models.newMessage data, url, -> true

    postmsg: () ->
        mess = $('.bottomPart input').val()
        id = window.location.pathname.split('/').slice(2)[0]
        $('.centerPart').append jade.templates.dialog_record
            text: mess
        $('.bottomPart input').val ''
        @new_massage id, mess

$ ->
    app.views.message = new app.views.Message
app.views.Message = Backbone.View.extend

    el: '.mainContentProfile'

    events:
        'click .pstMsg': 'postmsg'
        'click .closeChat': 'closechat'

    set_url: (url) ->
        if not url
            url = ''
        url = '/message/' + url
        history.pushState null, 'poputchiki', url

    render: ->
        if window.location.pathname.search('message') == -1
            @set_url ''
            #do app.views.messageside.render
        Dialogs = app.models.Dialogs
        @dialogs = new Dialogs
        @messages = {}
        app.views.entered.setmenuitem '#menu-messgaes'
        $ @$el.html jade.templates.dialog()
        do @reupdate
        iduser = window.location.pathname.split('/').slice(2)[0]
        if _.size iduser
            user = new app.models.User
            user.set 'id', iduser
            user.fetch
                success: =>
                    $('.chatContainer').append jade.templates.dialog_item
                        dialog: app.views.popupphoto.changeuser user

    new_massage: (id, mess) ->
        url = '/api/user/' + id + '/messages'
        data =
            text: mess
        app.models.newMessage data, url, -> true

    render_message: (cb, h)->
        cp = cb.find '.centerPart'
        cp.append jade.templates.dialog_record h
        div = cp[0]
        div.scrollTop = div.scrollHeight;

    postmsg: (event) ->
        cb = $(event.currentTarget).parents('.chatBlock')
        input = cb.find('input')
        mess = input.val()
        input.val ''
        user = cb.attr 'data-user'
        @render_message cb,
            text: mess
            author: 'Вы'
        @new_massage user, mess

    du: (id) ->
        '[data-user="' + id + '"]'

    updatemess: (count) ->
        that = @
        @olddialogssize = _.size @dialogs.models
        @dialogs.fetch
            success: () ->
                if that.olddialogssize < _.size that.dialogs.models
                    do app.views.messageside.render
                _.each that.dialogs.models, (dialog) ->
                    messages = new app.models.Messages
                    messages.urluser = dialog.get 'id'
                    messages.fetch
                        success: ->
                            if count == 0
                                that.messages[messages.urluser] = messages
                            if not that.messages[messages.urluser] or _.size(that.messages[messages.urluser].models) < _.size messages.models
                                that.messages[messages.urluser] = messages
                                li = $ '.chatLine li' + that.du messages.urluser
                                cb = $ '.chatBlock' + that.du messages.urluser
                                if not _.size cb
                                    li.addClass 'active'
                                else
                                    cb.remove()
                                    that.updatedialog messages.urluser
                            console.log messages

    reupdate: ->
        that = @
        count = 0
        run = ->
            if window.location.pathname.search('/message/') != -1
                that.updatemess count
                count += 1
            else
                clearInterval @interval
        @interval = setInterval ->
            do run
        , 500
        do run

    newdialog: (event) ->

        $(event.currentTarget).removeClass 'active'
        user = $(event.currentTarget).attr 'data-user'
        @updatedialog user

    updatedialog: (user) ->

        that = @
        get_cb = ->
            $ '.chatBlock' + that.du user

        if _.size get_cb()
            get_cb.remove()
            return

        dialog = @dialogs.find (item) -> user == item.get 'id'
        $('.chatContainer').append jade.templates.dialog_item
            dialog: dialog

        @messages[user].each (mess) =>
            @render_message get_cb(),
                text: mess.get 'text'
                author: if mess.get('origin')==user then dialog.get('name') else 'Вы'

    closechat: (event) ->
        do $(event.currentTarget).parent().parent().remove

$ ->
    app.views.message = new app.views.Message
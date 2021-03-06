app.views.Message = Backbone.View.extend _.extend app.mixins.SlideRigtBlock,

    el: '.mainContentProfile'

    events:
        'click .pstMsg': 'postmsg'
        'click .closeChat': 'closechat'
        'keyup .chatBlock input': 'press'


    chatting_with_user: (user_id)->
        $('.chatBlock').data('user') == user_id


    press: (event)->
        message_btn =  $ '.chatBlock.darkBlock .pstMsg.fui-bubble'
        has_text = if $(event.currentTarget).val().length > 0 then true else false
        if has_text
            message_btn.addClass 'active'
        else
            message_btn.removeClass 'active'
        if event.which==13 and has_text
            do message_btn.click


    set_url: (url) ->
        if not url
            url = ''
        url = '/message/' + url
        history.pushState null, 'poputchiki', url

    render: ->
        if window.location.pathname.search('message') == -1
            @set_url ''
            #do app.views.messageside.render
        app.views.entered.setmenuitem '#menu-messgaes'

        #do @reupdate
        iduser = window.location.pathname.split('/').slice(2)[0]
        user = new app.models.User
        user.set 'id', iduser
        user.fetch
            success: =>
                console.log user.attributes
                $ @$el.html jade.templates.dialog
                    user:user.attributes
                # $('.chatContainer').append jade.templates.dialog_item
                #     dialog: 
                #         get: ->
                #             user.attributes
                    #$('.leftMenu li').removeClass 'current'
                    #$('#menu-messgaes').addClass 'current'
                    #@updatedialog user.get 'id'
                    # this was used
                    # @updatemess 1
                    # this was used
                    #cb = $ '.chatBlock' + @du user.get 'id'
                    #do cb.remove
                    #@updatedialog user.get 'id'
                    # this was used
                    # @reupdate false
                    # this was used

                    @updatedialogbox user.get('id')
        # else
        #     @reupdate true

    new_massage: (id, mess) ->
        url = '/api/user/' + id + '/messages'
        data =
            text: mess
        app.models.newMessage data, url, -> true

    render_message: (cb, h)->
        cp = cb.find '.centerPart'
        cp.append jade.templates.dialog_record h
        if (cp.children().last().find('.recordAuthor').text() == "Вы")
            cp.children().last().find('.recordAuthor').addClass 'myMessage'
            cp.children().last().find('.recordText').addClass 'myMessage'
        div = cp[0]
        div.scrollTop = div.scrollHeight;

    postmsg: (event) ->

        cb = $(event.currentTarget).parents('.chatBlock')
        input = cb.find('input')
        mess = input.val()
        input.val ''
        cb.find('.pstMsg.fui-bubble').removeClass 'active'
        user = cb.attr 'data-user'
        console.log input
        input.click()
        if mess.length > 0
            @render_message cb,
                text: mess
                author: 'Вы',
                invite: false
            @new_massage user, mess

    du: (id) ->
        '[data-user="' + id + '"]'

    updatemess: (count) ->
        # that = @
        # @olddialogssize = _.size @dialogs.models
        # @dialogs.fetch
        #     success: () ->
        if that.olddialogssize < _.size that.dialogs.models
            that.slideHideAndShow ()->
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
                            # do playSoundNotification
                            # li.addClass 'active'
                            
                        else
                            cb.remove()
                            that.updatedialog messages.urluser
                    #console.log messages

    updatedialogbox: (user_id) ->
        that = @
        # @olddialogssize = _.size @dialogs.models
        # @dialogs.fetch
        #     success: () ->
        #         # if that.olddialogssize < _.size that.dialogs.models
        #             # that.slideHideAndShow ()->
        #             #     do app.views.messageside.render
        #             # that.slideHideAndShow ()->
        #             #     do app.views.messageside.render
        app.views.dialogs.get_dialogs (dialogs)->
            that.dialogs = dialogs
            messages = new app.models.Messages
            messages.urluser = user_id
            messages.fetch
                success: ->
                    if messages.length
                        # # that.messages[messages.urluser] = messages
                        if not that.messages[messages.urluser] or _.size(that.messages[messages.urluser].models) < _.size messages.models
                            that.messages[messages.urluser] = messages
                            li = $ '.chatLine li' + that.du messages.urluser
                            cb = $ '.chatBlock' + that.du messages.urluser
                            if not _.size cb
                                # do playSoundNotification
                                # li.addClass 'active'
                                
                            else
                                cb.remove()
                                that.updatedialog messages.urluser


    updatedialogbox2: (user_id) ->
        that = @
        # @olddialogssize = _.size @dialogs.models
        # @dialogs.fetch
        #     success: () ->
        #         # if that.olddialogssize < _.size that.dialogs.models
        #             # that.slideHideAndShow ()->
        #             #     do app.views.messageside.render
        #             # that.slideHideAndShow ()->
        #             #     do app.views.messageside.render
        app.views.dialogs.get_dialogs (dialogs)->
            that.dialogs = dialogs
            messages = new app.models.Messages
            messages.urluser = user_id
            messages.fetch
                success: ->
                    # # that.messages[messages.urluser] = messages
                    if not that.messages[messages.urluser] or _.size(that.messages[messages.urluser].models) < _.size messages.models
                        that.messages[messages.urluser] = messages
                        li = $ '.chatLine li' + that.du messages.urluser
                        cb = $ '.chatBlock' + that.du messages.urluser
                        if not _.size cb
                            # do playSoundNotification
                            # li.addClass 'active'
                            
                        else
                            cb.remove()
                            that.updatemessages messages.urluser

    reupdate: (now) ->
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
        if now
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
            get_cb().remove()
            return

        dialog = @dialogs.find (item) -> user == item.get 'id'
        # app.views.dialogs.decr_unread dialog.get 'unread'
        $('.chatContainer').append jade.templates.dialog_item
            dialog: dialog
        get_cb().addClass 'darkBlock'
        @messages[user].each (mess) =>
            @render_message get_cb(),
                text: mess.get 'text'
                author: if mess.get('origin')==user then dialog.get('name') else 'Вы'
                invite: mess.get 'invite'
    updatemessages: (user) ->

        that = @
        get_cb = ->
            $ '.chatBlock' + that.du user

        # if _.size get_cb()
        #     get_cb().remove()
        #     return

        dialog = @dialogs.find (item) -> user == item.get 'id'
        app.views.dialogs.decr_unread dialog.get 'unread'
        # $('.chatContainer').append jade.templates.dialog_item
        #     dialog: dialog
        get_cb().addClass 'darkBlock'
        @messages[user].each (mess) =>
            @render_message get_cb(),
                text: mess.get 'text'
                author: if mess.get('origin')==user then dialog.get('name') else 'Вы'
                invite: mess.get 'invite'

    closechat: (event) ->
        do $(event.currentTarget).parent().parent().remove

$ ->
    app.views.message = new app.views.Message
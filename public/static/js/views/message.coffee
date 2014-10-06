app.views.Message = Backbone.View.extend _.extend app.mixins.SlideRigtBlock,

    el: '.mainContentProfile'

    events:
        'click .pstMsg': 'postmsg'
        'click .closeChat': 'closechat'
        'keyup .chatBlock input': 'press'


    chatting_with_user: (ws_message_target)->
        if @get_cb().data('user')
            app.views.messageside.update_dialogs(ws_message_target)
            if @user 
                if @get_cb().data('user') == ws_message_target.origin or @get_cb().data('user') == ws_message_target.destination
                    do @updatedialogbox
                    return true
            else
                false
        else
            false


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

    read_messages_in_dialog: ->
        # that = @
        # app.views.dialogs.get_dialogs (dialogs)->
        #     dialog = dialogs.find (item) -> that.user.get('id') == item.get 'id'
        #     if dialog
        #         app.views.dialogs.decr_unread dialog.get 'unread'
        do app.views.dialogs.decr_unread

    render: ->
        if window.location.pathname.search('message') == -1
            @set_url ''
            #do app.views.messageside.render
        app.views.entered.setmenuitem '#menu-messgaes'

        #do @reupdate
        iduser = window.location.pathname.split('/').slice(2)[0]
        @user = new app.models.User
        @user.set 'id', iduser

        @user.fetch
            success: =>
                $ @$el.html jade.templates.dialog
                    user:@user.attributes
                do @updatedialogbox
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
            cp.children().last().find('.recordTime').addClass 'myMessage'
            cp.children().last().find('.fui-radio-checked').addClass 'myMessage'

        if h.invite and (cp.children().last().find('.recordAuthor').text() == "Вы")
            cp.children().last().find('.recordText').text 'Вы пригласили в путешествие'
            cp.children().last().find('.recordAuthor').remove()
        if not h.time
            do cp.children().last().find('.recordTime').remove
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
                invite: false,
                time: ''
            @new_massage user, mess

    du: (id) ->
        '[data-user="' + id + '"]'


    updatedialogbox: ->
        that = @
        # @olddialogssize = _.size @dialogs.models
        # @dialogs.fetch
        #     success: () ->
        #         # if that.olddialogssize < _.size that.dialogs.models
        #             # that.slideHideAndShow ()->
        #             #     do app.views.messageside.render
        #             # that.slideHideAndShow ()->
        #             #     do app.views.messageside.render
        messages = new app.models.Messages
        messages.urluser = @user.get('id')
        messages.fetch
            success: ->
                if messages.length
                    do that.read_messages_in_dialog
                    that.updatemessages messages
                # # # that.messages[messages.urluser] = messages
                # if not that.messages[messages.urluser] or _.size(that.messages[messages.urluser].models) < _.size messages.models
                #     that.messages[messages.urluser] = messages
                #     li = $ '.chatLine li' + that.du messages.urluser
                #     cb = $ '.chatBlock' + that.du messages.urluser
                #     if not _.size cb
                #         # do playSoundNotification
                #         # li.addClass 'active'
                        
                #     else
                #         cb.remove()
                #         that.updatemessages messages.urluser

    newdialog: (event) ->

        $(event.currentTarget).removeClass 'active'
        user = $(event.currentTarget).attr 'data-user'
        @updatedialog user

    get_cb: ->
        $ '.chatBlock'
    updatemessages: (messages) ->

        that = @
        get_cb = ->
            $ '.chatBlock' + that.du user

        # # if _.size get_cb()
        # #     get_cb().remove()
        # #     return


        # # $('.chatContainer').append jade.templates.dialog_item
        # #     dialog: dialog
        # get_cb().addClass 'darkBlock'
        @get_cb().addClass 'darkBlock'
        app.views.message.$el.find('.record').remove()
        _.each messages.models, (mess) =>
            @render_message @get_cb(),
                text: mess.get 'text'
                author: if mess.get('origin')==@user.get('id') then @user.get('name') else 'Вы'
                invite: mess.get 'invite'
                time: mess.get 'time'
        last =  (_.last messages.models)
        if not (last.get('read')) and (last.get('destination')==@user.get('id'))
            @render_message @get_cb(),
                text: ''
                author: @user.get('name')+' еще не прочитал(а) ваше сообщение'
                invite: false
                time: false

    closechat: (event) ->
        do @slideHide
        do app.views.dialogs.render
        # do $(event.currentTarget).parent().parent().remove

$ ->
    app.views.message = new app.views.Message
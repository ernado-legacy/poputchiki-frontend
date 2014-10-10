app.views.Dialogs = Backbone.View.extend

    initialize: ->
        @unread_messges = 0
        @unread_only = false
        @dialogs = undefined
        do @check_unread
        that = @
        # @message_interval = setInterval ->
        #         do that.check_unread
        #     , 4000

        ws_connection.addCallback (data)=>
            
            if data.type=="messages"
                if @dialogs
                    updated_dialog = @dialogs.get(data.target.chat)
                    if updated_dialog
                        unread = updated_dialog.get 'unread'
                        updated_dialog.set 'unread', unread+1
                        updated_dialog.set 'text', data.target.text
                        updated_dialog.set 'time', data.target.time
                    else
                        @dialogs = undefined
                else
                    @dialogs = undefined
                if @is_page_active()
                    do @render
                chatting_with_user = app.views.message.chatting_with_user(data.target)
                if not chatting_with_user
                    if app.models.myuser.getid() == data.target.destination
                        do @incr_unread


    is_page_active: ()->
        app.views.dialogs.$el.find('#dialogs_list').length>0

    incr_unread: ->
        do playSoundNotification
        @unread_messges+=1
        $('#menu-messgaes .menuIcon.new div').text @unread_messges
        do $('#menu-messgaes .menuIcon.new div').show

    decr_unread: (count)->
        do @check_unread
        # @unread_messges-=count
        # if @unread_messges>0
        #     $('#menu-messgaes .menuIcon.new div').text @unread_messges
        # else
        #     @unread_messges = 0
        #     do $('#menu-messgaes .menuIcon.new div').hide

    check_unread: ->
        that = @
        app.models.myuser.get (user)->
            $.get '/api/user/'+user.get('id')+'/unread',
                (data)->
                    if isNaN(parseInt($('#menu-messgaes .menuIcon.new div').text())) 
                        $('#menu-messgaes .menuIcon.new div').text data.count
                    else 
                        if (parseInt($('#menu-messgaes .menuIcon.new div').text()) < data.count)
                            do playSoundNotification
                            $('#menu-messgaes .menuIcon.new div').text data.count
                    if data.count==0
                        do $('#menu-messgaes .menuIcon.new div').hide
                    else
                        do $('#menu-messgaes .menuIcon.new div').show
                    that.unread_messges = data.count
                ,
                'json'


    el: '.mainContentProfile'

    events: 
        'click #get-unread':'renderUnread'
        'click #get-all':'renderAll'




    renderAll: ->
        @unread_only = false
        do @render
        # @$el.find('#get-unread').addClass 'custom-link'
        # @$el.find('#get-all').removeClass 'custom-link'
        # app.views.dialogs.$el.find('.user-item').show()

    renderUnread: ->
        @unread_only = true
        do @render
        # @$el.find('#get-all').addClass 'custom-link'
        # @$el.find('#get-unread').removeClass 'custom-link'
        # _.each app.views.dialogs.$el.find('.user-item'),(element,index)->
        #     do $(element).hide if not $(element).hasClass 'active'

        


    get_dialogs: (callback)->
        if @dialogs
            callback @dialogs
        else
            Dialogs = app.models.Dialogs
            dialogs = new Dialogs
            that = @
            dialogs.fetch().done () ->
                that.dialogs = dialogs
                callback dialogs


    render: ()->
        that = @
        history.pushState null, 'poputchiki', '/dialogs/'
        app.views.profile.get_my_user (user) ->
            user.updateDate 'vip_till'
            
            # collection = new Dialogs
            # collection.fetch().done () ->
            that.get_dialogs (dialogs)->
                $ that.$el.html jade.templates.dialogs
                    user: user.attributes,
                    unread_only: that.unread_only
                
                    # if (not unread_only) or (dialog.get('unread') >0)
                for dialog in dialogs.models
                    if (not that.unread_only) or dialog.get('unread')>0
                        that.renderDialog dialog 
                $('#menu-messgaes').addClass 'current'
                app.views.message.dialogs = dialogs



    renderDialog: (dialog) ->
        user = new app.models.User dialog.get('user')
        user.set 'time', dialog.get('time')
        message_text = dialog.get('text')
        if message_text.length > 45 
            message_text = message_text.substring(0,45)+'...'
        console.log $.emoticons.replace(message_text)
        user.set 'message', $.emoticons.replace(message_text)
        user.updateDate('time')
        if message_text == 'Вас пригласили в путешествие'
            user.set 'invite', true
        else
            user.set 'invite', false
        listUserView = new app.views.UserListView 
            model:user,
            template:jade.templates.dialog_user_list
        if dialog.get('unread')>0
            listUserView.$el.addClass 'active'
        $('#dialogs_list .chatLine').append listUserView.render()

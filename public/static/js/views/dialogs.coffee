app.views.Dialogs = Backbone.View.extend


    el: '.mainContentProfile'

    # events: 
    #     'click #dialogs_list li':'write'
        


    # remove_dialog: ->
    #     console.log 'remove dialog'
    #     false

    # write: (e)->
    #     $(e.currentTarget).find('.write').click()


    # get_my_user: (callback) ->
    #     collection = app.models.Guests
    #         id: $.cookie 'user'
    #     user.fetch
    #         success: ->
    #             callback user

    render: ()->
        that = @
        history.pushState null, 'poputchiki', '/dialogs/'
        # Dialogs = app.models.Dialogs
        # @dialogs = new Dialogs
        # @dialogs.fetch
        #     success: () ->
        #         # console.log  do app.views.messageside.render
        #         app.views.profile.get_my_user (user) ->
        #             console.log user.attributes
        #             $ that.$el.html jade.templates.dialogs
        #                 dialogs: that.dialogs.models
        #                 user:user
        app.views.profile.get_my_user (user) ->
            user.updateDate 'vip_till'
            Dialogs = app.models.Dialogs
            collection = new Dialogs
            collection.fetch().done () ->
                $ that.$el.html jade.templates.dialogs
                    user: user.attributes
                    # dialogs: collection.toJSON()
                that.renderDialog dialog for dialog in collection.models
                $('#menu-messgaes').addClass 'current'

    renderDialog: (dialog) ->
        user = new app.models.User dialog.get('user')
        user.set 'time', dialog.get('time')
        message_text = dialog.get('text')
        if message_text.length > 45 
            message_text = message_text.substring(0,45)+'...'
        user.set 'message', message_text
        user.updateDate('time')
        listUserView = new app.views.UserListView 
            model:user,
            template:jade.templates.dialog_user_list
        if dialog.get('unread')>0
            listUserView.$el.addClass 'active'
        $('.guests .chatLine').append listUserView.render()

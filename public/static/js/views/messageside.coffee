app.views.MessageSide = Backbone.View.extend _.extend app.mixins.SlideRigtBlock,

    el: '.photoVideoBlock'

    events: 
        'click ul.chatLine li': 'newdialog'
        'click #profile-arrow-up': 'carousel_up'
        'click #profile-arrow-down': 'carousel_down'

    render: ->
        that = @
        app.views.dialogs.get_dialogs (dialogs)->
            that.slideHideAndShow ()->
                $ that.$el.html jade.templates.chat_line
                    dialogs: dialogs

    update_dialogs: (target)->
        console.log target
        li = @$el.find('li[data-user="'+target.origin+'"]')
        if li.length
            if not li.hasClass 'opened'
                li.addClass 'active'
        else
            app.views.dialogs.dialogs = undefined
            @render
        # that = @
        # app.views.dialogs.get_dialogs (dialogs)->
        #     $ that.$el.html jade.templates.chat_line
        #         dialogs: dialogs

    newdialog: (event) ->
        app.views.dialogs.get_dialogs (dialogs)->
            for dialog in dialogs.models
                dialog.set('unread',0)
        $(event.currentTarget).removeClass 'active'
        $(event.currentTarget).addClass 'opened'
        user_id =  $(event.currentTarget).data 'user'
        app.views.message.set_url user_id
        do app.views.message.render
        # app.views.message.newdialog event

    carousel_up: ->
        $('.chatLine').animate
                scrollTop: "-=256"
                , "slow"

    carousel_down: ->
        $('.chatLine').animate
                scrollTop: "+=256"
                , "slow"
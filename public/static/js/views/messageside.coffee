app.views.MessageSide = Backbone.View.extend _.extend app.mixins.SlideRigtBlock,

    el: '.photoVideoBlock'

    events: 
        'click ul.chatLine li': 'newdialog'
        'click #profile-arrow-up': 'carousel_up'
        'click #profile-arrow-down': 'carousel_down'

    render: ->
        iduser = window.location.pathname.split('/').slice(2)[0]
        that = @
        app.views.dialogs.get_dialogs (dialogs)->
            that.slideHideAndShow ()->
                $ that.$el.html jade.templates.chat_line
                    dialogs: dialogs
                    iduser: iduser

    update_dialogs: (target)->
        @render
        li = @$el.find('li[data-user="'+target.origin+'"]')
        if li.length
            if not li.hasClass 'opened'
                li.addClass 'active'
                count = parseInt(li.find('.unread_count b').text())
                count+=1
                li.find('.unread_count b').text(count)
                do li.find('.unread_count').show

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
        @$el.find('li').removeClass 'opened'
        $(event.currentTarget).addClass 'opened'
        $(event.currentTarget).find('.unread_count').hide()
        $(event.currentTarget).find('.unread_count b').text(0)
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
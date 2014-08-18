app.views.Photo = Backbone.View.extend

    tagName: 'div'
    className: 'photo-wrapper'
    events: 
        'click': 'clck'
        'click .action-like':'like'
        'click .action-remove-like':'unlike'
        'click .remove-photo': 'removePhoto'
        'click .new-ava': 'removePhoto'

    render: (is_my_user)->
        @listenTo @model, 'changeimg', @changeimg
        that = @
        app.models.myuser.get (user)->
            liked_by = if (user.get('id') in that.model.get('liked_users')) then true else false
            $ that.$el.html jade.templates.photo 
                photo: that.model.toJSON(),
                liked_by: liked_by,
                is_my_user: is_my_user

    clck: ->
        $('body').addClass 'bodyPopup'

        _.each ['.popupBack', '.popupWrapper', '.photoPopup'], (item) ->
            $(item).fadeIn 'slow'

        do @changeimg

    changeimg: ->

        $('.photoPopup .imgBox img').attr 'src', @model.get 'url'
        n = ($(window).width() - $('.photoPopup').width())/2
        $('.photoPopup').css 'margin-left', n

        _.each ['.arrow-left', '.arrow-right', 'img'], (item) ->
            do $('.photoPopup ' + item).unbind

        fix = (index, a, b, change) ->
            if index == a
                b
            else
                index + change      

        react = (t, rl) ->
            index = t.model.collection.indexOf t.model
            smo = t.model.collection.size() - 1
            if rl == 'right'
                index = fix index, smo, 0, 1
            else
                index = fix index, 0, smo, -1
            t.model.collection.models[index].trigger 'changeimg'

        $('.photoPopup .arrow-right').click =>
            react @, 'left'

        $('.photoPopup .arrow-left').click =>
            react @, 'right'

        $('.photoPopup img').click =>
            react @, 'left'

        
        if @model.get 'user_object'
            do app.views.popupphoto.clearuser
            user = new app.models.User @model.get 'user_object'
            app.views.popupphoto.changeuser user
        else
            user = new app.models.User
            $('.photoPopup .infoBox').addClass 'loading'
            user.set 'id', @model.get 'user'
            user.fetch
                success: ->
                    $('.photoPopup .infoBox').removeClass 'loading'
                    app.views.popupphoto.changeuser user
            do app.views.popupphoto.clearuser

    like: ()->
        
        that = @
        console.log @model.like
        @model.like (likes)->
            counter_container = that.$el.find('.like-counter')
            counter_container.text likes
            that.$el.find('.action-like').removeClass('action-like').addClass('action-remove-like')
        return false

    unlike: ()->
        that = @
        @model.unlike (likes)->
            counter_container = that.$el.find('.like-counter')
            counter_container.text likes
            that.$el.find('.action-remove-like').removeClass('action-remove-like').addClass('action-like')
        return false

    removePhoto: ()->
        do @model.destroy
        do @remove
        return false
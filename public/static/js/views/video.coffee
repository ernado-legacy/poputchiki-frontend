app.views.Video = Backbone.View.extend

    tagName: 'div'
    className: 'photo-wrapper'
    events: 
        'click .action-like':'like'
        'click .action-remove-like':'unlike'
        'click .remove-photo': 'removeVideo'


    render: (is_my_user)->
        that = @
        @is_my_user = is_my_user
        if not @model.get('url')
            @interval = setInterval ->
                do that.updateUrl
            , 500
        
        app.models.myuser.get (user)->
            liked_by = if (user.get('id') in that.model.get('liked_users')) then true else false
            $ that.$el.html jade.templates.video 
                video: that.model.toJSON(),
                liked_by: liked_by,
                is_my_user: is_my_user

    clck: ->
        $('body').addClass 'bodyPopup'

        _.each ['.popupBack', '.popupWrapper', '.photoPopup'], (item) ->
            $(item).fadeIn 'slow'

        do @changeimg

    like: ()->
        that = @
        @model.like (likes)->
            counter_container = that.$el.find('.like-counter')
            counter_container.text likes
            that.$el.find('.custom-link').removeClass('action-like').addClass('action-remove-like')
        return false

    unlike: ()->
        that = @
        @model.unlike (likes)->
            counter_container = that.$el.find('.like-counter')
            counter_container.text likes
            that.$el.find('.custom-link').removeClass('action-remove-like').addClass('action-like')
        return false

        
    removeVideo: ()->
        do @model.destroy
        do @remove
        return false

    updateUrl: ()->
        that = @
        @model.fetch.done ->
            if that.model.get('url')
                clearInterval that.interval
                that.render that.is_my_user

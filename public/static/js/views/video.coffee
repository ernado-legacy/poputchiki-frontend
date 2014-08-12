app.views.Video = Backbone.View.extend

    tagName: 'div'
    className: 'photo-wrapper'
    events: 
        'click .action-like':'like'
        'click .action-remove-like':'unlike'

    render: ->
        console.log typeof @model
        that = @
        app.models.myuser.get (user)->
            liked_by = if (user.get('id') in that.model.get('liked_users')) then true else false
            $ that.$el.html jade.templates.video 
                video: that.model.toJSON(),
                liked_by: liked_by

    clck: ->
        $('body').addClass 'bodyPopup'

        _.each ['.popupBack', '.popupWrapper', '.photoPopup'], (item) ->
            $(item).fadeIn 'slow'

        do @changeimg

    like: ()->
        console.log 'video like'
        that = @
        @model.like true, (likes)->
            counter_container = that.$el.find('.like-counter')
            counter_container.text likes
            that.$el.find('.custom-link').removeClass('action-like').addClass('action-remove-like')
        return false

    unlike: ()->
        console.log 'video unlike'
        that = @
        @model.like false, (likes)->
            counter_container = that.$el.find('.like-counter')
            counter_container.text likes
            that.$el.find('.custom-link').removeClass('action-remove-like').addClass('action-like')
        return false

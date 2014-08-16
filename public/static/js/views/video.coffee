app.views.Video = Backbone.View.extend

    tagName: 'div'
    className: 'photo-wrapper'
    events: 
        'click .action-like':'like'
        'click .action-remove-like':'unlike'
        'click .remove-photo': 'removeVideo'
        'click video': 'video_block'


    initialize: ->
        @listenTo @model,'change:url',@refreshSource

    render: (is_my_user)->
        that = @
        @is_my_user = is_my_user
        if not @model.get('url')
            @interval = setInterval ->
                do that.updateUrl
            , 2
        
        app.models.myuser.get (user)->
            liked_by = if (user.get('id') in that.model.get('liked_users')) then true else false
            $ that.$el.html jade.templates.video 
                video: that.model.toJSON(),
                liked_by: liked_by,
                is_my_user: is_my_user


    like: ()->
        that = @
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


    removeVideo: ()->
        do @model.destroy
        do @remove
        return false

    updateUrl: ()->
        that = @
        do @model.fetch
        # console.log @model.toJSON()
        # .done ->
        #     if that.model.get('url')
        #         clearInterval that.interval
        #         that.render that.is_my_user

    video_block: ->
        $('video').each ->
            this.pause()
            this.currentTime = 0
        animVideo = $(event.target)
        animVideo.parent().prev().css "opacity", "0"
        setTimeout (->
            animVideo.get(0).play()
            return
        ), 2000
        animVideo.bind "ended", ->
            animVideo.currentTime = 0
            animVideo.parent().prev().css "opacity", "1"

    refreshSource: ->
        clearInterval @interval
        @render @is_my_user
app.views.Photo = Backbone.View.extend

    tagName: 'div'
    className: 'photo-wrapper'
    events: 
        'click': 'undefined'
        'click .action-like':'like'
        'click .action-remove-like':'unlike'

    render: ->
        @listenTo @model, 'changeimg', @changeimg
        that = @
        app.models.myuser.get (user)->
            liked_by = if (user.get('id') in that.model.get('liked_users')) then true else false
            console.log liked_by
            $ that.$el.html jade.templates.photo 
                photo: that.model.toJSON(),
                liked_by: liked_by

    clck: ->
        $('body').addClass 'bodyPopup'

        _.each ['.popupBack', '.popupWrapper', '.photoPopup'], (item) ->
            $(item).fadeIn 'slow'

        do @changeimg

    changeimg: ->

        $('.photoPopup .imgBox img').attr 'src', @model.get 'url'

        _.each ['.arrow-left', '.arrow-right'], (item) ->
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
    like: ()->
        that = @
        @model.like true, ()->
            counter_container = that.$el.find('.like-counter')
            counter_container.text counter_container.text()*1+1
            that.$el.find('.custom-link').removeClass('action-like').addClass('action-remove-like')
        return false

    unlike: ()->
        that = @
        @model.like false, ()->
            counter_container = that.$el.find('.like-counter')
            counter_container.text counter_container.text()*1-1
            that.$el.find('.custom-link').removeClass('action-remove-like').addClass('action-like')
        return false

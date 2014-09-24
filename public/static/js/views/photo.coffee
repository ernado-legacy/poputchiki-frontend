app.views.Photo = Backbone.View.extend

    tagName: 'div'
    className: 'photo-wrapper'
    events: 
        'click': 'clck'
        'click .action-like':'like'
        'click .action-remove-like':'unlike'
        'click .remove-photo': 'removePhoto'
        'click .new-ava': 'removePhoto'
        'click .likes': 'getlikers'
        'click .remove-media': 'remove_media'
        'click .cancel-remove-media': 'cancel_remove_media'


    render: (is_my_user)->
        @size = _.size(@model.get('liked_users'))
        @listenTo @model, 'changeimg', @changeimg
        that = @
        app.models.myuser.get (user)->
            if that.model.get('liked_users') and _.size(that.model.get('liked_users'))>0
                liked_by = if (user.get('id') in that.model.get('liked_users')) then true else false
            else
                liked_by = false
            that.model.updateDate 'time'
            $ that.$el.html jade.templates.photo 
                photo: that.model.toJSON(),
                liked_by: liked_by,
                is_my_user: is_my_user,
                likes_size: that.size

    clck: ->
        $('body').addClass 'bodyPopup'

        _.each ['.popupBack', '.popupWrapper', '.photoPopup'], (item) ->
            $(item).fadeIn 'slow'

        do @changeimg

    changeimg: ->

        $('.photoPopup .imgBox img').attr 'src', @model.get 'url'

        h = $('.photoPopup .imgBox img').height()
        w = $('.photoPopup .imgBox img').width()
        x = w*500/h + 40
        if  $(window).width()>= x
        #$('.photoPopup').outerWidth()
            $('.photoPopup .imgBox img').removeClass 'resizePopupImg'
            $('.photoPopup .imgBox').removeClass 'resizePopupImgBox'
            $('.photoPopup').removeClass 'resizePopupPhoto'
            n = ($(window).width() - $('.photoPopup').outerWidth())/2
            $('.photoPopup').css 'margin-left', n
        else
            $('.photoPopup .imgBox img').addClass 'resizePopupImg'
            $('.photoPopup .imgBox').addClass 'resizePopupImgBox'
            $('.photoPopup').addClass 'resizePopupPhoto'

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
            react @, 'right'

        
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

    get_like_el: ->
        @$el.find '.action-like'

    if_like: ->
        like = @get_like_el()
        like.attr('data-like') == 'true'

    like: ()->
        that = @
        if @if_like()
            @model.like (likes)->
                counter_container = that.$el.find('.likes')
                that.size += 1

                if that.size>0
                    counter_container.text that.size
                else
                    counter_container.text ''

                that.$el.find('.action-like').attr 'data-like', 'false'
                counter_container.addClass 'liked'
        else
            @model.unlike (likes)->
                counter_container = that.$el.find('.likes')
                that.size += -1
                if that.size>0
                    counter_container.text that.size
                else
                    counter_container.text ''
                console.log likes
                that.$el.find('.action-like').attr 'data-like', 'true'
                counter_container.removeClass 'liked'
        return false

    unlike: ()->
        that = @
        @model.unlike (likes)->
            counter_container = that.$el.find('.like-counter')
            if likes<1 
                counter_container.text ''
            else
                counter_container.text likes
            that.$el.find('.action-remove-like').removeClass('action-remove-like').addClass('action-like')
        return false

    removePhoto: ()->
        @$el.html jade.templates.remove_media()
        @$el.addClass 'remove-media'
        return false

    remove_media: ->
        do @model.destroy
        do @remove
        return false
    cancel_remove_media: ->
        @render true
        return false

    getlikers: (e)->
        that = @

        likers_url = $(e.currentTarget).data 'likers-url'
        if likers_url
            app.views.likers.render likers_url,()->
                app.views.entered.showpopup('.popupLikers')
        return false

app.views.PhotoUnsigned = Backbone.View.extend

    tagName: 'div'
    className: 'photo-wrapper'
    events: 
        'click': 'clck'
        'click .action-like':'like'
        'click .action-remove-like':'unlike'
        'click .remove-photo': 'removePhoto'
        'click .new-ava': 'removePhoto'
        'click .likes': 'getlikers'
        'click .remove-media': 'remove_media'
        'click .cancel-remove-media': 'cancel_remove_media'


    render: (is_my_user)->
        @size = _.size(@model.get('liked_users'))
        @listenTo @model, 'changeimg', @changeimg
        that = @
        liked_by = false
        that.model.updateDate 'time'
        $ that.$el.html jade.templates.photo 
            photo: that.model.toJSON(),
            liked_by: liked_by,
            is_my_user: false,
            likes_size: that.size

    clck: ->
        $('body').addClass 'bodyPopup'

        _.each ['.popupBack', '.popupWrapper', '.photoPopup'], (item) ->
            $(item).fadeIn 'slow'

        do @changeimg

    changeimg: ->

        $('.photoPopup .imgBox img').attr 'src', @model.get 'url'

        h = $('.photoPopup .imgBox img').height()
        w = $('.photoPopup .imgBox img').width()
        x = w*500/h + 40
        if  $(window).width()>= x
        #$('.photoPopup').outerWidth()
            $('.photoPopup .imgBox img').removeClass 'resizePopupImg'
            $('.photoPopup .imgBox').removeClass 'resizePopupImgBox'
            $('.photoPopup').removeClass 'resizePopupPhoto'
            n = ($(window).width() - $('.photoPopup').outerWidth())/2
            $('.photoPopup').css 'margin-left', n
        else
            $('.photoPopup .imgBox img').addClass 'resizePopupImg'
            $('.photoPopup .imgBox').addClass 'resizePopupImgBox'
            $('.photoPopup').addClass 'resizePopupPhoto'

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
            react @, 'right'

        
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

    get_like_el: ->
        @$el.find '.action-like'

    if_like: ->
        like = @get_like_el()
        like.attr('data-like') == 'true'

    like: ()->
        that = @
        if @if_like()
            @model.like (likes)->
                counter_container = that.$el.find('.likes')
                that.size += 1

                if that.size>0
                    counter_container.text that.size
                else
                    counter_container.text ''

                that.$el.find('.action-like').attr 'data-like', 'false'
                counter_container.addClass 'liked'
        else
            @model.unlike (likes)->
                counter_container = that.$el.find('.likes')
                that.size += -1
                if that.size>0
                    counter_container.text that.size
                else
                    counter_container.text ''
                console.log likes
                that.$el.find('.action-like').attr 'data-like', 'true'
                counter_container.removeClass 'liked'
        return false

    unlike: ()->
        that = @
        @model.unlike (likes)->
            counter_container = that.$el.find('.like-counter')
            if likes<1 
                counter_container.text ''
            else
                counter_container.text likes
            that.$el.find('.action-remove-like').removeClass('action-remove-like').addClass('action-like')
        return false

    removePhoto: ()->
        @$el.html jade.templates.remove_media()
        @$el.addClass 'remove-media'
        return false

    remove_media: ->
        do @model.destroy
        do @remove
        return false
    cancel_remove_media: ->
        @render true
        return false

    getlikers: (e)->
        that = @

        likers_url = $(e.currentTarget).data 'likers-url'
        if likers_url
            app.views.likers.render likers_url,()->
                app.views.entered.showpopup('.popupLikers')
        return false
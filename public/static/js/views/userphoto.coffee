app.views.UserPhotoBlock = Backbone.View.extend _.extend app.mixins.UploadPhoto,app.mixins.SlideRigtBlock,

    el: '.photoVideoBlock'

    events: 
        'click .addPhoto span': 'photoload'
        'change .photovideoformfile': 'changeimg'
        'click .videoHeader': 'video_header'
        'click .photoHeader': 'photo_header'

    photoload: ->
        do event.preventDefault
        $ '.photovideoformfile'
            .trigger 'click'

    changeimg: ->    
        do event.preventDefault
        form = '.photovideoform'

        url = $('.photovideoform input[name=loading_url]').val()

        @slideHide ()->

        that = @
        console.log url
        console.log url.search 'photo'
        success = (data) ->
            app.models.myuser.get (user)->
                if url.search 'photo' == -1
                    do that.refreshVideos
                else
                    do that.refreshPhotos
                    
        @uploadphoto url, form, success

    render: (id, is_my_user)->
        @user_id = id
        @is_my_user = is_my_user
        @$el.empty
        $ @.$el.html jade.templates.photo_video
            is_my_user: is_my_user
        that = @
        collection = new app.models.Photos id
        collection.fetch().done () ->
            $('.photoBox .photoBoxWrapper .pb-wr').empty()
            that.renderPhoto photo for photo in collection.models
            videocollection = new app.models.Videos id
            videocollection.fetch().done () ->
                $('.videoBox .photoBoxWrapper .pb-wr').empty()
                that.renderVideo video for video in videocollection.models
                that.slideHideAndShow ()->

            #that.showpopup '.view', '.photoPopup'
            user = new app.models.User
            user.set 'id', id
            user.fetch
                success: ->
                    app.views.popupphoto.changeuser user
            return

    renderPhoto: (photo)->
        photoView = new app.views.Photo model:photo
        $('.photoBox .photoBoxWrapper .pb-wr').append photoView.render(@is_my_user)

    renderVideo: (video)->
        videoView = new app.views.Video model:video
        $('.videoBox .photoBoxWrapper .pb-wr').append videoView.render(@is_my_user)

    refreshPhotos: ->
        $('.photoBox .photoBoxWrapper .pb-wr').empty()
        that = @
        collection = new app.models.Photos @user_id
        collection.fetch().done () ->
            $('.photoBox .photoBoxWrapper .pb-wr').empty()
            that.renderPhoto photo for photo in collection.models
            that.slideShow ()->

    refreshVideos: ->
        $('.videoBox .photoBoxWrapper .pb-wr').empty()
        that = @
        videocollection = new app.models.Videos @user_id
        videocollection.fetch().done () ->
            $('.photoBox .videoBox .pb-wr').empty()
            console.log  video for video in videocollection.models
            that.renderVideo video for video in videocollection.models
            that.slideShow ()->



    video_header: ->
        $('.activeHeader').removeClass 'activeHeader'
        if $(event.target).hasClass '.videoHeader'
            $(event.target).addClass 'activeHeader'
        else if $(event.target).hasClass '.title'
            $(event.target).parent().addClass 'activeHeader'
        else
            $(event.target).parent().parent().addClass 'activeHeader'
        $('.photoBox').hide()
        $('.videoBox').show()
        $('.photovideoform input[name=loading_url]').val('/api/video')
        $('.addPhoto span').text('Добавить видео')
        

    photo_header: ->
        $('.activeHeader').removeClass 'activeHeader'
        if $(event.target).hasClass '.photoHeader'
            $(event.target).addClass 'activeHeader'
        else if $(event.target).hasClass '.title'
            $(event.target).parent().addClass 'activeHeader'
        else
            $(event.target).parent().parent().addClass 'activeHeader'
        $('.videoBox').hide()
        $('.photoBox').show()
        $('.photovideoform input[name=loading_url]').val('/api/photo')
        $('.addPhoto span').text('Добавить фото')
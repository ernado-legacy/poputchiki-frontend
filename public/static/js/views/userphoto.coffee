app.views.UserPhotoBlock = Backbone.View.extend _.extend app.mixins.UploadPhoto,

    el: '.photoVideoBlock'

    events: 
        'click .addPhoto span': 'photoload'
        'change .photovideoformfile': 'changeimg'

    photoload: ->
        do event.preventDefault
        $ '.photovideoformfile'
            .trigger 'click'

    changeimg: ->    
        do event.preventDefault
        form = '.photovideoform'
        url = '/api/photo'
        success = (data) ->
            console.log data.url
        @uploadphoto url, form, success

    render: (id)->
        $ @.$el.html jade.templates.photo_video()
        collection = new app.models.Photos id
        that = @
        collection.fetch().done () ->
            $('.photoBox .photoBoxWrapper .pb-wr').empty()
            that.renderPhoto photo for photo in collection.models
            that.showpopup '.view', '.photoPopup'
            return

    renderPhoto: (photo)->
        bookView = new app.views.Photo model:photo
        $('.photoBox .photoBoxWrapper .pb-wr').append bookView.render()
        # bookView = new app.BookView model:item
        # @$el.append bookView.render()

    showpopup: (cnt, popup) ->
        $(cnt).click ->
            $('body').addClass 'bodyPopup'
            $('.popupBack').fadeIn('slow')
            $('.popupWrapper').fadeIn('slow')
            $(popup).fadeIn('slow')
        





app.views.PopupAudio = Backbone.View.extend _.extend app.mixins.UploadPhoto,

    el: '.chavaPopup'

    events:
        'click .upload-new-audio':'uploadc'
        'change .upload-new-audio-input': 'upload'
        'click .upload-new-ava': 'uploadphotoc'
        #'change .upload-new-avatar-input': 'uploadava'

    uploadc: ->
        do event.preventDefault
        @$el.find '.upload-new-audio-input'
            .trigger 'click'

    upload: ->
        @uploadphoto '/api/audio', '.chavaPopup form.audioform', (data) ->
            console.log 'hi'

    uploadphotoc: ->
        do event.preventDefault
        app.views.stripechoppopup.update false, true
        $('.popup').fadeOut('slow')
        $('.chopPopup').fadeIn('slow')
        #@$el.find '.upload-new-avatar-input'
        #    .trigger 'click'


    #uploadava: ->
    #    @uploadphoto '/api/photo', '.chavaPopup form.avatarform', (data) ->
    #        app.models.myuser.get (user) ->
    #            user.set 'avatar', data.id
    #            user.save()
    #            #$('.img img').attr 'src', data.url
    #            do app.views.profile.render
    #    do app.views.entered.closepopuprun
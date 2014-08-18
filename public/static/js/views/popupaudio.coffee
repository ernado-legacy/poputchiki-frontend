app.views.PopupAudio = Backbone.View.extend _.extend app.mixins.UploadPhoto,

    el: '.chavaPopup'

    events:
        'click .upload-new-audio':'uploadc'
        'change .upload-new-audio-input': 'upload'

    uploadc: ->
        do event.preventDefault
        @$el.find '.upload-new-audio-input'
            .trigger 'click'

    upload: ->
        @uploadphoto '/api/audio', '.chavaPopup form', ->
            console.log 'hi'
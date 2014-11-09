app.views.AdsBlock = Backbone.View.extend _.extend app.mixins.UploadPhoto,app.mixins.SlideRigtBlock,

    el: '.photoVideoBlock'

    events: 
        'click .addPhoto span': 'photoload'
        'change .photovideoformfile': 'changeimg'
        'click .videoHeader': 'video_header'
        'click .photoHeader': 'photo_header'


        
    render: ()->
    	$ @.$el.html jade.templates.photo_video
    	that.slideHideAndShow ()->



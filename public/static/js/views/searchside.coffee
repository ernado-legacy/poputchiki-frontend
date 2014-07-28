app.views.SearchSide = Backbone.View.extend

    el: '.photoVideoBlock'

    render: ->
        $ @.$el.attr 'id', 'searchPhotoVideoBlock'
        $ @.$el.html jade.templates.search_photo_video()
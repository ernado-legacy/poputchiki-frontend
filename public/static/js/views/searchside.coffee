app.views.SearchSide = Backbone.View.extend

    el: '.photoVideoBlock'

    render: ->
        $ @.$el.html jade.templates.search_photo_video()
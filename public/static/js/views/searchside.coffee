app.views.SearchSide = Backbone.View.extend

    el: '.photoVideoBlock'

    render: ->
        $ @.$el.attr 'id', 'searchPhotoVideoBlock'
        $ @.$el.html jade.templates.search_photo_video()

    renderitems: (data) ->
        $('#searchPhotoVideo .imgGrid').html ''
        _.each data, (item) ->
            console.log item
            console.log item.thumbnail_url
            $('#searchPhotoVideo .imgGrid').append jade.templates.searchphotoitem
                img: item.thumbnail_url
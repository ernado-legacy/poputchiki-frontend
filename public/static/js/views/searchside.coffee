app.views.SearchSide = Backbone.View.extend

    el: '.photoVideoBlock'

    render: ->
        # $ @.$el.attr 'id', 'searchPhotoVideoBlock'
        $ @.$el.html jade.templates.search_photo_video
            is_my_user: false

    renderitems: (data) ->

        # $('#searchPhotoVideo .imgGrid').html ''
        $('.videoBox .photoBoxWrapper .pb-wr').empty()

        collection = _.reduce data, (result, item) ->
            result.add new app.models.Photo item
            result
        , new app.models.Photos

        collection.each (item) ->

            item.collection = collection
            photoView = new app.views.Photo model:item
            $('.photoBox .photoBoxWrapper .pb-wr').append photoView.render(false)


            # $('#searchPhotoVideo .imgGrid').append jade.templates.searchphotoitem
            #     img: item.thumbnail_url
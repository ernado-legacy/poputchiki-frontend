app.views.SearchSide = Backbone.View.extend

    el: '.photoVideoBlock'

    render: ->
        # $ @.$el.attr 'id', 'searchPhotoVideoBlock'
        $ @.$el.html jade.templates.search_photo_video
            is_my_user: false

    renderitems: (data) ->

        # $('#searchPhotoVideo .imgGrid').html ''
        $('.videoBox .photoBoxWrapper .pb-wr').empty()
        _.each data, (item) ->
            photomodel = new app.models.Photo
            photomodel.set item
            console.log photomodel.toJSON()
            
            photoView = new app.views.Photo model:photomodel
            $('.photoBox .photoBoxWrapper .pb-wr').append photoView.render(false)


            # $('#searchPhotoVideo .imgGrid').append jade.templates.searchphotoitem
            #     img: item.thumbnail_url
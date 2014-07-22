app.views.UserPhotoBlock = Backbone.View.extend

    el: '.photoVideoBlock'

    events: 
        'click .addPhoto span': 'photoload'
        'change #imgfile': 'changeimg'

    photoload: ->
        do event.preventDefault
        $ '#imgfile'
            .trigger 'click'

    changeimg: ->    
        do event.preventDefault
        form = $ '.loginRegisterBlock'
        data = new FormData form.get(0)
        that = this
        $.ajax
            'url': '/api/photo',
            'type': 'POST',
            'data': data,
            'cache': false,
            'processData': false,
            'contentType': false,
            success: (data) ->
                console.log data.url
                # user = new app.models.User
                #     id: $.cookie 'user'
                # user.set 'avatar', data.id
                # user.save()
                # $('.img img').attr 'src', data.url

    render: (id)->
        $ @.$el.html jade.templates.photo_video()
        collection = new app.models.Photos id
        that = @
        collection.fetch().done () ->
            that.renderPhoto photo for photo in collection.models
            return

    renderPhoto: (photo)->
        console.log photo
        bookView = new app.views.Photo model:photo
        $('.photoBox').append bookView.render()
        # bookView = new app.BookView model:item
        # @$el.append bookView.render()
        





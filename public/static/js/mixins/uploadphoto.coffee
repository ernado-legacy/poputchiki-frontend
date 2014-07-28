app.mixins.UploadPhoto = 
    uploadphoto: (url, form, success) ->
        form = $ form
        data = new FormData form.get(0)
        that = this
        $.ajax
            'url': url,
            'type': 'POST',
            'data': data,
            'cache': false,
            'processData': false,
            'contentType': false,
            success: success
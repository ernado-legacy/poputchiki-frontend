app.mixins.UploadPhoto = {
  uploadphoto: function(url, form, success) {
    var data, that;
    form = $(form);
    data = new FormData(form.get(0));
    that = this;
    return $.ajax({
      'url': url,
      'type': 'POST',
      'data': data,
      'cache': false,
      'processData': false,
      'contentType': false,
      success: success
    });
  }
};

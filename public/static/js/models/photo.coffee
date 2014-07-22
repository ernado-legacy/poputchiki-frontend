id  = $.cookie "user"

app.models.Photo = Backbone.Model.extend()

Photo = app.models.Photo

app.models.Photos = Backbone.Collection.extend
    initialize: (id)->
        console.log id
        @id = id
        return
        
    model: Photo

    url: '/api/user/'+@id+'/photo'
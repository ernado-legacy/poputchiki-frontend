id  = $.cookie "user"

app.models.Photo = Backbone.Model.extend
	url: 'api/photo'

Photo = app.models.Photo

app.models.Photos = Backbone.Collection.extend
    initialize: (id)->
        @id = id
        return
        
    model: Photo

    url: ()->
    	'/api/user/'+@id+'/photo'
id  = $.cookie "user"

app.models.Photo = Backbone.Model.extend
	url: 'api/photo'
	
	like: (like,callback)->
    	query_type =  if like then 'POST' else 'DELETE'
    	$.ajax
            url: '/api/photo/'+@.get('id')+'/like'
            type: query_type
            # data: "target="+@.get('id')
            dataType: "json"
            success: (data) ->
                do callback

Photo = app.models.Photo

app.models.Photos = Backbone.Collection.extend
    initialize: (id)->
        @id = id
        return
        
    model: Photo

    url: ()->
    	'/api/user/'+@id+'/photo'
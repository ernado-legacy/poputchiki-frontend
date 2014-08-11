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


    parse: (response)->
        for user in response
            # user = @parseLastActionParameter item  
            time_param = new Date user.time
            user.time = 
                date: time_param.getDate()+"."+time_param.getMonth()+"."+(time_param.getYear()*1+1900)
                time: time_param.getHours()+":"+time_param.getMinutes()
        # item.parseTimeParameter  'last_action' for item in response
        return response
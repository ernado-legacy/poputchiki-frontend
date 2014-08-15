

app.models.Photo = Backbone.Model.extend 
    # initialize: ()->
    #     @listenToOnce @, 'change:time', @updateDate

	url: ->
        '/api/photo/'+@.get('id')

    # updateDate: (object)->
    #     console.log object

	
	like: (callback)->
        @sendLikeQuery 'POST', callback
        

    unlike: (callback)->
        @sendLikeQuery 'DELETE', callback

    sendLikeQuery: (query_type, callback)->
        $.ajax
            url: '/api/photo/'+@.get('id')+'/like'
            type: query_type
            # data: "target="+@.get('id')
            dataType: "json"
            success: (data) ->
                callback data.likes

    parse: (response)->
        time_param = new Date response.time
        response.time = 
            date: time_param.getDate()+"."+time_param.getMonth()+"."+(time_param.getYear()*1+1900)
            time: time_param.getHours()+":"+time_param.getMinutes()
        return response


Photo = app.models.Photo

app.models.Photos = Backbone.Collection.extend
    initialize: (id)->
        @id = id
        return
        
    model: Photo

    url: ()->
    	'/api/user/'+@id+'/photo'


    # parse: (response)->
    #     for user in response
    #         # user = @parseLastActionParameter item  
    #         time_param = new Date user.time
    #         user.time = 
    #             date: time_param.getDate()+"."+time_param.getMonth()+"."+(time_param.getYear()*1+1900)
    #             time: time_param.getHours()+":"+time_param.getMinutes()
    #     # item.parseTimeParameter  'last_action' for item in response
    #     return response
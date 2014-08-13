

app.models.Video = Backbone.Model.extend 
    url: ->
        '/api/video/'+@.get('id')
    
    like: (callback)->
        @sendLikeQuery 'POST', callback
        

    unlike: (callback)->
        @sendLikeQuery 'DELETE', callback

    sendLikeQuery: (query_type, callback)->
        $.ajax
            url: '/api/video/'+@.get('id')+'/like'
            type: query_type
            # data: "target="+@.get('id')
            dataType: "json"
            success: (data) ->
                callback data.likes


Video = app.models.Video

app.models.Videos = Backbone.Collection.extend
    initialize: (id)->
        @id = id
        return
        
    model: Video

    url: ()->
        '/api/user/'+@id+'/video'


    parse: (response)->
        for user in response
            # user = @parseLastActionParameter item  
            time_param = new Date user.time
            user.time = 
                date: time_param.getDate()+"."+time_param.getMonth()+"."+(time_param.getYear()*1+1900)
                time: time_param.getHours()+":"+time_param.getMinutes()
        # item.parseTimeParameter  'last_action' for item in response
        return response
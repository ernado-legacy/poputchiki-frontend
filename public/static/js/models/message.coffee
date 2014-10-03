app.models.Message = Backbone.Model.extend
    initialize: ->
        time_param_name = 'time'
        time_param = new Date @get time_param_name
        today = new Date
        @set(time_param_name+'Day',time_param.getDate())
        @set(time_param_name+'Month',time_param.getMonth())
        @set(time_param_name+'Year',(time_param.getYear()*1+1900))
        @set time_param_name+'FullDate', 
        @set(time_param_name+'Time',)

        if (new Date(@get time_param_name)).setHours(0,0,0,0) == today.setHours(0,0,0,0)
            @set 'time', ("0" + time_param.getHours()).slice(-2)+":"+("0" + time_param.getMinutes()).slice(-2)+":"+("0" + time_param.getSeconds()).slice(-2)
        else
            today.setDate(today.getDate()-1)
            if (new Date(@get time_param_name)).setHours(0,0,0,0) == today.setHours(0,0,0,0)
                @set 'time', 'вчера'    
            else
                @set 'time', ("0" + time_param.getDate()).slice(-2)+'.'+time_param.getMonth()+'.'+time_param.getYear()
    

Message = app.models.Message

app.models.Messages = Backbone.Collection.extend
    model: Message

    url: () ->
        '/api/user/'+ @urluser + '/messages'

Messages = app.models.Messages

app.models.newMessage = (data, url, callback) ->

    $.ajax
        type: "PUT",
        url: url
        data: data
        success: callback
        dataType: "json"
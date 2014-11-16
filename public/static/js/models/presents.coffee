app.models.Present = Backbone.Model.extend
    initialize: ->
        @on 'present:send', (user_id)->
            @send_present user_id
    
    url: ->
        '/api/present/'

    send_present: (user_id)->
        console.log @
        $.ajax
            url: '/api/user/'+user_id+'/present/'+@get('title')
            type: 'POST'
            # data: "target="+@.get('id')
            dataType: "json"
            success: (data) =>
                console.log 'present was succesfult sentd'



Present = app.models.Present
app.models.Presents = Backbone.Collection.extend
    url: ->
        if @user_id
            '/api/user/'+@user_id+'/present'
        else
            '/api/present'
    model: Present
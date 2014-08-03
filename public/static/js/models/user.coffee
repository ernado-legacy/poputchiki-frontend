app.models.User = Backbone.Model.extend
    urlRoot: '/api/user/'
    visit_user_by: () ->
        $.ajax
            url: '/api/user/'+app.models.myuser.getid()+'/guests'
            type: 'PUT'
            data: "target="+@.get('id')
            dataType: "json"
            success: (data) ->
                undefined
    add_to_fav: (remove) ->
        type = if remove then "DELETE" else "PUT"
        console.log type
        data = target : @.get('id')
        $.ajax
            url: '/api/user/'+app.models.myuser.getid()+'/fav'
            type: type
            data: JSON.stringify data
            dataType: "json"
            contentType: "application/json; charset=utf-8"
            success: (data) ->
                console.log 'added to favs'
                app.models.myuser.favs = undefined
                app.models.myuser.clear ->
                    console.log 123



User = app.models.User

app.models.Users = Backbone.Collection.extend
    model: User
    url: '/api/user/'
    # initialize: ->
    # 	console.log 'Before bind events how is our model?', this.toJSON()
    # 	this.on("change", this.changeHandler)

    # fetch: (options)->
    # 	this.constructor.__super__.fetch.apply @, arguments

id  = $.cookie "user"



app.models.FavUsers = Backbone.Collection.extend
    model: User
    url: ->
        id = app.models.myuser.getid()
        '/api/user/'+id+'/fav'

    parse: (response)->
        for user in response
            # user = @parseLastActionParameter item  
            console.log  user.last_action
            time_param = new Date user.last_action
            user.last_action = 
                date: time_param.getDate()+"."+time_param.getMonth()+"."+(time_param.getYear()*1+1900)
                time: time_param.getHours()+":"+time_param.getMinutes()
        # item.parseTimeParameter  'last_action' for item in response
        return response

    # parseLastActionParameter: (user)->
        time_param = new Date user.get('last_action')
        user.set 'last_action',
            date: time_param.getDate()+"."+time_param.getMonth()+"."+(time_param.getYear()*1+1900)
            time: time_param.getHours()+":"+time_param.getMinutes()
        user
    # initialize: ->
    # 	console.log 'Before bind events how is our model?', this.toJSON()
    # 	this.on("change", this.changeHandler)

app.models.Guests = Backbone.Collection.extend
    initialize: (models,options) ->
        @id = options.id
        return
    url: -> 
        '/api/user/'+this.id+'/guests'

    model: User

Users = app.models.Users
FavUsers = app.models.FavUsers
# Guests = app.models.Guests

app.models.user = new app.models.Users
app.models.fav_users = new app.models.FavUsers
# app.models.guests = new app.models.Guests

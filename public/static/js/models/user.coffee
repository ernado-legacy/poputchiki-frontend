app.models.User = Backbone.Model.extend 
    urlRoot: '/api/user/'


    # initialize: ()->
    #     if @.get 'last_action'
    #         @updateDate {}, 'last_action'
    #     @listenTo @, 'change:birthday', (object)->
    #         @updateDate object, 'birthday'

    #     @listenTo @, 'change:last_action', (object)->
    #         @updateDate object, 'last_action'
            


    updateDate:  (time_param_name)->
        time_param = new Date @get time_param_name
        # user.time = 
        #     date: +"."+time_param.getMonth()+"."+(time_param.getYear()*1+1900)
        #     time: time_param.getHours()+":"+time_param.getMinutes()
        month = new Array()
        month[0] = "Января"
        month[1] = "Февраля"
        month[2] = "Марта"
        month[3] = "Апреля"
        month[4] = "Мая"
        month[5] = "Июня"
        month[6] = "Июля"
        month[7] = "Августа"
        month[8] = "Сентября"
        month[9] = "Октября"
        month[10] = "Ноября"
        month[11] = "Декабря"

        n = month[time_param.getMonth()]
        @set(time_param_name+'Day',time_param.getDate())
        @set(time_param_name+'Month',n)
        @set(time_param_name+'Year',(time_param.getYear()*1+1900))
        @set(time_param_name+'Time',time_param.getHours()+":"+time_param.getMinutes())

    visit_user_by: () ->
        $.ajax
            url: '/api/user/'+app.models.myuser.getid()+'/guests'
            type: 'PUT'
            data: "target="+@.get('id')
            dataType: "json"
            success: (data) ->
                undefined
    add_to_fav: () ->
        @sendFavQuery 'PUT', @.get('id'), app.models.myuser.getid()

    remove_from_fav: () ->
        @sendFavQuery 'DELETE', @.get('id'), app.models.myuser.getid()

    sendFavQuery: (query_type,target,user_id)->
        data = target : target
        $.ajax
            url: '/api/user/'+user_id+'/fav'
            type: query_type
            data: JSON.stringify data
            dataType: "json"
            contentType: "application/json; charset=utf-8"
            success: (data) ->
                app.models.myuser.favs = undefined
                app.models.myuser.clear ->


    add_to_blacklist: (remove) ->
        type = if remove then "DELETE" else "PUT"
        data = target : @.get('id')
        $.ajax
            url: '/api/user/'+app.models.myuser.getid()+'/blacklist'
            type: type
            data: JSON.stringify data
            dataType: "json"
            contentType: "application/json; charset=utf-8"
            success: (data) ->
                app.models.myuser.favs = undefined
                app.models.myuser.clear ->


    invite_to_travel: () ->
        $.ajax
            url: '/api/user/'+@.get('id')+'/invite'
            type: 'POST'
            # data: "target="+@.get('id')
            dataType: "json"
            success: (data) ->

                

    parse: (response)->
        response.rating = Math.round(response.rating)
        return response



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

    # parse: (response)->
    #     for user in response
    #         # user = @parseLastActionParameter item  
    #         time_param = new Date user.last_action
    #         user.last_action = 
    #             date: time_param.getDate()+"."+time_param.getMonth()+"."+(time_param.getYear()*1+1900)
    #             time: time_param.getHours()+":"+time_param.getMinutes()
    #     # item.parseTimeParameter  'last_action' for item in response
    #     return response

    # # parseLastActionParameter: (user)->
    #     time_param = new Date user.get('last_action')
    #     user.set 'last_action',
    #         date: time_param.getDate()+"."+time_param.getMonth()+"."+(time_param.getYear()*1+1900)
    #         time: time_param.getHours()+":"+time_param.getMinutes()
    #     user
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

app.models.Likers = Backbone.Collection.extend
    url: -> 
        '/api/status/53fcb3f42d116c00010000fe/like'
    model: User

app.models.Followers = Backbone.Collection.extend
    initialize: (models,options) ->
        @id = options.id
        return
    url: -> 
        '/api/user/'+this.id+'/followers'

    model: User

app.models.BlackList = Backbone.Collection.extend
    initialize: (models,options) ->
        @id = options.id
        return
    url: -> 
        '/api/user/'+this.id+'/blacklist'

    model: User

Users = app.models.Users
FavUsers = app.models.FavUsers
# Guests = app.models.Guests

app.models.user = new app.models.Users
app.models.fav_users = new app.models.FavUsers
# app.models.black_users = new app.models.BlackList
# app.models.guests = new app.models.Guests

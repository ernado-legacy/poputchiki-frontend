app.models.User = Backbone.Model.extend
    urlRoot: '/api/user/'
    visit_user_by: (guest_id) ->
        $.ajax
          url: '/api/user/'+@.get('id')+'/guests'
          type: 'PUT'
          data: "target="+guest_id
          success: (data) ->
            console.log 'user now has new guest'
    parse: (response)->
        console.log 'parsing'
        response


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
    url: '/api/user/'+id+'/fav'
    # initialize: ->
    # 	console.log 'Before bind events how is our model?', this.toJSON()
    # 	this.on("change", this.changeHandler)

app.models.Guests = Backbone.Collection.extend
    initialize: (models,options) ->
        console.log 'guests model init'
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

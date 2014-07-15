app.models.User = Backbone.Model.extend
    urlRoot: '/api/user/'

User = app.models.User

app.models.Users = Backbone.Collection.extend
    model: User
    url: '/api/user/'
    # initialize: ->
    # 	console.log 'Before bind events how is our model?', this.toJSON()
    # 	this.on("change", this.changeHandler)

    fetch: (options)->
    	console.log 'fetching'
    	this.constructor.__super__.fetch.apply @, arguments

id  = $.cookie "user"



app.models.FavUsers = Backbone.Collection.extend
    model: User
    url: '/api/user/'+id+'/fav'
    # initialize: ->
    # 	console.log 'Before bind events how is our model?', this.toJSON()
    # 	this.on("change", this.changeHandler)

Users = app.models.Users
FavUsers = app.models.FavUsers

app.models.user = new app.models.Users
app.models.fav_users = new app.models.FavUsers

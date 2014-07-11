app.models.User = Backbone.Model.extend
    urlRoot: '/api/user/'

User = app.models.User

app.models.Users = Backbone.Collection.extend
    model: User
    url: '/api/user/'
    initialize: ->
    	console.log 'Before bind events how is our model?', this.toJSON()
    	this.on("change", this.changeHandler)

    fetch: (options)->
    	console.log 'fetching'
    	this.constructor.__super__.fetch.apply @, arguments

Users = app.models.Users

app.models.user = new app.models.Users
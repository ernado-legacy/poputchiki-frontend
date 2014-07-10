app.models.User = Backbone.Model.extend
    urlRoot: '/api/user/'

User = app.models.User

app.models.Users = Backbone.Collection.extend
    model: User
    url: '/api/user/'
    initialize: ->
    	console.log 'Before bind events how is our model?', this.toJSON()
    	this.bind("change", this.changeHandler)

    changeHandler: (e)->
    	console.log "something changed"
    	console.log e

Users = app.models.Users

app.models.user = new app.models.Users
app.models.User = Backbone.Model.extend
    initialize: ->
        @set
            urlRoot: '/api/user/' + this.get('id')

app.models.Users = Backbone.Collection.extend
    model: User
    url: '/api/user/'

app.models.user = new app.models.Users
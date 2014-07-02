app.models.User = Backbone.Model.extend
    urlRoot: '/api/user/'

User = app.models.User

app.models.Users = Backbone.Collection.extend
    model: User
    url: '/api/user/'

Users = app.models.Users

app.models.user = new app.models.Users
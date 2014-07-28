app.models.Status = Backbone.Model.extend
    urlRoot: '/api/status'

app.models.Statuses = Backbone.Collection.extend
    url: '/api/status'
    model: app.models.Status
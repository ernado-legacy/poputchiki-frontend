StatusLikersUrl =
    likers_url: ()->
        '/api/status/'+@.get('id')+'/like'


app.models.Status = Backbone.Model.extend
    urlRoot: '/api/status'

app.models.MyStatus = Backbone.Model.extend _.extend {}, StatusLikersUrl,
    urlRoot: ->
        if @get 'id'
            '/api/status'
        else
            '/api/user/'+@get('user')+'/status'

            

app.models.Statuses = Backbone.Collection.extend
    url: '/api/status'
    model: app.models.Status
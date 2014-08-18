Mixin =
    url: ->
        '/api/status/' + @status + '/like'


app.models.StatusLike = Backbone.Model.extend Mixin

app.models.StatusLikes = Backbone.Collection.extend Mixin
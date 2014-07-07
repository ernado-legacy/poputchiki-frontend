app.models.Message = Backbone.Model.extend

Message = app.models.Message

app.models.Messages = Backbone.Collection.extend
    model: Message

Messages = app.models.Messages
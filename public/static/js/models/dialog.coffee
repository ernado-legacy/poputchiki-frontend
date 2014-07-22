app.models.Dialog = Backbone.Model.extend()

Dialog = app.models.Dialog

app.models.Dialogs = Backbone.Collection.extend
    model: Dialog

    url: ->
        '/api/user/' + app.models.myuser.getid() + '/chats'

Dialogs = app.models.Dialogs
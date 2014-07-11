app.models.Dialog = Backbone.Model.extend

Dialog = app.models.Dialog

app.models.Dialogs = Backbone.Collection.extend
    model: Dialog

    url: () ->
        '/api/user/'+$.cookie('user')+'/chats'

Dialogs = app.models.Dialogs
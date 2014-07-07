app.models.Dialog = Backbone.Model.extend

Dialog = app.models.Dialog

app.models.Dialogs = Backbone.Collection.extend
    model: Dialog

Dialogs = app.models.Dialogs
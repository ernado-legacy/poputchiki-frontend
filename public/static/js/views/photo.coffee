app.views.Photo = Backbone.View.extend

    tagName: 'div'
    className: 'view'
    render: ->
        $ @.$el.html jade.templates.photo @model.toJSON()
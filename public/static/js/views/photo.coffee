app.views.Photo = Backbone.View.extend

    tagName: 'div'
    className: 'view'
    # events: 
    #     'click': 'test'
    render: ->
        $ @.$el.html jade.templates.photo @model.toJSON()
    # test: ->
    #     console.log '123'
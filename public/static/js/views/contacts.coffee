app.views.Contacts = Backbone.View.extend _.extend app.mixins.MetaTagsMixin,

    el: 'body'
    render: ->
        @trigger 'render'
        @$el.html jade.templates.contacts()
    meta_title: "Контакты"
    meta_description: 'Контакты.'
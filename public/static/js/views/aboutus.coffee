app.views.AboutUs = Backbone.View.extend _.extend app.mixins.MetaTagsMixin,

    el: 'body'
    render: ->
        @trigger 'render'
        @$el.html jade.templates.aboutus
            # login: result
            footerenter: true

    meta_title: "О нас"
    meta_description: 'Социальная сеть «Попутчики.ru» - это поиск новых знакомств для совместных путешествий. О нас.'

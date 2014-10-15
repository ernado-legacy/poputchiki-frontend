app.views.Terms = Backbone.View.extend _.extend app.mixins.MetaTagsMixin,

    el: 'body'

    render: ->
        @trigger 'render'
        @$el.html jade.templates.terms()
    meta_title: "Правила сайта"
    # meta_description: 'Социальная сеть «Попутчики.ru» - это поиск новых знакомств для совместных путешествий. О нас.'
app.views.NotFound = Backbone.View.extend _.extend app.mixins.MetaTagsMixin,

    el: 'body'
    render: (title)->
        @trigger 'render'
        @$el.html jade.templates.notfound
            not_found_text: title || "Данная страница не существует!" 
    meta_title: "Попутчики.ру - страница не найдена"

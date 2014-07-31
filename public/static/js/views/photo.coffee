app.views.Photo = Backbone.View.extend

    tagName: 'div'
    className: 'view'
    events: 
        'click': 'clck'
        'click .action-like':'like'

    render: ->
        @listenTo @model, 'changeimg', @changeimg
        $ @.$el.html jade.templates.photo @model.toJSON()

    clck: ->
        $('body').addClass 'bodyPopup'

        _.each ['.popupBack', '.popupWrapper', '.photoPopup'], (item) ->
            $(item).fadeIn 'slow'

        do @changeimg

    changeimg: ->

        $('.photoPopup .imgBox img').attr 'src', @model.get 'url'

        _.each ['.arrow-left', '.arrow-right'], (item) ->
            do $('.photoPopup ' + item).unbind

        fix = (index, a, b, change) ->
            if index == a
                b
            else
                index + change      

        react = (t, rl) ->
            index = t.model.collection.indexOf t.model
            smo = t.model.collection.size() - 1
            if rl == 'right'
                index = fix index, smo, 0, 1
            else
                index = fix index, 0, smo, -1
            t.model.collection.models[index].trigger 'changeimg'

        $('.photoPopup .arrow-right').click =>
            react @, 'left'

        $('.photoPopup .arrow-left').click =>
            react @, 'right'
    like: (e)->
        do e.preventDefault
        console.log 'like photo'
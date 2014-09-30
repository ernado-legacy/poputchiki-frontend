app.views.UserListView = Backbone.View.extend

    tagName: 'li'
    className: 'user-item'

    events:
        'click .write': 'write'
        'click .add_to_fav': 'add_to_fav'
        'click .remove_from_fav': 'remove_from_fav'
        'click .to_journey': 'to_journey'
        'click':'liwrite'
        'click .remove_dialog':'remove_dialog'
        # 'click .remove_dialog':'write'

    liwrite: (e)->
        $(e.currentTarget).parents('#dialogs_list').length
        if $(e.currentTarget).parents('#dialogs_list').length > 0
            @write e

    remove_dialog: ->
        that = @
        @model.remove_messeges_with_this_user ->
            $('#dialogs_list li[data-user-id="'+that.model.get('id')+'"]').remove()
            # do that.

        false

    initialize: (options)->
        @template = options.template
        @custom_tag_id = ""

    render: ->
        that = @
        user = @model
        app.models.myuser.get (my_user)->
            that.$el.attr 'data-user-id', user.get 'id'
            that.model = user
            if my_user.get('favorites')
                is_fav = if my_user.get('favorites').indexOf(user.get('id')) != -1 then true else false
            $ that.$el.html that.template
                user: user.attributes,
                is_fav: is_fav

    write: (event) ->
        do event.preventDefault
        app.views.message.set_url @model.get('id')
        do app.views.message.render
        do app.views.messageside.render
        # do app.views.messageside.render
        # do app.views.messageside.render

    add_to_fav: (e)->
        do e.preventDefault
        do @model.add_to_fav
        $(e.currentTarget).addClass('remove_from_fav').removeClass('add_to_fav')
        $(e.currentTarget).text('убрать из избранного')

    remove_from_fav: (e)->
        do @model.remove_from_fav
        if $(e.currentTarget).data('remove-from-fav-clear') == true
            @trigger 'user-removed-from-favs',@model
            do @remove
            # console.log 'remove'
        else
            $(e.currentTarget).addClass('add_to_fav').removeClass('remove_from_fav')
            $(e.currentTarget).text('в избранное')

    to_journey: ->
        alert 'Пригласить пользователя в путешествие'



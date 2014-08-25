app.views.Status = Backbone.View.extend

    events:
        'click .like': 'like'

    get_status_id: ->
        @$el.attr 'data-status'

    get_like_el: ->
        @$el.find '.like'

    if_like: ->
        like = @get_like_el()
        like.attr('data-like') == 'true'

    update_layout: (condition, size) ->
        like = @get_like_el()
        if condition
            like.attr 'data-like', 'false'
            like.text 'не нравится'
        else
            like.attr 'data-like', 'true'
            like.text 'нравится'
        likes = @$el.find '.likes'
        if size
            if size == 1
                likes.text size + ' '
            else
                likes.text size + ' '
        else
            likes.text ''

    like: ->
        statusLike = new app.models.StatusLike
        statusLike.status = @get_status_id()
        that = @
        console.log @size
        if @if_like()
            statusLike.save {},
                success: ->
            @size += 1
        else
            statusLike.isNew = -> false
            do statusLike.destroy
            @size += -1
        console.log @size
        @update_layout @if_like(), @size

    updatelike: ->
        statusLikes = new app.models.StatusLikes
        statusLikes.status = @get_status_id()
        statusLikes.fetch 
            success: =>
                myuserid = app.models.myuser.getid()
                condition = statusLikes.find (item) ->
                    item.get('id') == myuserid
                @size = statusLikes.size()
                @update_layout condition, @size
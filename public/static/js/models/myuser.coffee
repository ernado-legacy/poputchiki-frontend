app.models.myuser =

    set: (user) ->
        @user = user

    check: (token, callback) ->
        app.models.token (data) =>
            @user = data.id
            callback true

    get: (callback) ->
        if @usermodel
            callback @usermodel
        else
            user = new app.models.User 
                id: @user
            user.fetch
                success: =>
                    @usermodel = user
                    # @usermodel.favs = @favs
                    callback @usermodel

    
    get_favs: (callback, options) ->
        if @favs
            callback @favs
        else
            collection = app.models.fav_users
            collection.fetch
                success: =>
                    @favs = collection
                    callback @favs

    # set_favs_to_user: () ->
    #     that = @
    #     @get_favs (collection) ->
    #         collection
    #         that.usermodel.favs = collection
    #     @usermodel


    getid: () ->
        @user

    mark_notifications: (id_list) ->
        for id in id_list
            $.post '/api/updates/'+id

    clear: (callback) ->
        @usermodel = false
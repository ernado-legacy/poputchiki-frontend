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
                    callback @usermodel

    getid: () ->
        @user

    clear: (callback) ->
        @usermodel = false
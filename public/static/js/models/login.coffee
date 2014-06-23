app.models.login = (sdata, callback, error) ->

    $.ajax
        type: "POST",
        url: "/api/auth/login",
        data: sdata,
        success: callback
        error: error
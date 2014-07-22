app.models.register = (sdata, callback, error) ->

    $.ajax
        type: "POST"
        url: "/api/auth/register"
        data: sdata
        success: callback
        error: error
        dataType: "json"
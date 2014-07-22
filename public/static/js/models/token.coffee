app.models.token = (callback, error) ->

    $.ajax
        type: "GET",
        url: "/api/token",
        success: callback
        error: error
        dataType: "json"
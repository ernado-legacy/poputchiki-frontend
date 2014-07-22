app.models.search = (data, callback) ->

    $.ajax
        type: "GET",
        url: "/api/search"
        data: data
        success: callback
        dataType: "json"
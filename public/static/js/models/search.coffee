app.models.search = (data, callback) ->

    $.ajax
        type: "GET",
        url: "/api/search"
        data: data
        success: callback
        dataType: "json"

app.models.searchphoto = (data, callback) ->

    $.ajax
        type: "GET",
        url: "/api/photo"
        data: data
        success: callback
        dataType: "json"
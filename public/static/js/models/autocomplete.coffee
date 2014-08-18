app.models.countries = (sdata, callback) ->

    $.ajax
        type: "GET",
        url: "/api/countries",
        data: sdata,
        success: callback
        dataType: "json"
        #error: error

app.models.cities = (sdata, callback) ->

    $.ajax
        type: "GET",
        url: "/api/cities",
        data: sdata,
        success: callback
        dataType: "json"
        #error: error

app.models.citypairs = (sdata, callback) ->

    $.ajax
        type: "GET",
        url: "/api/citypairs",
        data: sdata,
        success: callback
        dataType: "json"
        #error: error

app.models.places = (sdata, callback) ->

    $.ajax
        type: "GET",
        url: "/api/places",
        data: sdata,
        success: callback
        dataType: "json"
        #error: error
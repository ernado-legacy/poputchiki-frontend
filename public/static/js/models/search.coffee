app.models.search = (data, callback) ->
    console.log data
    str = ""
    if data.seasons_list
        if data.seasons_list.length <4
            for season in data.seasons_list
                str += "&"  unless str is ""
                str += "seasons" + "=" + season

    if data.destinations_list
        data.destinations_list.push 'Все страны'
        for dest in data.destinations_list
            str += "&"  unless str is ""
            str += "destinations" + "=" + dest

    for key of data
        str += "&"  unless str is ""
        str += key + "=" + data[key]
    $.ajax
        type: "GET",
        url: "/api/search"
        data: str
        success: callback
        dataType: "json"

app.models.searchphoto = (data, callback) ->
    str = ""
    if data.seasons_list
        if data.seasons_list.length <4
            for season in data.seasons_list
                str += "&"  unless str is ""
                str += "seasons" + "=" + season

    if data.destinations_list
        data.destinations_list.push 'Все страны'
        for dest in data.destinations_list
            str += "&"  unless str is ""
            str += "destinations" + "=" + dest

    for key of data
        if key!='seasons_list'
            str += "&"  unless str is ""
            str += key + "=" + data[key]

    $.ajax
        type: "GET",
        url: "/api/photo"
        data: str
        success: callback
        dataType: "json"
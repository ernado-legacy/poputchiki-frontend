app.views.Autocomplete = Backbone.View.extend

    events: 
        'keydown input': 'press'
        'focusout input': 'out'
        'focusout li.dl': 'lc'

    getdata: (val, callback) ->
        callback ["1","2","3"]

    press: (event) ->
        input = @$el.find 'input'
        droped = @$el.find '.droped'

        if event.which==13
            input.val $(droped.find('li')[0]).text()
            droped.css 'display', 'none'
            do event.preventDefault
            return

        val = input.val()
        @getdata val, (data) ->
            if _.size(data) != 0
                droped.html ''
                _.each data, (item) ->
                    droped.append '<li class="dl">' + item + '</li>'
                droped.css 'display', 'block' 
            else
                droped.css 'display', 'none'
        true

    out: ->
        setTimeout 200, =>
            droped = @$el.find '.droped'
            droped.css 'display', 'none'

    lc: (event) ->
        el = $ event.currentTarget
        text = el.text()
        input = @$el.find 'input'
        input.val text
        do @out

app.views.AutocompleteCountry = app.views.Autocomplete.extend
    
    getdata: (val, callback) ->
        app.models.countries
            start: val
        , callback

app.views.AutocompleteCity = app.views.Autocomplete.extend
    
    getdata: (val, callback) ->

        if country
            condition = false
        else
            country = @country.$el.find('input').val()
            condition = Boolean country

        if condition
            app.models.cities
                start: val
                country: country
            , callback
        else
            app.models.citypairs
                start: val
            , (data) -> 
                d = _.map data, (item) ->
                    data.title
                callback d
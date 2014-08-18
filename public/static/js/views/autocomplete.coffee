app.views.Autocomplete = Backbone.View.extend

    events: 
        'keyup input': 'press'
        'focusout input': 'out'
        'click li.dl': 'lc'

    getdata: (val, callback) ->
        callback ["1","2","3"]

    press: (event) ->
        input = @$el.find 'input'
        droped = @$el.find '.droped'

        if event.which==13
            input.val $(droped.find('li')[0]).text()
            droped.css 'display', 'none'
            @afterchange()
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
        setTimeout (=>
            droped = @$el.find '.droped'
            droped.css 'display', 'none'
        ), 200

    lc: (event) ->
        el = $ event.currentTarget
        text = el.text()
        input = @$el.find 'input'
        input.val text
        @afterchange()
        do @out

    afterchange: () ->
        return

app.views.AutocompleteCountry = app.views.Autocomplete.extend
    
    getdata: (val, callback) ->
        app.models.countries
            start: val
        , callback

app.views.AutocompleteCity = app.views.Autocomplete.extend
    
    getdata: (val, callback) ->

        if not @country
            condition = false
        else
            country = @country.$el.find('input').val()
            condition = Boolean country

        #REMOVE IT!!!!11
        #condition = false

        if not condition
            app.models.citypairs
                start: val
            , (data) -> 
                d = _.map data, (item) ->
                    item.title
                callback d
        else
            app.models.cities
                start: val
                country: country
            , callback #(data) -> 
            #    d = _.map data, (item) ->
            #        item.title
            #    callback d
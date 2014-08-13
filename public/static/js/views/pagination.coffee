app.views.Pagination = Backbone.View.extend

    events:
        'click .paginationitem': 'change'

    change: (event) ->
        t = $ event.currentTarget
        @$el.find('button').removeClass 'active'
        t.addClass 'active'
        int = parseInt t.text()
        @reaction int

    setreaction: (callback) ->
        @reaction = callback

    render: (count) ->
        @$el.html ''
        _.each _.range(1, count), (item) =>
            @$el.append '<button>'+item+'</button>'
        @$el.find('button').addClass 'paginationitem'
        @$el.find('button:first').addClass 'active'
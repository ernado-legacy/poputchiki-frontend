app.views.Pagination = Backbone.View.extend

    events:
        # 'click .paginationitem': 'change'
        'click .paginationitem.page-prev.active': 'page_prev'
        'click .paginationitem.page-next.active': 'page_next'
        
    page_prev: (event)->
        t = $ event.currentTarget
        @$el.find('button').removeClass 'active'
        t.addClass 'active'
        int = t.data 'page'
        @$el.find('.page-prev').data 'page', int-1
        @$el.find('.page-next').data 'page', int+1
        @$el.find('.page-next').addClass 'active'
        t.removeClass 'active' if int==1
        app.views.search.current_page = int
        @reaction int
    page_next: (event)->
        t = $ event.currentTarget
        @$el.find('button').removeClass 'active'
        t.addClass 'active'
        int = t.data 'page'
        @$el.find('.page-prev').data 'page', int-1
        @$el.find('.page-next').data 'page', int+1
        @$el.find('.page-prev').addClass 'active'
        t.removeClass 'active' if int==@count-1
        app.views.search.current_page = int
        @reaction int
    change: (event) ->
        t = $ event.currentTarget
        @$el.find('button').removeClass 'active'
        t.addClass 'active'
        int = parseInt t.text()
        @reaction int

    setreaction: (callback) ->
        @reaction = callback

    render: (count) ->
        @count = count
        @current = 1
        @$el.html ''
        @$el.append '<button class="page-prev" data-page='+(@current-1)+'><span class="fui-arrow-left"></span></button>'
        @$el.append '<button class="page-next active" data-page='+(@current+1)+'><span class="fui-arrow-right"></span></button>'
        # _.each _.range(1, count), (item) =>
        #     @$el.append '<button>'+item+'</button>'
        @$el.find('button').addClass 'paginationitem custom-blue-link'
        # @$el.find('button:first').addClass 'active'
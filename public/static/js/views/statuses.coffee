app.views.Statuses = Backbone.View.extend

    el: '.mainContentProfile'

    render: ->
        history.pushState null, 'poputchiki', '/statuses/'
        $ @$el.html jade.templates.statuses()

    getstatuses: ->
        statuses = new app.models.Statuses
        statuses.fetch
            data:
                offset: 0
                count: 100
            processData: true
            success: ->
                console.log statuses

    newstatus: ->
        status = new app.models.Status
        status.text = "hello"
        #status.user = app.models.myuser.getid()
        status.save()
        #$.ajax
        #    type: "PUT",
        #    url: "/api/status",
            #success: callback
            #error: error
        #    dataType: "json"
        #    data:
        #        text: "hello"
        #        user: app.models.myuser.getid()
deviceDetection = ->
    ua = navigator.userAgent;
    device = ua.match /(iPhone|iPod|iPad|Android|BlackBerry|Opera Mini|IEMobile)/
    device

mobileVersion = (device) ->
    if not device
        $('body').addClass 'desktop'

app.views.Main = Backbone.View.extend

    el: 'body'

    events: 
        'click .aboutInfo li': 'clickfooter'
        'click .clicklogin': 'clicklogin'
        'click .loginRegisterBlock .terms': 'terms'
        # 'header.info-header .navigation li': 'clickfooter'

    init: ->
        app.views.aboutus = new app.views.AboutUs
        app.views.terms = new app.views.Terms
        app.views.rating = new app.views.Rating
        return

    terms: ->
        history.pushState null, 'poputchiki', '/terms/'
        do app.views.terms.render

    clickfooter: (event) ->
        target = $ event.currentTarget
        switch target.attr 'data-view'
            when 'aboutus'
                history.pushState null, 'poputchiki', '/about/'
            when 'terms'
                history.pushState null, 'poputchiki', '/terms/'
        
        view = app.views[target.attr 'data-view']
        do view.render

    clicklogin: ->
        app.views.login.render()

$ ->
    app.views.main = new app.views.Main
    app.views.main.init()
    mobileVersion deviceDetection()
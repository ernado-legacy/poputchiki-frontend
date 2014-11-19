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
        app.views.contacts = new app.views.Contacts
        app.views.notfound = new app.views.NotFound
        
        @.on 'changeMetaTags',(title,desc)->
            document.title = title
            if desc
                $('meta[name=description]').attr('content',desc)

        @.on 'main:about',()->
            history.pushState null, 'poputchiki', '/about/'
            do app.views.aboutus.render

        @.on 'main:terms',()->
            history.pushState null, 'poputchiki', '/terms/'
            do app.views.terms.render

        @.on 'main:contacts',()->
            history.pushState null, 'poputchiki', '/contacts/'
            do app.views.contacts.render
        @.on 'main:404',(title)->
            # history.pushState null, 'poputchiki', '/contacts/'
            app.views.notfound.render title

        if window.location.pathname.search('/about/') != -1
            app.views.main.trigger('main:about')

        if window.location.pathname.search('/terms/') != -1
            app.views.main.trigger('main:terms')

        if window.location.pathname.search('/contacts/') != -1
            app.views.main.trigger('main:contacts')

        return

    terms: ->
        history.pushState null, 'poputchiki', '/terms/'
        do app.views.terms.render

    clickfooter: (event) ->
        target = $ event.currentTarget
        switch target.attr 'data-view'
            when 'aboutus'
                @trigger 'main:about'
            when 'terms'
                @trigger 'main:terms'
            when 'contacts'
                @trigger 'main:contacts'
        
        view = app.views[target.attr 'data-view']
        do view.render

    clicklogin: ->
        app.views.login.render()

$ ->
    app.views.main = new app.views.Main
    app.views.main.init()
    mobileVersion deviceDetection()
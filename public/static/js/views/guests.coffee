app.views.Guests = Backbone.View.extend


    el: '.mainContentProfile'


    # get_my_user: (callback) ->
    #     collection = app.models.Guests
    #         id: $.cookie 'user'
    #     user.fetch
    #         success: ->
    #             callback user

    initialize: ->
        @new_guests = false
        do @ask_for_new_guests

    ask_for_new_guests: ->
        that = @
        $.get '/api/updates/counters',
            (data)->
                for item in  data
                    if item.type== 'guests' and item.count>0
                        that.new_guests = true
                        $('#menu-photos .menuIcon.new div').text item.count
                        do $('#menu-photos .menuIcon.new div').show
            ,
            'json'

    mark_new_guests: (callback)->
        $.post '/api/updates?type=guests',
            (data)->
                do callback
            ,
            'json'

        

    render: ()->
        console.log @new_guests
        if @new_guests
            @mark_new_guests ->
                $('#menu-photos .menuIcon.new div').hide("drop")

        that = @
        history.pushState null, 'poputchiki', '/guests/'
        app.views.profile.get_my_user (user) ->
            user.updateDate 'vip_till'
            collection = new app.models.Guests [], id:user.get('id')
            collection.fetch().done () ->
                $ that.$el.html jade.templates.guests
                    user: user.attributes
                    guests: collection.toJSON()
                that.renderGuest guest for guest in collection.models
                $('#menu-photos').addClass 'current'

    renderGuest: (user) ->
        user.updateDate('time')
        listUserView = new app.views.UserListView 
            model:user,
            template:jade.templates.guest_user_list
        $('.guests .chatLine').append listUserView.render()

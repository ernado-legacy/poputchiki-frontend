app.views.Guests = Backbone.View.extend


    el: '.mainContentProfile'


    # get_my_user: (callback) ->
    #     collection = app.models.Guests
    #         id: $.cookie 'user'
    #     user.fetch
    #         success: ->
    #             callback user

    initialize: ->
        @new_guests = []
        # do @ask_for_new_guests

    ask_for_new_guests: ->
        that = @
        $.get '/api/updates?type=guests',
            (data)->
                for item in  data
                    that.new_guests.push item.id
                    # if item.type== 'guests' and item.count>0
                $('#menu-photos .menuIcon.new div').text that.new_guests.length
                do $('#menu-photos .menuIcon.new div').show
            ,
            'json'

    mark_new_guests: ->
        $.get '/api/updates?type=guests',
            (data)->
                # for item in  data
                #     if item.type== 'guests' and item.count>0
                #         $('#menu-photos .menuIcon.new div').text item.count
                for i in data
                    console.log i
            ,
            'json'

        

    render: ()->
        # do @mark_new_guests
        # do $('#menu-photos .menuIcon.new div').hide
        app.models.myuser.mark_notifications @new_guests

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

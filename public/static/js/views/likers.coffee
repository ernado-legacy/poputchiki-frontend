app.views.Likers = Backbone.View.extend


    el: '.popupLikers'

    # events: 

    events: 
        'click .active-vip': 'activateVip'

    render: (likers_url,callback)->
        
        that = @
        @$el.find('.guests .chatLine').append("<img src='http://poputchiki/static/img/searchpreloader.GIF' class='loading-gif')'>")
        do callback
        app.views.profile.get_my_user (user) ->
            collection = new app.models.Likers
            collection.url = likers_url
            collection.fetch().done () ->
                # $ that.$el.html jade.templates.guests
                #     user: user.attributes
                #     guests: collection.toJSON()
                that.$el.find('.guests .chatLine').empty()
                that.renderGuest guest for guest in collection.models

    renderGuest: (user) ->
        user.updateDate('last_action')
        listUserView = new app.views.UserListView 
            model:user,
            template:jade.templates.likers_user_list
        @$el.find('.guests .chatLine').append listUserView.render()




    # activateVip: (e)->
    #     that = @
    #     $.ajax
    #         url: '/api/vip/'+$(e.currentTarget).data('vip-time')
    #         type: 'POST'
    #         dataType: "json"
    #         success: (data) ->
    #             that.$el.find('.bilContainer').remove()
    #             that.$el.find('form').append jade.templates.popup_vip_success()
    #             console.log data
    #             app.models.myuser.clear ->
    #         error: (data, textStatus, jqXHR) ->
    #             that.$el.find('.bilContainer').remove()
    #             that.$el.find('form').append jade.templates.popup_vip_error()
    #             console.log 'error'
    #             console.log jqXHR
                    

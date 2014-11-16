app.views.VipStatus = Backbone.View.extend


    el: '.vipPopup'

    # events: 

    events: 
        'click .active-vip': 'activateVip'

    activateVip: (e)->
        that = @
        $.ajax
            url: '/api/vip/'+$(e.currentTarget).data('vip-time')
            type: 'POST'
            dataType: "json"
            success: (data) ->
                that.$el.find('.bilContainer').remove()
                that.$el.find('form').append jade.templates.popup_vip_success()
                app.models.myuser.clear ->
            error: (data, textStatus, jqXHR) ->
                that.$el.find('.bilContainer').remove()
                that.$el.find('form').append jade.templates.popup_vip_error()
                    

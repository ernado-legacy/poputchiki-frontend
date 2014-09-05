app.views.LetsGo = Backbone.View.extend
    el: '.letsgoPopup'

    events: 
        'click #send-lg-popup': 'send'

    send: ->
        
        # console.log 
        # console.log @$el.find('#popup-phone').val()
        phone = @$el.find('#popup-phone').val()
        country = @$el.find('#popup-select').val()
        if (not country) or (not phone)
            @$el.toggleClass 'shiv-block'
        else
            data = 
                phone : phone,
                country: country
            $.ajax
                url: '/api/travel/'
                type: 'POST'
                data: JSON.stringify data
                dataType: "json"
                contentType: "application/json; charset=utf-8"
                success: (data) ->
                    app.views.entered.closepopuprun()
                    app.views.entered.info_popup_custom 'Спасибо за заявку!', 'Наши операторы свяжутся с вами в ближайшее время'
                error: (data, textStatus, jqXHR) ->
                    app.views.entered.closepopuprun()
                    app.views.entered.info_popup_custom 'Внимание!', 'Что-то пошло не так'
                    

            
        

    # activateVip: (e)->
    # #     that = @
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
                    

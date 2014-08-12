app.views.VipStatus = Backbone.View.extend


    el: '.vipPopup'

    # events: 

    events: 
        'click .active-vip': 'activateVip'

    activateVip: (e)->
        $.ajax
            url: '/api/vip/'+$(e.currentTarget).data('vip-time')
            type: 'POST'
            dataType: "json"
            success: (data) ->
                console.log data

app.views.Presents = Backbone.View.extend

    el: '.presetnsPopup'
    events:
        'click .imgBox':'choose_present'
        'click .add-to-promo.active':'send_present'

    choose_present: (e)->
        @$el.find('.imgBox').removeClass('choosed')
        $(e.currentTarget).toggleClass('choosed')
        @$el.find('.present-for-user-cost').text $(e.currentTarget).data 'present-cost'
        @$el.find('.add-to-promo').addClass('active')
        
        
    send_present: ()->
        present_id = @$el.find('.choosed').data 'id'
        model = @collection.get present_id
        model.trigger 'present:send', @user_id


    initialize: ->
        @on 'presents:popup', (user_id)->
            @popupPresents user_id


    popupPresents: (user_id)->
        @user_id = user_id
        collection = new app.models.Presents
        
        # presentes.fetch
        #     success: (data)=>
        #         console.log data
        collection.fetch().done () =>
            @collection = collection
            hash = collection.groupBy (val, index) ->
                Math.floor index / 3
            arrays = _.map hash, (item) -> item
            @$el.find('form .wrp').html jade.templates.present
                arrays: arrays
        app.views.entered.showpopup('.presetnsPopup')



    renderUserPresents: ()->
        $('.userPresentsBox .presents-container').html jade.templates.user_presents
            presents: 2
app.views.PopupPhoto = Backbone.View.extend

    el: '.photoPopup'

    events: 
        'click .like':'like'
        'click .unlike':'unlike'
        'click .infoBox a':'preventlink'
        'click .infoBox a img':'link_to_user'


    preventlink: (e)->
        do e.preventDefault
        return false
    # link_to_user: (e)->
    #     window.location.href = $('.infoBox a').attr 'href'


    changeuser: (user,photoView) ->
        @photoView = photoView
        @user = user
        attrs = {}
        attrs.user = user
        if photoView
            attrs.liked_by = photoView.liked_by
        else
            attrs.liked_by = false
        @$el.find('.infoBox').html jade.templates.popup_photo_infobox attrs

    clearuser: (user) ->
        @$el.find('.infoBox').html ''

    like: ->
        @photoView.model.like (likes)=>
            @$el.find('.fui-heart').removeClass('like')
            @$el.find('.fui-heart').addClass('unlike')

        return false

    unlike: ->
        @photoView.model.unlike (likes)=>
            @$el.find('.fui-heart').addClass('like')
            @$el.find('.fui-heart').removeClass('unlike')
        return false
app.views.PopupPhoto = Backbone.View.extend

    el: '.photoPopup'

    changeuser: (user) ->
        @$el.find('.infoBox').html jade.templates.popup_photo_infobox
            user: user
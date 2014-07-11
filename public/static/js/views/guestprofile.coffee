app.views.GuestProfile = Backbone.View.extend

    el: '.mainContentProfile'

    initialize: ->
    	id = window.location.href.split('/').slice(4)[0]
    	@.model = new app.models.User 
            id: id
        @.model.fetch()
        return

    get_my_user: (callback) ->
        user = new app.models.User 
            id: window.location.href.split('/').slice(4)[0]
        user.fetch
            success: ->
                callback user



    render: ->
    	that = @
    	@get_my_user (user) ->
            $ that.$el.html jade.templates.guest_profile
                user: user.attributes
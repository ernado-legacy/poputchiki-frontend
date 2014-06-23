app.views.Profile = Backbone.View.extend

    el: '.mainContentProfile'

    get_my_user: (callback) ->
        user = new app.models.User 
            id: $.cookie 'user'
        user.fetch
            success: ->
                console.log user

    render: ->
        user = @get_my_user
        $ @.$el.html jade.templates.profile
            user: user
        do profile_script

$ ->
    app.views.profile = new app.views.Profile
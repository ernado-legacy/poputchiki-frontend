app.views.GuestProfile = app.views.UserListView.extend

    el: '.mainContentProfile'

    events:
        'click #guest_profile .write': 'write'
        'click #guest_profile .add_to_fav': 'add_to_fav'
        'click #guest_profile .remove_from_fav': 'remove_from_fav'
        'click #guest_profile .to_journey': 'to_journey'

    initialize: ->
        # id = window.location.href.split('/').slice(4)[0]
        # @.model = new app.models.User 
        #     id: id
        # @.model.fetch()
        # return
        @custom_tag_id = "guest_profile"

    get_user: (callback) ->
        user = new app.models.User 
            id: window.location.pathname.split('/').slice(2)[0]
        user.fetch
            success: ->
                @model = user
                callback user

    set_user: (id) ->
        history.pushState null, 'poputchiki', '/user/' + id

    render: ->
        that = @
        @get_user (user) ->
            app.models.myuser.get (my_user)->
                # is_fav = false
                is_fav = if my_user.get('favorites').indexOf(user.get('id')) != -1 then true else false
                that.model = user
                app.views.user_photo_block.render(window.location.pathname.split('/').slice(2)[0])
                user_id = app.models.myuser.getid()
                user.visit_user_by() if user_id
                $ that.$el.html jade.templates.guest_profile
                    user: user.attributes,
                    is_fav: is_fav

    add_to_fav: ->
        @model.add_to_fav false
        do @render

    remove_from_fav: ->
        @model.add_to_fav true
        do @render

app.views.GuestProfile = app.views.UserListView.extend

    el: '.mainContentProfile'

    events:
        'click #guest_profile .write': 'write'
        'click #guest_profile .add_to_fav': 'add_to_fav'
        'click #guest_profile .remove_from_fav': 'remove_from_fav'
        'click #guest_profile .to_journey': 'to_journey'
        'click #guest_profile .to_blacklist': 'to_blacklist'
        'click .profileGuest .imgBox': 'avatar_open'
        'click .search-comback a': 'back_to_search'
        'click .send-present': 'send_present_to_this_user'
        'click .user-present img': 'send_present_to_this_user'

    send_present_to_this_user: ->
        app.views.presents.trigger('presents:popup', @model.get('id'))
        

    back_to_search: (e)->
        e.preventDefault()
        do app.views.search.render



    avatar_open: ->
        do $('img#'+@model.get('avatar')).click

    initialize: ->
        @custom_tag_id = "guest_profile"

    get_user: (callback) ->
        user = new app.models.User 
            id: window.location.pathname.split('/').slice(2)[0]
        user.fetch
            success: ->
                @model = user
                callback user
            error: ->
                app.views.main.trigger('main:404','Пользователен не существует либо удален!')

    set_user: (id) ->
        history.pushState null, 'poputchiki', '/user/' + id

    renderWithCallback: (callback)->
        @render
        do callback

    render: (after) ->
        that = @
        @get_user (user) ->
            app.models.myuser.get (my_user)->
                if user.get('id') == my_user.get('id')
                    do app.views.profile.render
                    if after
                        do after
                    return false
                if my_user.get('favorites')
                    is_fav = if my_user.get('favorites').indexOf(user.get('id')) != -1 then true else false
                else
                    is_fav = false
                    
                if my_user.get('blacklist')
                    is_in_blacklist = if my_user.get('blacklist').indexOf(user.get('id')) != -1 then true else false
                else 
                    is_in_blacklist = false
                that.model = user
                app.views.user_photo_block.render(window.location.pathname.split('/').slice(2)[0], false)
                user_id = app.models.myuser.getid()
                user.visit_user_by() if user_id
                user.updateDate 'last_action'
                user.updateDate 'birthday'
                # user.set 'zodiac', user.get_zodiac_sign(new Date user.get 'birthday').eng
                do user.update_zodiac_sign
                $ that.$el.html jade.templates.guest_profile
                    user: user.attributes,
                    is_fav: is_fav
                    is_in_blacklist: is_in_blacklist
                app.views.main_status.render user
                app.views.presents.renderUserPresents user.get 'id'
                do $('#profile-slidedown').click
                if after
                    do after

    add_to_fav: ->
        do @model.add_to_fav 
        @$el.find('.fav-action .fui-star-2.act').css('color','grey')
        @$el.find('.fav-action .myaction').removeClass 'add_to_fav'
        # @$el.find('.fav-action').removeClass 'add_to_fav'
        # @$el.find('.fav-action').addClass 'remove_from_fav'
        @$el.find('.fav-action .myaction').empty()
        @$el.find('.fav-action .myaction').append '<a class="remove_from_fav custom-link">Убрать из избранных</a>'


    remove_from_fav: ->
        do @model.remove_from_fav
        @$el.find('.fav-action .fui-star-2.act').css 'color','#03aada'
        do @$el.find('.fav-action .myaction').empty
        @$el.find('.fav-action .myaction').removeClass 'remove_from_fav'
        @$el.find('.fav-action .myaction').addClass 'add_to_fav'
        # @$el.find('.fav-action').addClass 'add_to_fav'
        @$el.find('.fav-action .myaction').text 'Добавить в избранное'


    to_blacklist: (e)->
        that = @
        app.models.myuser.get (my_user)->
            if my_user.get('blacklist') and my_user.get('blacklist').indexOf(@model.get('id')) != -1
                @model.add_to_blacklist true
                $(e.currentTarget).closest('.add').first().removeClass('in_blacklist').addClass('not_in_blacklist')
                $(e.currentTarget).text('добавить в черный список')
                # console.log $(e.currentTarget).closest('add').remove()
                # $('.add.in_blacklist').removeClass('in_blacklist').addClass('not_in_blacklist')
            else
               @model.add_to_blacklist false
               $(e.currentTarget).closest('.add').first().removeClass('not_in_blacklist').addClass('in_blacklist')
               $(e.currentTarget).text('убрать из черного списка')
               # console.log $(e.currentTarget).closest('add').remove()
               # $('.add.not_in_blacklist').removeClass('not_in_blacklist').addClass('in_blacklist')

    to_journey: ->
        do @model.invite_to_travel
        @$el.find('.to_journey').text 'Вы пригласили '+ @model.get('name') + ' в путешествие'
        @$el.find('.to_journey').removeClass('to_journey')



app.views.GuestProfileUnsigned = app.views.UserListView.extend

    el: '.mainContentProfile'

    events:
        'click #guest_profile .write': 'write'
        'click #guest_profile .add_to_fav': 'add_to_fav'
        'click #guest_profile .remove_from_fav': 'remove_from_fav'
        'click #guest_profile .to_journey': 'to_journey'
        'click #guest_profile .to_blacklist': 'to_blacklist'
        'click .profileGuest .imgBox': 'avatar_open'


    avatar_open: ->
        do $('img#'+@model.get('avatar')).click

    initialize: ->
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

    renderWithCallback: (callback)->
        @render
        do callback

    render: () ->
        that = @
        do app.views.stripe_unsigned.render
        @get_user (user) ->
            is_fav = false
            is_in_blacklist = false
            that.model = user
            app.views.user_photo_block_unsigned.render(window.location.pathname.split('/').slice(2)[0], false)
            user.updateDate 'last_action'
            user.updateDate 'birthday'
            # user.set 'zodiac', user.get_zodiac_sign(new Date user.get 'birthday').eng
            do user.update_zodiac_sign
            $ that.$el.html jade.templates.guest_profile
                user: user.attributes,
                is_fav: is_fav
                is_in_blacklist: is_in_blacklist
            app.views.main_status_unsigned.render user
            do $('#profile-slidedown').click

    add_to_fav: ->
        do @model.add_to_fav 
        @$el.find('.fav-action .fui-star-2.act').css('color','grey')
        @$el.find('.fav-action .myaction').removeClass 'add_to_fav'
        # @$el.find('.fav-action').removeClass 'add_to_fav'
        # @$el.find('.fav-action').addClass 'remove_from_fav'
        @$el.find('.fav-action .myaction').empty()
        @$el.find('.fav-action .myaction').append '<a class="remove_from_fav custom-link">Убрать из избранных</a>'


    remove_from_fav: ->
        do @model.remove_from_fav
        @$el.find('.fav-action .fui-star-2.act').css 'color','#03aada'
        do @$el.find('.fav-action .myaction').empty
        @$el.find('.fav-action .myaction').removeClass 'remove_from_fav'
        @$el.find('.fav-action .myaction').addClass 'add_to_fav'
        # @$el.find('.fav-action').addClass 'add_to_fav'
        @$el.find('.fav-action .myaction').text 'Добавить в избранное'


    to_blacklist: (e)->
        that = @
        app.models.myuser.get (my_user)->
            if my_user.get('blacklist').indexOf(@model.get('id')) != -1
                @model.add_to_blacklist true
                $(e.currentTarget).closest('.add').first().removeClass('in_blacklist').addClass('not_in_blacklist')
                $(e.currentTarget).text('добавить в черный список')
                # console.log $(e.currentTarget).closest('add').remove()
                # $('.add.in_blacklist').removeClass('in_blacklist').addClass('not_in_blacklist')
            else
               @model.add_to_blacklist false
               $(e.currentTarget).closest('.add').first().removeClass('not_in_blacklist').addClass('in_blacklist')
               $(e.currentTarget).text('убрать из черного списка')
               # console.log $(e.currentTarget).closest('add').remove()
               # $('.add.not_in_blacklist').removeClass('not_in_blacklist').addClass('in_blacklist')

    to_journey: ->
        do @model.invite_to_travel
        @$el.find('.to_journey').text 'Вы пригласили '+ @model.get('name') + ' в путешествие'
        @$el.find('.to_journey').removeClass('to_journey')

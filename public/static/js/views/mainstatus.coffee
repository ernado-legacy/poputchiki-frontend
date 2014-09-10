app.views.userMainStatus = app.views.Status.extend
    

    events:
        'keyup input': 'press'
        'click #edit-status': 'openeditstatus'
        'click .newStatus': 'opennewstatus'
        'click #write-new-main-status': 'updatestatus'
        'click .like': 'like'

    press: (event)->
        if event.which==13
            do $('#write-new-main-status').click
    get_status_id: ->
        @$el.attr 'data-status'

    render: (user)->
        if user.get 'status'
            @user_id = user.get 'id'
            status = new app.models.MyStatus 'user':user.get('id')
            that = @
            status.fetch
                success: =>
                    that.statusmodel = status
                    # that.updalike
                    that.size = status.get('liked_users').length
                    is_mystatus = if app.models.myuser.getid() == user.get 'id' then true else false
                    is_liked = true if app.models.myuser.getid() in status.get 'liked_users'
                    $('.wantToTravelBox').html that.$el.html jade.templates.usermainstatus
                            status: status
                            is_mystatus: is_mystatus
                            is_liked: is_liked
                    that.$el.attr 'data-status', status.get 'id'
                    that.status = status
                    that.update_layout is_liked,_.size(status.get('liked_users'))
                    do that.delegateEvents
        else
            @user_id = user.get 'id'
            status = new app.models.MyStatus 'user':user.get('id')
            is_mystatus = false
            is_liked = false
            @$el.addClass 'new-clear-status'
            $('.wantToTravelBox').html @$el.html jade.templates.usermainstatusnew()
            do @delegateEvents

    openeditstatus: ->
        $('#new-status').val @status.get 'text'
        $("#main-status").slideUp "slow"
        $(".statusBoxEdit").slideDown "slow"
        $('#write-new-main-status').data "mode", 'edit'

    opennewstatus: ->
        $('#new-status').val('')
        $('#new-status').attr 'placeholder','Введите новый статус'
        $("#main-status").slideUp "slow"
        $(".statusBoxEdit").slideDown "slow"
        $('#write-new-main-status').data "mode", 'new'

    updatestatus: (e)->
        if $('#new-status').val() == ''
            $('.wantToTravelBox').toggleClass 'shiv-block'
            # $('.loginRegisterBlock').removeClass 'shiv-block'
        else
            if $(e.currentTarget).data('mode')== 'new'
                do @newstatus
            else
                do @editstatus

    editstatus: ->
        if $('#new-status').val() == @status.get 'text'
            $("#main-status").slideDown "slow"
            $(".statusBoxEdit").slideUp "slow"
        else
            @status.save 'text': $('#new-status').val(),
                success: =>
                    $('#main-status .status').text @status.get 'text'
                    $("#main-status").slideDown "slow"
                    $(".statusBoxEdit").slideUp "slow"

    newstatus: ->
        that = @
        status = new app.models.Status
        status.set 'text', $('#new-status').val()
        #status.user = app.models.myuser.getid()
        status.save null,
            success: =>
                do app.views.statuses.getstatuses
                @status = status
                app.models.myuser.get (myuser) =>
                    @render myuser
                $('#main-status .status').text status.get 'text'
                $("#main-status").slideDown "slow"
                $(".statusBoxEdit").slideUp "slow"
            error: =>
                app.models.myuser.get (myuser) =>
                    if myuser.get 'vip'
                        do @$el.find('.popup-info').click
                    else
                        do app.views.entered.vip_popup
                    $("#main-status").slideDown "slow"
                    $(".statusBoxEdit").slideUp "slow"
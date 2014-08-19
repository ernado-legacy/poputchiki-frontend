app.views.userMainStatus = Backbone.View.extend #_.extend app.mixins.SlideRigtBlock,
    # app.views.Status.extend

    events: 
        'click #edit-status': 'openeditstatus'
        'click .newStatus': 'opennewstatus'
        'click #write-new-main-status': 'updatestatus'
        'click .like': 'like'


    get_status_id: ->
        @$el.attr 'data-status'

    render: (user)->
        if user.get 'status'
            @user_id = user.get 'id'
            status = new app.models.MyStatus 'user':user.get('id')
            that = @
            status.fetch
                success: =>
                    is_mystatus = if app.models.myuser.getid() == user.get 'id' then true else false
                    is_liked = true if app.models.myuser.getid() in status.get 'liked_users'
                    $('.wantToTravelBox').html that.$el.html jade.templates.usermainstatus
                            status: status
                            is_mystatus: is_mystatus
                            is_liked: is_liked
                    that.$el.attr 'data-status', status.get 'id'
                    that.status = status
                    do that.delegateEvents

    openeditstatus: ->
        $('#new-status').val @status.get 'text'
        $("#main-status").slideUp "slow"
        $(".statusBoxEdit").slideDown "slow"
        $('#write-new-main-status').data "mode", 'edit'

    opennewstatus: ->
        $('#new-status').val('')
        $('#new-status').attr 'placeholder','Введите нвоый статус'
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
        #$.ajax
        #    type: "PUT",
        #    url: "/api/status",
            #success: callback
            #error: error
        #    dataType: "json"
        #    data:
        #        text: "hello"
        #        user: app.models.myuser.getid()

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
                $('#main-status .status').text status.get 'text'
                $("#main-status").slideDown "slow"
                $(".statusBoxEdit").slideUp "slow"
            error: =>
                do app.views.entered.vip_popup
                $("#main-status").slideDown "slow"
                $(".statusBoxEdit").slideUp "slow"
    
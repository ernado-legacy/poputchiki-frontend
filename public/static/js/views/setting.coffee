app.views.Setting = Backbone.View.extend

    el: '.mainContentProfile'
    events: 
        'click .settings-menu ul a': 'render'

    render: (e)->

        settinghash =
            'profile': app.views.SettingsProfile,
            'password': app.views.SettingsPassword,
            'email': app.views.SettingsEmail,
            'payment': app.views.SettingsPayment,
            'invisible': app.views.SettingsInvisible,
            'blacklist': app.views.SettingsBlackList,
            
            

        id = 'profile'
        if window.location.pathname.search('/password') != -1
            id = 'password'

        if window.location.pathname.search('/email') != -1
            id = 'email'
        if window.location.pathname.search('/payment') != -1
            id = 'payment'
        if window.location.pathname.search('/invisible') != -1
            id = 'invisible'
        if window.location.pathname.search('/blacklist') != -1
            id = 'blacklist'
        if e
            do e.preventDefault
            id = $(e.currentTarget).data('id') 

        console.log id

        $ @$el.html jade.templates.settings
        view = settinghash[id]
        app.models.myuser.get (user) ->
            v = new view model: user
            v.render id
            $('.leftMenu li').removeClass 'current'
            $('#menu-tools').addClass 'current'


app.mixins.RenderSettingItem = 
    tagName: 'div'
    className: 'setting-item'
    events: 
        'click .profile-edit-slideup span': 'clck'

    render: (id) ->
        history.pushState null, 'poputchiki', '/settings/'+id
        that = @
        $('.settings .rightBox').html @$el.html @.template
                user: @model.attributes

    changeUserSettings: (callback)->
        do callback
        do app.models.myuser.clear
    
            


app.views.SettingsProfile = Backbone.View.extend _.extend app.mixins.RenderSettingItem,
    template: jade.templates.settingsprofile
    # render: ()->
    #     @renderItem jade.templates.settingsprofile, 'profile'
    clck: ->
        console.log 'save profile'

app.views.SettingsPassword = Backbone.View.extend _.extend app.mixins.RenderSettingItem,
    template: jade.templates.settingspassword

    clck: ->
        that = @
        @changeUserSettings ->
            formData = {}
            input = that.$el.find('input[name=pass]')
            input2 = that.$el.find('input[name=passagain]')
            console.log input.val()
            console.log input2.val()
            if input.val() and (input.val() == input2.val())
                formData['password'] = input.val()
                that.model.set formData
                that.model.save formData, patch: true if _.size(that.model.changed)>0
                that.$el.find('.currentEmail a').text(formData[input.attr('name')])
            else
                alert 'введите верный пароль'


app.views.SettingsEmail = Backbone.View.extend _.extend app.mixins.RenderSettingItem,
    template: jade.templates.settingsemail
    
    clck: ->
        that = @
        @changeUserSettings ->
            formData = {}
            input = that.$el.find('input[name=email]')
            input2 = that.$el.find('input[name=emailagain]')
            if input.val() and (input.val() == input2.val())
                formData[input.attr('name')] = input.val()
                that.model.set formData
                that.model.save formData, patch: true if _.size(that.model.changed)>0
                that.$el.find('.currentEmail a').text(formData[input.attr('name')])
            else
                alert 'введите верный имейл'

app.views.SettingsInvisible = Backbone.View.extend _.extend app.mixins.RenderSettingItem,
    template: jade.templates.settingsinvisible
    clck: ->
        that = @
        @changeUserSettings ->
            formData = {}
            checked = if that.$el.find('.box').hasClass('checked') then true else false
            formData['invisible'] = checked
            console.log formData
            that.model.save formData, patch: true if _.size(that.model.changed)>0

app.views.SettingsPayment = Backbone.View.extend _.extend app.mixins.RenderSettingItem,
    template: jade.templates.settingspayment
    events:
        'click.payment .pay': 'pay'
    pay: (e)->
        window.location.href = '/api/pay/'+$(e.currentTarget).data('sum')

app.views.SettingsBlackList = Backbone.View.extend _.extend app.mixins.RenderSettingItem,
    template: jade.templates.settingsblacklist
    events: ->
        'click a.remove_from_blacklist':'remove_from_blacklist'
    render: ->
        history.pushState null, 'poputchiki', '/settings/blacklist'
        collection = new app.models.BlackList [], id:@model.get('id')
        that = @
        collection.fetch().done () ->
            $('.settings').append that.$el.html that.template
                users: collection.toJSON()

    remove_from_blacklist: (e)->
        
        data = target : $(e.currentTarget).data('user-id')
        $.ajax
            url: '/api/user/'+app.models.myuser.getid()+'/blacklist'
            type: 'DELETE'
            data: JSON.stringify data
            dataType: "json"
            contentType: "application/json; charset=utf-8"
            success: (data) ->
                $(e.currentTarget).parents('li').remove()
                app.models.myuser.clear ->        
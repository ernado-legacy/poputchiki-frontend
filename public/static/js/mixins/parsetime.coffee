app.mixins.ParseTime = 
    parsetimeparam: (param_name, response) ->
        for item in response
            # user = @parseLastActionParameter item  
            time_param = new Date user.time
            user[param_name] = 
                date: time_param.getDate()+"."+time_param.getMonth()+"."+(time_param.getYear()*1+1900)
                time: time_param.getHours()+":"+time_param.getMinutes()
        response
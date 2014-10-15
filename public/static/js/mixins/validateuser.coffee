app.mixins.UserValidationMixin = 
    patterns: 
        specialCharacters: "[^a-zA-Z 0-9]+",
        digits: "[0-9]",
        email: "^[a-zA-Z0-9._-]+@[a-zA-Z0-9][a-zA-Z0-9.-]*[.]{1}[a-zA-Z]{2,6}$",
        phone: "^([0-9]{3})?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$"

    validators:
        minLength: (value, minLength)=>
            return value.length >= minLength

        maxLength: (value, maxLength)=>
            return value.length <= maxLength


        pattern: (value, pattern)=>
            return new RegExp(pattern, "gi").test(value) ? true : false

        isEmail: (value)->
            return app.mixins.UserValidationMixin.validators.pattern(value, app.mixins.UserValidationMixin.patterns.email)

        isPhone: (value)=>
            return app.mixins.UserValidationMixin.validators.pattern(value, app.mixins.UserValidationMixin.patterns.phone)

        hasSpecialCharacter: (value)=>
            return app.mixins.UserValidationMixin.validators.pattern(value, app.mixins.UserValidationMixin.patterns.specialCharacters)

        hasDigit: (value)=>                 
            return app.mixins.UserValidationMixin.validators.pattern(value, app.mixins.UserValidationMixin.patterns.digits)



    # validate: (attrs,fields_to_check)->
    #     errors = {}
    #     if ('email' in fields_to_check)
    #         console.log  @validators.minLength attrs.email,5
    #     if not _.isEmpty errors
    #         return errors
    validate: (attrs) ->
        errors = @errors = {}
        if attrs.name?
            unless attrs.name
                errors.name = "Введите имя"
            else unless @validators.minLength(attrs.name, 2)
                errors.name = "Имя слишком короткое"
            else unless @validators.maxLength(attrs.name, 25)
                errors.name = "Имя слишком длинное"
            # else errors.name = "Имя не может содержать спец. символы"  if @validators.hasSpecialCharacter(attrs.name)
        if attrs.email?
            unless attrs.email
                errors.email = "Введите имейл"
            else errors.email = "Введите правильный имейл"  unless @validators.isEmail(attrs.email)
        if attrs.password?
            unless attrs.password
                errors.password = "Ввдеите пароль"
            else unless @validators.minLength(attrs.password, 5)
                errors.password = "Пароль слишком короткий"

        if attrs.phone?
            unless attrs.phone
                errors.phone = "Введите телефон"
            # else errors.phone = "Телефон неверный"  unless @validators.isPhone(attrs.phone)

        if attrs.city?
            # console.log attrs.city
            unless attrs.city
                errors.city = "Введите город"
        if attrs.country?
            # console.log attrs.city
            unless attrs.country
                errors.country = "Введите страну"

        if attrs.birthday?
            unless attrs.birthday
                errors.birthday = "Введите дату рождения"

        if attrs.sex?
            unless attrs.sex
                errors.sex = "Выберите ваш пол"
    # if attrs.lastname?
    #   unless attrs.lastname
    #     errors.lastname = "lastname is required"
    #   else unless @validators.minLength(attrs.lastname, 2)
    #     errors.lastname = "lastname is too short"
    #   else unless @validators.maxLength(attrs.lastname, 15)
    #     errors.lastname = "lastname is too large"
    #   else errors.lastname = "lastname cannot contain special characters"  if @validators.hasSpecialCharacter(attrs.lastname)
    
        
    
        errors  unless _.isEmpty(errors)

    
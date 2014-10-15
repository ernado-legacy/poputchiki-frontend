app.mixins.MetaTagsMixin =

    initialize: ->
        @on 'render', ->
            if @meta_title
                document.title = @meta_title
            if @meta_description
                $('meta[name=description]').attr('content',@meta_description)
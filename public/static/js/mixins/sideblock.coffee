app.mixins.SlideRigtBlock = 
    slideHideAndShow: (callback) ->
        $('.photoVideoBlock').hide "slide", {direction:'right'}, ->
        	do callback
        	$('.photoVideoBlock').show "slide",{direction:'right'}

    slideShow: (callback) ->
        $('.photoVideoBlock').show "slide", {direction:'right'}, ->
        	do callback

    slideHide: (callback) ->
        $('.photoVideoBlock').hide "slide", {direction:'right'}
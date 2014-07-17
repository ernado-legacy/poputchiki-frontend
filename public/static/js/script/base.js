$(window).load(function() {
    if (window.pageYOffset == 0) {
        $('.leftMenu').addClass('onload');
    }
});

$(window).scroll(function() {
    if (window.pageYOffset > 0) {
        $('.leftMenu').removeClass('onload');
    } else {
        $('.leftMenu').addClass('onload');
    }
});

$(window).scroll(function() {
    if (window.pageYOffset >= 270) {
        $('.menuBox').css('top', '30px');
        $('.menuBox').css('position', 'fixed');
    } else {
        $('.menuBox').removeAttr('style');
    }

});

$(function(){

	$('.search .searchBox input').focus(function() {
		$(this).parent().css('border','3px solid #52EDC7');
	});
	$('.search .searchBox input').focusout(function() {
		$(this).parent().css('border','3px solid #eee');
	});


	$('.leftMenu li').click(function(){
		$('.leftMenu li').removeClass('current');
		$(this).addClass('current');
	});

	$('.box').click(function(){
		$(this).toggleClass('checked');
	});

	var removeTag = function(cls){
		$(document).on("click",cls,function() {
			if (!$(this).parent().hasClass('newTag')) { 
				$(this).parent().remove();
			}
		});
	};

	removeTag('.close');
	removeTag('.closeY');

	$(document).on("scroll",".carouselBox",function() {
		p = p - 1;
		str = p.toString() + 'px'
		$('.carousel').css('left',str);
	});

	$('#profile-arrow-left').click(function(){
		$('.carouselBox').animate({scrollLeft: '+=480'}, 'slow');
	});
	$('#profile-arrow-right').click(function(){
		$('.carouselBox').animate({scrollLeft: '-=480'}, 'slow');
	});

	if ($('.leftMenu li').width() > 60) {
		$('.leftMenu li span').addClass('visibleSpan');
	}
	else {
		$('.leftMenu li span').removeClass('visibleSpan');
	}

	// showMenu('webkitTransitionEnd');
	// showMenu('oTransitionEnd');
	// showMenu('MSAnimationEnd');
	// showMenu('transitionend');

	var activeAgeBox = function(cell){
		$(cell).children('input').focus(function(){
			$(cell).addClass('activeAgeBox');
		});
		$(cell).children('input').focusout(function(){
			$(cell).removeClass('activeAgeBox');
		});
	};
	activeAgeBox('.ageFrom');
	activeAgeBox('.ageTo');

	//code for registration form 2 (choose sex)
	//registration 3st step photo upload
	$('.photo-load .button button').click(function() {
		$('.photo-load .button input').click();
	});

	$('.addPhoto').click(function() {
		$('.addPhoto input').click();
	});

function get_user_id() {
    return $.cookie('user');
}
$(function() {


    $('.search .searchBox input').focus(function() {
        $(this).parent().css('border', '3px solid #52EDC7');
    });
    $('.search .searchBox input').focusout(function() {
        $(this).parent().css('border', '3px solid #eee');
    });


    $('.leftMenu li').click(function() {
        $('.leftMenu li').removeClass('current');
        $(this).addClass('current');
    });

    $('.box').click(function() {
        $(this).toggleClass('checked');
    });

    var removeTag = function(cls) {
        $(document).on("click", cls, function() {
            if (!$(this).parent().hasClass('newTag')) {
                $(this).parent().remove();
            }
        });
    };

    removeTag('.close');
    removeTag('.closeY');

    $(document).on("scroll", ".carouselBox", function() {
        p = p - 1;
        str = p.toString() + 'px'
        $('.carousel').css('left', str);
    });

    $('#profile-arrow-left').click(function() {
        $('.carouselBox').animate({
            scrollLeft: '+=480'
        }, 'slow');
    });
    $('#profile-arrow-right').click(function() {
        $('.carouselBox').animate({
            scrollLeft: '-=480'
        }, 'slow');
    });

    if ($('.leftMenu li').width() > 60) {
        $('.leftMenu li span').addClass('visibleSpan');
    } else {
        $('.leftMenu li span').removeClass('visibleSpan');
    }

    showMenu('webkitTransitionEnd');
    showMenu('oTransitionEnd');
    showMenu('MSAnimationEnd');
    showMenu('transitionend');


    var activeAgeBox = function(cell) {
        $(cell).children('input').focus(function() {
            $(cell).addClass('activeAgeBox');
        });
        $(cell).children('input').focusout(function() {
            $(cell).removeClass('activeAgeBox');
        });
    };
    activeAgeBox('.ageFrom');
    activeAgeBox('.ageTo');

    //code for registration form 2 (choose sex)
    //registration 3st step photo upload
    $('.photo-load .button button').click(function() {
        $('.photo-load .button input').click();
    });

    $('.addPhoto').click(function() {
        $('.addPhoto input').click();
    });
 >>> >>> > 36c2fb3148724310e08e841b74cc014aee5f4f08
});
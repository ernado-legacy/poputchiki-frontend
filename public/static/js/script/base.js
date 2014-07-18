/*$(window).load(function() {
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
});*/

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
});
function get_user_id() {
    return $.cookie('user');
}
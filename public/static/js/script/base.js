$(function(){

	$('.search .searchBox input').focus(function() {
		$(this).parent().css('border','3px solid #52EDC7');
	});
	$('.search .searchBox input').focusout(function() {
		$(this).parent().css('border','3px solid #eee');
	});

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
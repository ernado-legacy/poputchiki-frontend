$(function(){
	$('.filterBlock .title .dd').click(function() {
		$(this).parent().parent().children('.filters').slideDown('slow');
		$(this).css('display','none');
		$(this).next().css('display','block');
	});
	$('.filterBlock .title .du').click(function() {
		$(this).parent().parent().children('.filters').slideUp('slow');
		$(this).css('display','none');
		$(this).prev().css('display','block');
	});
});
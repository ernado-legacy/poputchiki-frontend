$(window).load(function() {
	if ($(window).width() >= 1730) {
		$('.carouselBox').css('width','1316px');
	}
	else {
		wdth = ($('.topContainer').width() - 210).toString() + 'px';
		$('.carouselBox').css('width',wdth);
	}

	cw = ($('.mainCrs').length * 160).toString() + 'px';
	$('.carousel').css('width', cw);

});

$(window).resize(function() {
	if ($(window).width() >= 1730) {
		$('.carouselBox').css('width','1316px');
	}
	else {
		wdth = ($('.topContainer').width() - 210).toString() + 'px';
		$('.carouselBox').css('width',wdth);
	}

});

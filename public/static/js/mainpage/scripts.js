
jQuery(document).ready(function() {


    $('.show-hide a').click(function(e) {
        e.preventDefault();
        var isHidden = $('.show-hide a').html();
        if (isHidden == '+') {
            $('.progress').slideDown('slow');

            $('.block-to-hide').slideDown('slow');
            $('.show-hide a').html('-');
            $('.show-hide a').attr('data-original-title', 'Спрятать');
        }
        if (isHidden == '-') {

            // adjust gridrotator size
            if ($(window).width() > 1024) {
                $('#ri-grid ul li').css('width', 100 / 8 + '%');
            }
            if ($(window).width() <= 1024) {
                $('#ri-grid ul li').css('width', 100 / 6 + '%');
            }
            if ($(window).width() <= 768) {
                $('#ri-grid ul li').css('width', 100 / 5 + '%');
            }
            if ($(window).width() <= 480) {
                $('#ri-grid ul li').css('width', 100 / 4 + '%');
            }
            if ($(window).width() <= 320) {
                $('#ri-grid ul li').css('width', 100 / 2 + '%');
            }
            if ($(window).width() <= 240) {
                $('#ri-grid ul li').css('width', 100 / 1 + '%');
            }
            $('#ri-grid ul li a').css('width', '100%');
        }
    });

});
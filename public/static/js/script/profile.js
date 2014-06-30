profile_script = function(){
    $('#profile-slidedown').click(function() {
        $(this).css('display', 'none');
        $('.profileInfoBox .infoView').slideDown("slow");
        $('#profile-slideup').css('display', 'block');
    });

    $('#profile-slideup').click(function() {
        $(this).css({
            'display': 'none'
        });
        $('#profile-slidedown').css({
            'display': 'block'
        });
        $('.profileInfoBox .infoView').slideUp("slow");
    });

    $('#edit-profile').click(function() {
        $('#about-in-info').css('display', 'none');
        $('#profile-slideup').css('display', 'none');
        $('.profileInfoBox .infoView').css('display', 'none');
        $('.profileInfoBox .infoEdit').slideDown("slow");
        $('#profile-slidedown').css({
            'display': 'none'
        });
        $('#profile-edit-slideup').css('display', 'block');
    });

    $('#profile-edit-slideup').click(function() {
        $(this).css('display', 'none');
        $('.profileInfoBox .infoEdit').slideUp("slow");
        $('#profile-slidedown').css({
            'display': 'block'
        });
        $('#about-in-info').css('display', 'block');
    });

    var showInputDrop = function(box) {
        $(box).children('.dd').click(function() {
            $(this).css({
                'display': 'none'
            });
            $(this).next().css({
                'display': 'block'
            });
            $(this).next().next().slideDown("slow");
            $(this).parent().removeClass('withShadow');
            $(this).parent().addClass('opened');
        });
    };

    $('#edit-status').click(function() {
        $('#main-status').slideUp("slow");
        $('.statusBoxEdit').slideDown("slow");
    });

    $('#write-new-main-status').click(function() {
        status = $('#new-status').val()
        $('#main-status').children('.status').text(status)
        $('#main-status').slideDown("slow");
        $('.statusBoxEdit').slideUp("slow");
    });

    showInputDrop('.newCountry');
    showInputDrop('.searchCountry');

    var hideInputDrop = function(box) {
        $(box).children('.du').click(function() {
            $(this).css({
                'display': 'none'
            });
            $(this).prev().css({
                'display': 'block'
            });
            $(this).next().slideUp("slow");
            $(this).parent().addClass('withShadow');
            $(this).parent().removeClass('opened');
        });
    };

    hideInputDrop('.newCountry');
    hideInputDrop('.searchCountry');

    var openNewTag = function(box) {
        /* $(box).click(function() {
            if ($(box).hasClass('opened')) {
                $(box).children('.du').css({
                    'display': 'none'
                });
                $(box).children('.dd').css({
                    'display': 'block'
                });
                $(box).children('.droped').slideUp("slow");
                $(box).addClass('withShadow');
                $(box).removeClass('opened');
            } else {
                $('.opened').each(function() {
                    $(this).addClass('withShadow');
                    $(this).removeClass('opened');
                    $(this).children('.droped').slideUp("slow");
                    $(this).children('.du').css({
                        'display': 'none'
                    });
                    $(this).children('.dd').css({
                        'display': 'block'
                    });
                });
                $(box).children('.dd').css({
                    'display': 'none'
                });
                $(box).children('.du').css({
                    'display': 'block'
                });
                $(box).children('.droped').slideDown("slow");
                $(box).removeClass('withShadow');
                $(box).addClass('opened');
            }
        }); */
    };

    openNewTag('.dayEdit');
    openNewTag('.monthEdit');
    openNewTag('.yearEdit');
    // openNewTag('.zodiacEdit');
    openNewTag('.cityEdit');
    openNewTag('.countryEdit');

    var selectSeasonYear = function(box) {
        /* $(box).children('.droped').children('.dl').click(function() {
            text = $(this).text();
            $(this).parent().parent().children('span').text(text);
        }); */
    };

    selectSeasonYear('.dayEdit');
    selectSeasonYear('.monthEdit');
    selectSeasonYear('.yearEdit');
    // selectSeasonYear('.zodiacEdit');
    selectSeasonYear('.cityEdit');
    selectSeasonYear('.countryEdit');



    var openTagWithInput = function(box) {
        $(box).children('.droped').children('.dl').click(function() {
            text = $(this).text();
            country = $(this).parent().parent().children('input');
            country.val(text);
            country.focus();
            $(box).children('.du').css({
                'display': 'none'
            });
            $(box).children('.dd').css({
                'display': 'block'
            });
            $(box).children('.droped').slideUp("slow");
            $(box).addClass('withShadow');
            $(box).removeClass('opened');

            country.focus(function() {
                this.selectionStart = this.selectionEnd = this.value.length;
            });
        });
    };

    openTagWithInput('.newCountry');
    openTagWithInput('.searchCountry');

    $('#profile-new-tag').keydown(function(event) {
        if (event.which == 13) {
            newCountry = $(this).val();
            if (newCountry != "") {
                $(this).val("");
                $('#profile-tags').append("<div class='mainSelectElement profileTagPlaces withShadow'><span class='tagCountry'>" + newCountry + "</span><div class='close'></div></div>")
            }
        }
    });

    $('.dls').click(function() {
        newSeason = $(this).text();
        $('#profile-tags-seasons').append("<div class='mainSelectElement profileTagPlaces withShadow'><span class='tagSeason'>" + newSeason + "</span><div class='close'></div></div>");
        $('#profile-new-tag-s').text('Сезон...')
    });

    var addSearchTag = function(newtag, oldtags) {
        $(newtag).keydown(function(event) {
            if (event.which == 13) {
                newCountry = $(this).val();
                if (newCountry != "") {
                    $(this).val("");
                    $(oldtags).append("<div class='mainSelectElement searcTagPlaces withShadow'><span class='tagCountry'>" + newCountry + "</span><div class='close'></div></div>")
                }
            }
        });
    };

    addSearchTag('#search-select', '#tb-s');
    addSearchTag('#search-select-f', '#tb-f');

    $('#search-slideup').click(function() {
        $('#my-folowers').slideUp("slow");
        $('#my-wishes').slideDown("slow");
    });
    $('#search-slidedown').click(function() {
        $('#my-folowers').slideDown("slow");
        $('#my-wishes').slideUp("slow");
    });
};

$(function() {
    profile_script();
});
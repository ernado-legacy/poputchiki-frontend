$(function() {
    $('.box').click(function(){
        $(this).toggleClass('checked');
    });

    $('.search .searchBox input').focus(function() {
        $(this).parent().css('border', '3px solid #52EDC7');
    });
    $('.search .searchBox input').focusout(function() {
        $(this).parent().css('border', '3px solid #eee');
    });

    //code for registration form 2 (choose sex)
    //registration 3st step photo upload
    $('.photo-load .button button').click(function() {
        $('.photo-load .button input').click();
    });

    $('.addPhoto').click(function() {
        $('.addPhoto input').click();
    });
    $('#accordion').find('.accordion-toggle').click(function() {
        $(this).next().slideToggle('fast');
        $(".accordion-content").not($(this).next()).slideUp('fast');
    });
});

function get_user_id() {
    return $.cookie('user');
}

function playSoundNotification() {
    filename = '/static/audio/message';
    document.getElementById("notification-sound").innerHTML = '<audio autoplay="autoplay"><source src="' + filename + '.mp3" type="audio/mpeg" /><embed hidden="true" autostart="true" loop="false" src="' + filename + '.mp3" /></audio>';
}

Share = {
    vkontakte: function(purl, ptitle, pimg, text) {
        url = 'http://vkontakte.ru/share.php?';
        url += 'url=' + encodeURIComponent(purl);
        url += '&title=' + encodeURIComponent(ptitle);
        url += '&description=' + encodeURIComponent(text);
        url += '&image=' + encodeURIComponent(pimg);
        url += '&noparse=true';
        Share.popup(url);
    },
    odnoklassniki: function(purl, text) {
        url = 'http://www.odnoklassniki.ru/dk?st.cmd=addShare&st.s=1';
        url += '&st.comments=' + encodeURIComponent(text);
        url += '&st._surl=' + encodeURIComponent(purl);
        Share.popup(url);
    },
    facebook: function(purl, ptitle, pimg, text) {
        url = 'http://www.facebook.com/sharer.php?s=100';
        url += '&p[title]=' + encodeURIComponent(ptitle);
        url += '&p[summary]=' + encodeURIComponent(text);
        url += '&p[url]=' + encodeURIComponent(purl);
        url += '&p[images][0]=' + encodeURIComponent(pimg);
        Share.popup(url);
    },
    twitter: function(purl, ptitle) {
        url = 'http://twitter.com/share?';
        url += 'text=' + encodeURIComponent(ptitle);
        url += '&url=' + encodeURIComponent(purl);
        url += '&counturl=' + encodeURIComponent(purl);
        Share.popup(url);
    },
    mailru: function(purl, ptitle, pimg, text) {
        url = 'http://connect.mail.ru/share?';
        url += 'url=' + encodeURIComponent(purl);
        url += '&title=' + encodeURIComponent(ptitle);
        url += '&description=' + encodeURIComponent(text);
        url += '&imageurl=' + encodeURIComponent(pimg);
        Share.popup(url);
    },

    popup: function(url) {
        window.open(url, '', 'toolbar=0,status=0,width=626,height=436');
    }
};
function WS() {
    var self = this;
    self.timeout = 1000;
    self.accounts = [];
    var host = window.location.hostname;
    self.callbacks = [
      function(data) {
        console.log('got event', data.type);
      },
      function(data) {
        console.log('from user', data.user);
      }
    ]
    self.setAccounts = function(accounts) {
      self.accounts = accounts;
      self.connection.close();
    }
    self.addCallback = function(callback) {
      console.log('adding callback');
      self.callbacks.push(callback);
    }
    self.reconnect = function() {
      self.timeout *= 2;
      var url = 'ws://' + host + '/api/realtime';
      if (self.accounts && self.accounts.length > 0) {
        url = url + '?id=' + self.accounts.join(',');
      }
      try {
        self.connection = new WebSocket(url);
      } catch(e) {
        console.log("ws error", e);
        return setTimeout(self.reconnect, self.timeout);
      }
      self.connection.onopen = function () {
        console.log('ws connected');
      };

      self.connection.onmessage = function (event) {
        data = JSON.parse(event.data);
        angular.forEach(self.callbacks, function(value) {
          value(data);
        });
      };

      self.connection.onclose = function () {
        console.log('ws closed; reconnecting');
        return setTimeout(self.reconnect, self.timeout);
      };
    };

    self.connect = function() {
      self.reconnect();
    };

    return self;
  }

  
$(function() {
    var definition = {
        smile: {
            title: "Smile",
            codes: [":)", ":=)", ":-)"]
        },
        "sad-smile": {
            title: "Sad Smile",
            codes: [":(", ":=(", ":-("]
        },
        "big-smile": {
            title: "Big Smile",
            codes: [":D", ":=D", ":-D", ":d", ":=d", ":-d"]
        },
        cool: {
            title: "Cool",
            codes: ["8)", "8=)", "8-)", "B)", "B=)", "B-)", "(cool)"]
        },
        wink: {
            title: "Wink",
            codes: [":o", ":=o", ":-o", ":O", ":=O", ":-O"]
        },
        crying: {
            title: "Crying",
            codes: [";(", ";-(", ";=("]
        },
        sweating: {
            title: "Sweating",
            codes: ["(sweat)", "(:|"]
        },
        speechless: {
            title: "Speechless",
            codes: [":|", ":=|", ":-|"]
        },
        kiss: {
            title: "Kiss",
            codes: [":*", ":=*", ":-*"]
        },
        "tongue-out": {
            title: "Tongue Out",
            codes: [":P", ":=P", ":-P", ":p", ":=p", ":-p"]
        },
        blush: {
            title: "Blush",
            codes: ["(blush)", ":$", ":-$", ":=$", ':">']
        },
        wondering: {
            title: "Wondering",
            codes: [":^)"]
        },
        sleepy: {
            title: "Sleepy",
            codes: ["|-)", "I-)", "I=)", "(snooze)"]
        },
        dull: {
            title: "Dull",
            codes: ["|(", "|-(", "|=("]
        },
        "in-love": {
            title: "In love",
            codes: ["(inlove)"]
        },
        "evil-grin": {
            title: "Evil grin",
            codes: ["]:)", ">:)", "(grin)"]
        },
        talking: {
            title: "Talking",
            codes: ["(talk)"]
        },
        yawn: {
            title: "Yawn",
            codes: ["(yawn)", "|-()"]
        },
        puke: {
            title: "Puke",
            codes: ["(puke)", ":&", ":-&", ":=&"]
        },
        "doh!": {
            title: "Doh!",
            codes: ["(doh)"]
        },
        angry: {
            title: "Angry",
            codes: [":@", ":-@", ":=@", "x(", "x-(", "x=(", "X(", "X-(", "X=("]
        },
        "it-wasnt-me": {
            title: "It wasn't me",
            codes: ["(wasntme)"]
        },
        party: {
            title: "Party!!!",
            codes: ["(party)"]
        },
        worried: {
            title: "Worried",
            codes: [":S", ":-S", ":=S", ":s", ":-s", ":=s"]
        },
        mmm: {
            title: "Mmm...",
            codes: ["(mm)"]
        },
        nerd: {
            title: "Nerd",
            codes: ["8-|", "B-|", "8|", "B|", "8=|", "B=|", "(nerd)"]
        },
        "lips-sealed": {
            title: "Lips Sealed",
            codes: [":x", ":-x", ":X", ":-X", ":#", ":-#", ":=x", ":=X", ":=#"]
        },
        hi: {
            title: "Hi",
            codes: ["(hi)"]
        },
        call: {
            title: "Call",
            codes: ["(call)"]
        },
        devil: {
            title: "Devil",
            codes: ["(devil)"]
        },
        angel: {
            title: "Angel",
            codes: ["(angel)"]
        },
        envy: {
            title: "Envy",
            codes: ["(envy)"]
        },
        wait: {
            title: "Wait",
            codes: ["(wait)"]
        },
        bear: {
            title: "Bear",
            codes: ["(bear)", "(hug)"]
        },
        "make-up": {
            title: "Make-up",
            codes: ["(makeup)", "(kate)"]
        },
        "covered-laugh": {
            title: "Covered Laugh",
            codes: ["(giggle)", "(chuckle)"]
        },
        "clapping-hands": {
            title: "Clapping Hands",
            codes: ["(clap)"]
        },
        thinking: {
            title: "Thinking",
            codes: ["(think)", ":?", ":-?", ":=?"]
        },
        bow: {
            title: "Bow",
            codes: ["(bow)"]
        },
        rofl: {
            title: "Rolling on the floor laughing",
            codes: ["(rofl)"]
        },
        whew: {
            title: "Whew",
            codes: ["(whew)"]
        },
        happy: {
            title: "Happy",
            codes: ["(happy)"]
        },
        smirking: {
            title: "Smirking",
            codes: ["(smirk)"]
        },
        nodding: {
            title: "Nodding",
            codes: ["(nod)"]
        },
        shaking: {
            title: "Shaking",
            codes: ["(shake)"]
        },
        punch: {
            title: "Punch",
            codes: ["(punch)"]
        },
        emo: {
            title: "Emo",
            codes: ["(emo)"]
        },
        yes: {
            title: "Yes",
            codes: ["(y)", "(Y)", "(ok)"]
        },
        no: {
            title: "No",
            codes: ["(n)", "(N)"]
        },
        handshake: {
            title: "Shaking Hands",
            codes: ["(handshake)"]
        },
        // skype: {
        //     title: "Skype",
        //     codes: ["(skype)", "(ss)"]
        // },
        heart: {
            title: "Heart",
            codes: ["(h)", "<3", "(H)", "(l)", "(L)"]
        },
        "broken-heart": {
            title: "Broken heart",
            codes: ["(u)", "(U)"]
        },
        mail: {
            title: "Mail",
            codes: ["(e)", "(m)"]
        },
        flower: {
            title: "Flower",
            codes: ["(f)", "(F)"]
        },
        rain: {
            title: "Rain",
            codes: ["(rain)", "(london)", "(st)"]
        },
        sun: {
            title: "Sun",
            codes: ["(sun)"]
        },
        time: {
            title: "Time",
            codes: ["(o)", "(O)", "(time)"]
        },
        music: {
            title: "Music",
            codes: ["(music)"]
        },
        movie: {
            title: "Movie",
            codes: ["(~)", "(film)", "(movie)"]
        },
        phone: {
            title: "Phone",
            codes: ["(mp)", "(ph)"]
        },
        coffee: {
            title: "Coffee",
            codes: ["(coffee)"]
        },
        pizza: {
            title: "Pizza",
            codes: ["(pizza)", "(pi)"]
        },
        cash: {
            title: "Cash",
            codes: ["(cash)", "(mo)", "($)"]
        },
        muscle: {
            title: "Muscle",
            codes: ["(muscle)", "(flex)"]
        },
        cake: {
            title: "Cake",
            codes: ["(^)", "(cake)"]
        },
        beer: {
            title: "Beer",
            codes: ["(beer)"]
        },
        drink: {
            title: "Drink",
            codes: ["(d)", "(D)"]
        },
        dance: {
            title: "Dance",
            codes: ["(dance)", "\\o/", "\\:D/", "\\:d/"]
        },
        ninja: {
            title: "Ninja",
            codes: ["(ninja)"]
        },
        star: {
            title: "Star",
            codes: ["(*)"]
        },
        mooning: {
            title: "Mooning",
            codes: ["(mooning)"]
        },
        finger: {
            title: "Finger",
            codes: ["(finger)"]
        },
        bandit: {
            title: "Bandit",
            codes: ["(bandit)"]
        },
        drunk: {
            title: "Drunk",
            codes: ["(drunk)"]
        },
        smoking: {
            title: "Smoking",
            codes: ["(smoking)", "(smoke)", "(ci)"]
        },
        toivo: {
            title: "Toivo",
            codes: ["(toivo)"]
        },
        rock: {
            title: "Rock",
            codes: ["(rock)"]
        },
        headbang: {
            title: "Headbang",
            codes: ["(headbang)", "(banghead)"]
        },
        bug: {
            title: "Bug",
            codes: ["(bug)"]
        },
        fubar: {
            title: "Fubar",
            codes: ["(fubar)"]
        },
        poolparty: {
            title: "Poolparty",
            codes: ["(poolparty)"]
        },
        swearing: {
            title: "Swearing",
            codes: ["(swear)"]
        },
        tmi: {
            title: "TMI",
            codes: ["(tmi)"]
        },
        heidy: {
            title: "Heidy",
            codes: ["(heidy)"]
        },
        myspace: {
            title: "MySpace",
            codes: ["(MySpace)"]
        },
        malthe: {
            title: "Malthe",
            codes: ["(malthe)"]
        },
        tauri: {
            title: "Tauri",
            codes: ["(tauri)"]
        },
        priidu: {
            title: "Priidu",
            codes: ["(priidu)"]
        }
    };
    $.emoticons.define(definition);


    $('.box').click(function() {
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
        // function(data) {
        //   console.log('got event', data.type);
        // },
        // function(data) {
        //   console.log('from user', data.user);
        // }
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
        } catch (e) {
            console.log("ws error", e);
            return setTimeout(self.reconnect, self.timeout);
        }
        self.connection.onopen = function() {
            console.log('ws connected');
        };

        self.connection.onmessage = function(event) {
            data = JSON.parse(event.data);
            console.log(data);
            _.each(self.callbacks, function(value) {
                value(data)
            })
            // angular.forEach(self.callbacks, function(value) {
            //   value(data);
            // });
        };

        self.connection.onclose = function() {
            console.log('ws closed; reconnecting');
            return setTimeout(self.reconnect, self.timeout);
        };
    };

    self.connect = function() {
        self.reconnect();
    };

    return self;
}

var ws_connection = new WS();
ws_connection.connect();
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

// フラッシュメッセージを隠す
$(function() {
  $('.both').slideUp(5000);
  $('.alert').slideUp(5000);
});


$(function () {
    $('#btn').on(function () {
        var speed = 500;
        var href= $(this).attr("#message-s");
        var target = $(href == "#message-s" || href == "" ? 'html' : href);
        var position = target.offset().top;
        $("#message-s").animate({scrollTop:position}, speed, 'swing');
        return false;

        $("#message-s").position();
        $('#message-s').animate({
          scrollTop: position.top,
          scrollLeft: position.left
        }, 1000);


        function goBottom(targetId) {
      var target = $("#message-s" + targetId);
      $(window).scrollTop(target.offset().top);
    }


    function goBottom(targetId) {
  var target = $("#message-s" + targetId);
  $(window).scrollTop(target.offset().top);
}

    });


    function goBottom(targetId) {
  var target = $("#message-s" + targetId);
  $(window).scrollTop(target.offset().top);
}

});

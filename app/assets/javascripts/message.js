// $(function() {
$(document).ready(function() {


  //jsonでhtmlを生成
  function html(data){
    //html
    var $msgArea = $('<li class="message-area">')

    var $mesStatusList = $('<div class="message-status cf">');
    var $name = $('<i class="message-area-name">')
    var $time = $('<i class="message-area-time">')
    var $text = $('<div class="message-area-text">')
    // var $image = $('<div class="message-area-image"></div>')
    //appendでデータを追加
    var $apName = $name.append(data.name);
    var $apTime = $time.append(data.created_at);
    var $apText = $text.append(data.body);
    var $appendmesStsLi = $mesStatusList.append($apName).append($apTime);
    $msgArea.attr("data-id", data.id)

    if (data.image.url){
      var $image = $('<img class="img-responsive">');
      $image.attr("src", data.image.url);

      var $appendList = $msgArea.append($appendmesStsLi).append($apText).append($image);
    }else{
      var $appendList = $msgArea.append($appendmesStsLi).append($apText);
    }

    return $appendList;

  }
  //jsonでhtmlを生成


  //自動更新 要修正
  // timer = setInterval(function(){
  //   if($("#message-s")){
  //     $.ajax({
  //       type: "get",
  //       url: window.location.href,
  //       dataType: "json"
  //     })
  //     .done(function(data){
  //       var $mesSpacePre = $('<ul class="chat-message message">');
  //       var messages = [];
  //       $.each($(".chat-message").children('.message'), function( key, mes ) {
  //         messages.push(Number($(mes).attr("data-id")));
  //       });
  //       $.each( data, function( key, value ) {
  //         if(messages.indexOf(value.id) == -1){
  //           $(".chat-message").append(html(value));
  //         }
  //       });
  //     })
  //     .fail(function(jqXHR){
  //       //alert("error")
  //       console.log(jqXHR);
  //     });
  //   }
  // }, 5000);
  //




  //メッセージ送信ボタンを押した時のイベント
  $('form').submit(function(e) {
    e.preventDefault();
    var postUrl = $('form').attr("action");
    var formData = new FormData($(this).get(0));
    //formData.append('body', $('#text-form').val())
    // formData.append('image', $('#file').val())
    $.ajax($(this).attr('action'), {
      type: 'POST',
      //url: '/messages/create', //urlを指定
      url: postUrl,
      data: formData,
      processData: false,
      contentType: false,
      dataType: 'json' //データ形式を指定
    }).done(function(data){
      $('.chat-message').append(html(data));
      // console.log(formData.get('body'));
      console.log(data);  // レスポンスがあったとき
      // $('#message-s').append('<div class="message-area"></div>').append(data.body);
      // $('.message').last().css('color', 'red');
      // $('#me').append(formData.get('body'));
      $('#message-s').animate({scrollTop:$('.message')[0].scrollHeight}, 2000); // 自動スクロールさせる
      $('#text-form').val(""); // フォームを空にする
    }).fail(function() {
       console.log('error!'); // エラーが発生したとき
    });
    return false;
  });
  //画像アイコンをクリックするとファイル選択ができる
  $('.fa-picture-o').click(function() {
    $('#file').click();
  });



});

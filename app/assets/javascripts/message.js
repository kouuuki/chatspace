$(function() {
  //メッセージ送信ボタンを押した時のイベント
  $('form').submit(function(e) {
    e.preventDefault();
    var formData = new FormData($('#new_message').get(0));
    formData.append('body', $('#text-form').val())
    // formData.append('image', $('#file').val())
    $.ajax($(this).attr('action'), {
      type: 'POST',
      url: '/messages/create', //urlを指定
      data: formData,
      processData: false,
      contentType: false,
      dataType: 'json' //データ形式を指定
    }).done(function(data){
      $('.message').html('<div></div>');
      // console.log(formData.get('body'));
      console.log(data.body);  // レスポンスがあったとき
      $('#message-s').append('<div class="message-area"></div>').append(data.body);
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
  $('.fa').click(function() {
    $('#file').click();
  });

  //jsonでhtmlを生成
  function html (){

  $.getJSON("messages.json.jbuilder", function(data){
    $(data.release).each(function(){
    $('<tr>'+'<th>'+this.body+'</th>'+'</tr>').appendTo('table.tbl tbody');
    })
　})

}
  //jsonでhtmlを生成

});

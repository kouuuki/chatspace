$(function() { //リロードしなくてもjsが動くようにする

  var $user_field = $('#user-name');
  var $user_result = $('#result');
  var $user_member= $('#user-member');

  function appendList(id, name, status) {
    var $user_result = $('<div class="chat-group-user clearfix">');
    var $user_result_name = $('<p class="chat-group-user__name">');
    $user_result.attr('id', 'user-' + id);
    $user_result.attr('data-id', id);

    var $user_result_btn = $('<a class="user-' + status + ' chat-group-user__btn chat-group-user__btn--' + status + '">');
    (status=="add")? $user_result_btn.append("追加"): $user_result_btn.append("削除");

    $user_result_btn.attr("data-id", id);
    $user_result_btn.attr("data-name", name);
    var $appendName = $user_result_name.append(name);

    if (status == "add"){
      var $appendList = $user_result.append($user_result_name).append($user_result_btn);
      $user_result.append($appendList)
    }else{
      var $post_input = $('<input name="group[user_ids][]" type="hidden">');
      $post_input.val(id);

      var $appendList = $user_result.append($post_input).append($user_result_name).append($user_result_btn);
      $user_member.append($appendList);
    }
  }






  $('#user-name').keyup(function(){ //このアプリケーション(document)の、formというid('#form')で、キーボードが押され指が離れた瞬間(.on('keyup'...))、eという引数を取って以下のことをしなさい(function(e))
    // e.preventDefault(); //キャンセル可能なイベントをキャンセル
    console.log('ok');
    // var input = $.trim($(this).val()); //この要素に入力された語句を取得し($(this).val())、前後の不要な空白を取り除いた($.trim(...);)上でinputという変数に(var input =)代入
    if ($user_field.val()){
      $.ajax({ //ajax通信で以下のことを行います
        //url: '/groups/search/', //urlを指定
        type: 'get', //メソッドを指定
        url: '/users/search/' + $user_field.val(),
        data: {}, //コントローラーに渡すデータを'keyword=input(入力された文字のことですね)'にするように指定
        processData: false, //おまじない
        contentType: false, //おまじない
        dataType: 'json' //データ形式を指定
      })
      .done(function(data){ //データを受け取ることに成功したら、dataを引数に取って以下のことする(dataには@usersが入っている状態ですね)
        //$('#result').find('li').remove();  //idがresultの子要素のliを削除する
        //$user_result.empty();
        console.log(data);
        var members = [];
        $.each($user_member.children('.chat-group-user'), function(key, member){
          members.push(Number($(member).attr('data-id')));
          console.log(members);
        });
        $.each(members, function(key, value ) {
          if(members.indexOf(value.id) == -1){
            appendList(value.id, value.name, "add")
          }
        });
        $(data).each(function(i, user){ //dataをuserという変数に代入して、以下のことを繰り返し行う(単純なeach文ですね)
          $('#result').append('<div>' + user.name + '<span class="user_add">' +"追加"+ '</span>' + '</div>') //resultというidの要素に対して、<li>ユーザーの名前</li>を追加する。
        });
      })
      .fail(function(jqXHR){
       //alert("error")
       console.log(jqXHR);
     });
   }else{
     $user_result.empty();
   };
 });

    $("#result").on("click", ".user_add", function() {
      console.log('ok');
        appendList($(this).attr('data-id'), $(this).attr('data-name'), "remove")
        $("#user_" + $(this).attr('data-id')).remove();
      });

      $("#user-member").on("click", ".user-remove", function() {
        console.log('ok');
        // $("#user_" + $(this).attr('data-id')).remove();
        $('.user-remove').remove();
      });




});
  // });
// $(document).on("click", "#tuika", function(){
//     $(this).css('color','red')
// });

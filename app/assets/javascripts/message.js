// $('.fa-picture-o').on('click', '.fa-picture-o', function () {
//     $('#file').click();
//     return false;
// });

//画像アイコンをクリックするとファイル選択ができる
$(function() {
  $('.fa').click(function() {
  $('#file').click();
  });
});

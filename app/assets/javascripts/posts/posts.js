'use strict';

var modules = modules || {};

modules.posts = (function () {
var module = {}

module.show = function() {
  // 送信ボタンを非同期通信させる。
  $('form#new_comment').submit(function(){
    try {
      module._sendComment();
    } catch (e) {
      return false;
    }
    return false;
  });
}

// 対象のオブジェクトを削除する
module._sendComment = function() {
  var data = { comment: {
    post_id: $('#comment_post_id').val(),
    comment: $('#comment_comment').val(),
  }};

  var ajaxRequest = modules.utils.getAjaxTemplate();
  ajaxRequest['type'] = 'post';
  ajaxRequest['url'] = '/comments';
  ajaxRequest['data'] = JSON.stringify(data);

  $.ajax(ajaxRequest
  ).done(function(response, textStatus, jqXHR) {
    if(response == null){
      alert('コメント送信に失敗しました。');
      console.log(jqXHR);
      return;
    }
    if(response['errors'] != null){
      alert(response['errors'].join(','));
      console.log(jqXHR);
      return;
    }
    alert("コメント送信しました。");
    // TODO: コメント要素の追加
  }).fail(modules.utils.getAjaxFailedTemplate);
}

return module;
}());

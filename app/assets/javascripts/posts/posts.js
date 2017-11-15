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
      toastr.error('コメント送信に失敗しました。');
      console.log(jqXHR);
      return;
    }
    if(response['errors'] != null){
      toastr.error(response['errors'].join(','));
      console.log(jqXHR);
      return;
    }

    $('#comment-field').append(module._commentTemplate(response.result));

    toastr.info('コメント送信しました。');
  }).fail(modules.utils.getAjaxFailedTemplate);
}

// コメント一行分を作成する
module._commentTemplate = function(comment) {
  return `
  <div class="media mb-4">
    <img class="d-flex mr-3 rounded-circle" src="${comment.icon}" alt="">
    <div class="media-body">
      <h5 class="mt-0">${ comment.nickname }</h5>
      ${ comment.comment }
    </div>
  </div>
  `;
}

return module;
}());

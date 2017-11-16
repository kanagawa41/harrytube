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
      console.log(e.message);
      toastr.error('予期せぬエラーが発生しました。');
      return false;
    }
    return false;
  });

  var clickFlg = true;
  // いいねボタン
  $('#favorite-o').on('click', function(){
    if(clickFlg) {
      // イベント処理中はフラグをoffにします。
      clickFlg = false;

      try {
        module._sendFavorite(this);
      } catch (e) {
        console.log(e.message);
        toastr.error('予期せぬエラーが発生しました。');
      }
    }else{
      return false;
    }
  });

  // FIXME: 処理を実装する。
  // いいね解除ボタン
  $('#favorite').on('click', function(){
    if(clickFlg) {
      // イベント処理中はフラグをoffにします。
      clickFlg = false;
      try {
        module._sendDeFavorite(this);
      } catch (e) {
        console.log(e.message);
        toastr.error('予期せぬエラーが発生しました。');
      }
    }else{
      return false;
    }
  });
}

// コメントを送信する
module._sendComment = function() {
  var data = { comment: {
    post_id: $('#post_id').val(),
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

// いいねを送信する
module._sendFavorite = function(icon_obj) {
  var data = { favorite: {
    post_id: $('#post_id').val(),
  }};

  var ajaxRequest = modules.utils.getAjaxTemplate();
  ajaxRequest['type'] = 'post';
  ajaxRequest['url'] = '/favorites';
  ajaxRequest['data'] = JSON.stringify(data);

  $.ajax(ajaxRequest
  ).done(function(response, textStatus, jqXHR) {
    if(response == null){
      toastr.error('いいねに失敗しました。');
      console.log(jqXHR);
      return;
    }
    if(response['errors'] != null){
      toastr.error(response['errors'].join(','));
      console.log(jqXHR);
      return;
    }

    // いいねのアイコンを変更する。
    $(icon_obj).removeClass("fa-heart-o");
    $(icon_obj).addClass("fa-heart");
    $('#favorite_count').text(`いいね！${ response.result.favorite_count }件`)

    toastr.info('いいねしました。');
  }).fail(modules.utils.getAjaxFailedTemplate);
}

// いいね解除を送信する
module._sendDeFavorite = function(icon_obj) {
  var data = { favorite: {
    post_id: $('#post_id').val(),
  }};

  var ajaxRequest = modules.utils.getAjaxTemplate();
  ajaxRequest['type'] = 'delete';
  ajaxRequest['url'] = '/favorites/1'; // 1はダミー
  ajaxRequest['data'] = JSON.stringify(data);

  $.ajax(ajaxRequest
  ).done(function(response, textStatus, jqXHR) {
    if(response == null){
      toastr.error('いいねに失敗しました。');
      console.log(jqXHR);
      return;
    }
    if(response['errors'] != null){
      toastr.error(response['errors'].join(','));
      console.log(jqXHR);
      return;
    }

    // いいねのアイコンを変更する。
    $(icon_obj).removeClass("fa-heart");
    $(icon_obj).addClass("fa-heart-o");

    $('#favorite_count').text(`いいね！${ response.result.favorite_count }件`)

    toastr.info('いいねを解除しました。');
  }).fail(modules.utils.getAjaxFailedTemplate);
}

return module;
}());

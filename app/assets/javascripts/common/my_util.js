'use strict';

var modules = modules || {};

// 共通処理
modules.utils = (function () {
var module = {}

// AJAXのリクエストパラメータのひな形
module.getAjaxTemplate = function() {
  return {
    type: 'get',
    url: '',
    crossDomain: true,
    timeout: 1000 * 30, // 30秒
    cache: false,
    data: {
    },
    crossDomain: true,
    headers: {
      'content-type': 'application/json; charset=UTF-8',
      'x-csrf-token': module.getCsrfToken(),
    },
  };
}

// AJAXの接続失敗の処理

module.getAjaxFailedTemplate = function(XMLHttpRequest, textStatus, errorThrown ) {
  alert('AJAXの接続が失敗しました。');
}

// CSRFトークンを取得
module.getCsrfToken = function() {
  return $('meta[name="csrf-token"]').attr('content');
}

return module;
}());

'use strict';

var modules = modules || {};

// 共通処理
modules.commons = (function () {
var module = {}

module.init = function() {
  if($('p.notice').text().length > 0){
    toastr.info($('p.notice').text());
  }
  if($('p.alert').text().length > 0){
    toastr.error($('p.alert').text());
  }
}

// AJAXの接続失敗の処理

module.getAjaxFailedTemplate = function(XMLHttpRequest, textStatus, errorThrown ) {
  toastr.error('接続に失敗しました。');
}

return module;
}());

'use strict';

var modules = modules || {};

// 共通処理
modules.commons = (function () {
var module = {}

module.init = function() {
	toastr.options = {
	  "closeButton": false,
	  "debug": false,
	  "newestOnTop": false,
	  "progressBar": false,
	  "positionClass": "toast-bottom-left",
	  "preventDuplicates": false,
	  "onclick": null,
	  "showDuration": "300",
	  "hideDuration": "1000",
	  "timeOut": "5000",
	  "extendedTimeOut": "1000",
	  "showEasing": "swing",
	  "hideEasing": "linear",
	  "showMethod": "fadeIn",
	  "hideMethod": "fadeOut"
	}

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

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${title}</title>
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="initial-scale=1, user-scalable=no, maximum-scale=1, width=device-width">
<meta name="viewport" content="initial-scale=1, user-scalable=no, maximum-scale=1">

<link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png"/>

<link type="text/css" href="${pageContext.request.contextPath}/resources/plugins/select2/select2.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrapValidator.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/ionicons.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/daterangepicker/daterangepicker-bs3.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/timepicker/bootstrap-timepicker.min.css">




<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dist/css/AdminLTE.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/fileinput.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/editor/summernote.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/editor/font-awesome.min.css" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/editor/summernote.css" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dist/sweetalert/sweetalert.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/angular/css/angular-material.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/angular/css/loading-bar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/angular/css/angular-block-ui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/toggle/bootstrap-toggle.min.css">

<!-- Mobiscroll CSS Includes -->
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.animation.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.icons.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.frame.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.frame.android-holo.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.frame.ios.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.frame.jqm.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.frame.wp.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.scroller.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.scroller.android-holo.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.scroller.ios.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.scroller.jqm.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.scroller.wp.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.image.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.android-holo-light.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.wp-light.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/mobiscroll/css/mobiscroll.mobiscroll-dark.css" rel="stylesheet" type="text/css" />

<style type="text/css">
	.cursor_move{ cursor: move; }
	.width-100{ width: 100px; }
	.width-80{ width: 80px; }
	.width-90{ width: 80px; }
	.requrie{color: #b9292d;}
	.select2{ width: 100%; }
	.iText-right{ text-align:right !important; }
	.dis-number{ text-align:right !important; margin-right: 10px !important; width:120px !important;}
	.iPanel{ margin-top: -25px; }
	.color_msg{ color:#F8BB86 !important; }
	.min-height-300{ height: 300px !important;  }
</style>

<script src="${pageContext.request.contextPath}/resources/bootstrap/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/jquerysession.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap-filestyle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/angular.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/angular/angular-material.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/angular/angular-animate.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/angular/loading-bar.js"></script>
<script src="${pageContext.request.contextPath}/resources/angular/angular-block-ui.js"></script>
<script src="${pageContext.request.contextPath}/resources/angular/angular-aria.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/angular/angular-messages.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/angular/datetime.js"></script>
<script src="${pageContext.request.contextPath}/resources/angular/custom-input.js"></script>
<script src="${pageContext.request.contextPath}/resources/angular/FileSaver.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/toggle/bootstrap-toggle.min.js"></script>

<script src="${pageContext.request.contextPath}/resources/angular/svg-assets-cache.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/dirPagination.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jPages.js"></script>
<script src="${pageContext.request.contextPath}/resources/editor/summernote.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/select2/select2.full.js"></script>
<script src="${pageContext.request.contextPath}/resources/dist/sweetalert/sweetalert-dev.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/timepicker/bootstrap-timepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/menu/menu.js"></script>
<script src="${pageContext.request.contextPath}/resources/js.mine/uploadFile.js"></script>


<!-- Mobiscroll JS Includes -->
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/mobiscroll.dom.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/mobiscroll.core.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/mobiscroll.scrollview.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/mobiscroll.frame.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/mobiscroll.frame.android-holo.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/mobiscroll.frame.ios.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/mobiscroll.frame.jqm.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/mobiscroll.frame.wp.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/mobiscroll.scroller.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/mobiscroll.android-holo-light.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/mobiscroll.wp-light.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/mobiscroll.mobiscroll-dark.js"></script>

    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.cs.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.de.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.en-UK.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.es.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.fa.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.fr.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.hu.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.it.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.ja.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.nl.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.no.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.pl.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.pt-BR.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.pt-PT.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.ro.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.ru.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.ru-UA.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.sk.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.sv.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.tr.js"></script>
    <script src="${pageContext.request.contextPath}/resources/mobiscroll/js/i18n/mobiscroll.i18n.zh.js"></script>
</head>
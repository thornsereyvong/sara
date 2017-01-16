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
<meta	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"	name="viewport">

<link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png"/>
<link type="text/css" href="${pageContext.request.contextPath}/resources/plugins/select2/select2.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrapValidator.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/ionicons.min.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/daterangepicker/daterangepicker-bs3.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/timepicker/bootstrap-timepicker.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/datatables/dataTables.bootstrap.css">
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/toggle/bootstrap-toggle.min.css">

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
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/angular.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/angular/angular-material.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/angular/angular-animate.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/angular/loading-bar.js"></script>
<script src="${pageContext.request.contextPath}/resources/angular/angular-aria.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/angular/angular-messages.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/toggle/bootstrap-toggle.min.js"></script>

<script src="${pageContext.request.contextPath}/resources/angular/svg-assets-cache.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/dirPagination.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jPages.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/editor/summernote.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/select2/select2.full.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/dist/sweetalert/sweetalert-dev.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/datatables/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/timepicker/bootstrap-timepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/menu/menu.js"></script>
</head>
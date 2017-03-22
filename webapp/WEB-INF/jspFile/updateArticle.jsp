<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<style>
.font-label {
	font-size: 13px;
	padding-top: 4px;
}
</style>
<div class="content-wrapper" ng-app="caseApp" ng-controller="caseController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Update Article</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"> Update Article</a></li>
		</ol>
	</section>
<script type="text/javascript">

var app = angular.module('caseApp', ['angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
var articleId = "${articleId}";
var username = "${SESSION}";
var article = [];
app.controller('caseController',['$scope','$http',function($scope, $http){	
	$scope.article = [];	
	
	$scope.startupPage = function(){
		$http.get("${pageContext.request.contextPath}/article/startup/"+articleId).success(function(response){
			$scope.article = response.ARTICLE;
			$scope.items = response.ITEMS;
			setTimeout(function(){
				$("#art_subject").val($scope.article.articleTitle);
				$("#art_key").val($scope.article.articleKey);
				CKEDITOR.instances['art_des'].setData($scope.article.articleDes);
				$("#art_product").select2("val",$scope.article.item.itemId);	
			}, 1500);
		});
	};			
}]);


//function addData
var ckTextarea = "";
$(document).ready(function() {
	
	ckTextarea = CKEDITOR.replace('art_des');
	
	$("#btn_reload").click(function(){
		location.reload();	
	});
	
	$("#btn_save").click(function(){
		$("#form-article").submit();
	});
	
	$('#form-article').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			art_subject: {
				validators: {
					notEmpty: {
						message: 'The subject is required and can not be empty!'
					}
				}
			},
			art_key: {
				validators: {
					notEmpty: {
						message: 'The key is required and can not be empty!'
					}
				}
			},
			ca_description: {
				validators: {
					stringLength: {
						max: 1000,
						message: 'The description must be less than 1000 characters long.'
					}
				}
			}
		}
	}).on('success.form.bv', function(e) {
		swal({   
			title: "<span style='font-size: 25px;'>You are about to update article.</span>",
			text: "Click OK to continue or CANCEL to abort.",
			type: "info",
			html: true,
			showCancelButton: true,
			closeOnConfirm: false,
			showLoaderOnConfirm: true,		
		}, function(){
			setTimeout(function(){
				$.ajax({ 
					url : "${pageContext.request.contextPath}/article/edit",
					type : "PUT",
					data : JSON.stringify({
						  "articleId": articleId,
					      "articleTitle": getValueStringById("art_subject"),
					      "articleKey": getValueStringById("art_key"),
					      "item": getJsonById("itemId","art_product","str"),
					      "articleModifiedBy": username,
					      "articleDes" :  CKEDITOR.instances['art_des'].getData()
				    }),
					beforeSend: function(xhr) {
					    xhr.setRequestHeader("Accept", "application/json");
					    xhr.setRequestHeader("Content-Type", "application/json");
				    }, 
				    success: function(result){	
						if(result.MESSAGE == "UPDATED"){	
							swal({
	    						title: "SUCCESSFUL",
	    					  	text: result.MSG,
	    					  	html: true,
	    					  	timer: 2000,
	    					  	type: "success",
	    					});
							reloadForm(2000);																																
						}else{
							swal("UNSUCCESSFUL", result.MSG, "error");
						}
					},
		    		error:function(){
		    			alertMsgErrorSweet();
		    		} 
				});
			}, 500);
		});
	});		
});

</script>
	<section class="content">
		<div class="box box-danger">			
			<div class="box-body">			
				<form method="post" id="form-article" data-ng-init="startupPage()">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-left: -5px;">
						<button type="button" class="btn btn-info btn-app" id="btn_save"> <i class="fa fa-save"></i> Save</button> 
						<a class="btn btn-info btn-app" id="btn_reload"> <i class="fa fa-refresh" aria-hidden="true"></i>Clear</a> 
						<a class="btn btn-info btn-app" href="${pageContext.request.contextPath}/list-articles"> <i class="fa fa-reply"></i> Back </a>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-2"><h4>Overview</h4></div>
					<div class="col-sm-12"><hr style="margin-top: 3px;" /></div>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
								<label class="font-label">Subject <span class="requrie">(Required)</span></label>
								<div class="form-group">
									<input type="text" class="form-control" id="art_subject" name="art_subject">
								</div>
							</div>
							<div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
								<label class="font-label">Key <span class="requrie">(Required)</span></label>
								<div class="form-group">
									<input type="text" class="form-control" id="art_key" name="art_key">
								</div>
							</div>
							<div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
								<label class="font-label">Product </label>
								<div class="form-group">
									<select class="form-control select2" name="art_product" id="art_product" style="width:100%">
										<option value="">-- SELECT product --</option>
										<option ng-repeat="p in items" value="{{p.itemId}}">[{{p.itemId}}] {{p.itemName}}</option>
									</select>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-sm-12 ">
								<label class="font-label">Description </label>
								<div class="form-group">
									<textarea rows="5" cols="" name="art_des" id="art_des" class="form-control">
									
									</textarea>
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
						
				</form>
			</div>
			<div class="box-footer"><div id="test_div"></div></div>
		</div>
	</section>
</div>
<jsp:include page="${request.contextPath}/footer"></jsp:include>
<script src="https://cdn.ckeditor.com/4.4.3/standard/ckeditor.js"></script>

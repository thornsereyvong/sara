<jsp:include page="${request.contextPath}/head"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
		var app = angular.module('viewDatabase',[ 'angularUtils.directives.dirPagination', 'angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
		    cfpLoadingBarProvider.includeSpinner = false;
		}]);
		app.controller('viewCompany',['$scope','$http', function($scope, $http) {
			$scope.listSystemDatabase = function() {
				$http({
						method : 'POST',
						url : "${pageContext.request.contextPath}/database",
						headers : {
							'Accept' : 'application/json',
							'Content-Type' : 'application/json'
						},
					}).success(function(response) {					
						$scope.database = response.DATABASE;
						
						setTimeout(function(){ 	$("#company").val("balancikapos_class12345CRM NEW 2017"); },1000);
						
					});
			};
		}]);

		function getUrlError() {
			var url = window.location.href;
			var err = url.search("error");
			if (err > 1) {
				$("#div_message").empty().append('<div class="alert alert-warning" role="alert">Warning ! Invalid Username Or Password.</div>');
			}
		}

		$(document).ready(function() {

			getUrlError();
			
		
			
			$("#company").change(function() {
				//alert($("#company :selected").val());
			});

			$('#form-login').bootstrapValidator({
				message : 'This value is not valid',
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
					crm_username : {
						validators : {
							notEmpty : {
								message : 'The username is required and can not be empty!'
							}
						}
					},
					crm_password : {
						validators : {
							notEmpty : {
								message : 'The password is required and can not be empty!'
							}
						}
					},
					company: {
						validators: {
							notEmpty: {
								message: 'The company is required and can not be empty!'
							}
						}
					}
				}
			});

		var docHeight = $(window).height();
		var footerHeight = $('#footer').height();
		var footerTop = $('#footer').position().top + footerHeight;

		if (footerTop < docHeight) {
			//$('#footer').css('margin-top', 20+ (docHeight - footerTop) + 'px');
			$('#footer').css('margin-top', 119 + (docHeight - footerTop) + 'px');
		}

	});
</script>

<body class="hold-transition login-page" ng-app="viewDatabase">
	<div style="">
		<div style="border: 1px solid #B9292D; margin-bottom: 10px;"></div>
		<div class="">
			<div class="container">
				<div class="col-sm-12 text-center">
					<%-- <img src="${pageContext.request.contextPath}/resources/images/logo.png" /> --%>
				</div>
			</div>
		</div>
		<!-- Close hidden xs -->
	</div>
	<div class="login-box">
		<div class="login-logo">
			<img src="${pageContext.request.contextPath}/resources/images/logo.png" />
			<p>Cambodia</p>
		</div>
		<div class="login-box-body">
			<h3 class="login-box-msg">Login Company</h3>
			<div class="" >
				<c:if test="${param.error != null}">
	            		<div class="bg-warning text-center alert alert-warning"> 
	            			<span class="h4">${msg}</span>
	            		</div>
                </c:if>
                <c:if test="${param.logout != null}">
                    <div class="alert alert-success">
                        <p>You have been logged out successfully.</p>
                    </div>
                </c:if>
            	
			</div>
			<div class="clearfix"></div>
			<form id="form-login" method="POST" action="${pageContext.request.contextPath}/login" ng-controller="viewCompany">
				<div class="form-group has-feedback">
					<input type="text" class="form-control" placeholder="Username"
						name="crm_username" id="username" required>
				</div>
				<div class="form-group has-feedback">
					<input type="password" class="form-control" placeholder="Password"
						name="crm_password" id="password" required>
				</div>
				<div class="form-group has-feedback">
					<select class="form-control" name="company" id="company"
						data-ng-init="listSystemDatabase()">
						<option ng-repeat= "db in database"   value="{{db.DBName}}12345{{db.ComName}}">{{db.ComName}}</option>
						
					</select>
				</div>
				<div class="row">
					<div class="col-sm-8" style="padding-top: 10px;"></div>
					<div class="col-sm-4" style="float: right">
						<button type="submit" id="login" name="button" class="btn btn-primary btn-block btn-flat">Login</button>
					</div>
				</div>
			</form>
		</div>
		<img src="${pageContext.request.contextPath}/resources/images/shadow.png" style="width: 100%;" />
		<!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->
	<div style="background: #fff" id="footer">
		<div style="border: 1px solid #B9292D; margin-bottom: 10px;"></div>
		<div class="">
			<div class="container">
				<div class="col-sm-5 text-left" style="padding-top: 10px;">
					<p>
						<i class="glyphicon glyphicon-home"></i> No. 105, St. 566, Sangkat
						Boeung Kak 2, Khan Toul Kork, Phnom Penh
					</p>
					<p>
						<i class="glyphicon glyphicon-phone"></i><abbr title="Phone">Tel:</abbr>
						+855 23 966 609
					</p>
					<p>
						<i class="glyphicon glyphicon-phone"></i><abbr title="Phone">Tel:</abbr>
						+855 12 997 373
					</p>
				</div>
			</div>
			<div class=""
				style="background:url(${pageContext.request.contextPath}/resources/images/footerstyle-Recovered.png) no-repeat;">
				<div class="container">
					<div class="col-sm-12 text-right"
						style="color: #fff; font-size: 12px;">Copyright ©2016
						Balancika (Cambodia). All rights reserved.
					</div>
				</div>
			</div>
		</div>
		<!-- Close hidden xs -->
		<div id="errors"></div>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js.mine/function.mine.js"></script>	
	
</body>
</html>

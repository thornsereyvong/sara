<jsp:include page="${request.contextPath}/head"></jsp:include>
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
			<div class="col-sm-12" id="div_message"></div>
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
						<option value="">-- Select Company --</option>
						<option value="BMG Corporation Co., Ltd. (New)">BMG Corporation Co., Ltd. (New)</option>
						
						<!-- <option ng-repeat="db in database" value="{{db.DBName}}">{{db.ComName}}</option> -->
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
	</div>
	<script>
		/* function configdb(dbName) {
			$.ajax({
				url : "${pageContext.request.contextPath}/config/"+dbName,
				type : "POST",
				data : JSON.stringify({}),
				beforeSend : function(xhr) {
					xhr.setRequestHeader("Accept", "application/json");
					xhr.setRequestHeader("Content-Type", "application/json");
				},
				success : function(data) {
				},
				error : function() {
				}
			});
		} */

		var app = angular.module('viewDatabase',[ 'angularUtils.directives.dirPagination' ]);
		app.controller('viewCompany',['$scope','$http', function($scope, $http) {
			$scope.listSystemDatabase = function() {
				$http({
						method : 'POST',
						url : "${pageContext.request.contextPath}/database",
						headers : {
							'Accept' : 'application/json',
							'Content-Type' : 'application/json'
						},
					})
					.success(function(response) {
						$scope.database = response.DATABASE;
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

			/* $("#company").change(function() {
				configdb($("#company").val());
			}); */

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
		var footerTop = $('#footer').position().top
				+ footerHeight;

		if (footerTop < docHeight) {
			//$('#footer').css('margin-top', 20+ (docHeight - footerTop) + 'px');
			$('#footer').css('margin-top',
					119 + (docHeight - footerTop) + 'px');
		}

	});
</script>
</body>
</html>

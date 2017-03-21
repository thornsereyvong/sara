
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>
<%
	String roleDelete = (String) request.getAttribute("role_delete");
%>


<script type="text/javascript">


var app = angular.module('taskApp', ['angularUtils.directives.dirPagination','angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;
var username = "${SESSION}";
var server = "${pageContext.request.contextPath}";
var taskId = "${taskId}";
app.controller('viewTaskController',['$scope','$http',function($scope, $http){
	
	angular.element(document).ready(function () {				
		
    });
	
	$scope.startupView = function(){				
		$http.get("${pageContext.request.contextPath}/task/list/"+taskId).success(function(response){
			$scope.task = response.DATA;
		});
		
	}
}]);


</script>
<style>
.panel-heading1 h4 {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    line-height: normal;
    width: 75%;
    padding-top: 8px;
}
.trask-btn{
	color: #dd4b39 !important;
}

.like-btn{
	color: #3289c8 !important;
}
.unlike-btn{
}

.icon_color {
	color: #2196F3;
}
.iTable tbody{
	border-top: 1px solid #d2d6de !important;
}
.iTable thead, tr, td{
	border:0px !important;
}



.iTD-width-50 {
	width: 50px;
}

.show-edit {
	width: 70% !important;
	margin: -25px 30% -5px !important;
}

.iTD {
	text-align: center;
	vertical-align: middle;
}

.item_border {
	border: 1px solid #f0f0f0;
}

.font-size-icon-30 {
	font-size: 20px;
}

.pagination {
	display: inline-block;
	padding-left: 0;
	margin: 0px 0px 13px 0px;
	border-radius: 4px;
	margin-buttom: 10px;
}

.cusor_pointer {
	cursor: pointer;
}

.breadcrumb1 {
	padding: 0;
	background: #D4D4D4;
	list-style: none;
	overflow: hidden;
	margin: 10px;
}

.breadcrumb1>li+li:before {
	padding: 0;
}

.breadcrumb1 li {
	float: left;
}

.breadcrumb1 li.active a {
	background: brown; /* fallback color */
	background: rgb(75, 202, 129);
}

.breadcrumb1 li.completed a {
	background: brown; /* fallback color */
	background: hsl(192, 100%, 41%);
}

.breadcrumb1 li.active a:after {
	border-left: 30px solid rgb(75, 202, 129);
}

.breadcrumb1 li.dead a {
	background: brown; /* fallback color */
	background: red;
}

.breadcrumb1 li.dead a:after {
	border-left: 30px solid red;
}

.breadcrumb1 li.completed a:after {
	border-left: 30px solid hsl(192, 100%, 41%);
}

.breadcrumb1 li a {
	color: white;
	text-decoration: none;
	padding: 10px 0 10px 45px;
	position: relative;
	display: block;
	float: left;
}

.breadcrumb1 li a:after {
	content: " ";
	display: block;
	width: 0;
	height: 0;
	border-top: 50px solid transparent;
	/* Go big on the size, and let overflow hide */
	border-bottom: 50px solid transparent;
	border-left: 30px solid hsla(0, 0%, 83%, 1);
	position: absolute;
	top: 50%;
	margin-top: -50px;
	left: 100%;
	z-index: 2;
}

.breadcrumb1 li a:before {
	content: " ";
	display: block;
	width: 0;
	height: 0;
	border-top: 50px solid transparent;
	/* Go big on the size, and let overflow hide */
	border-bottom: 50px solid transparent;
	border-left: 30px solid white;
	position: absolute;
	top: 50%;
	margin-top: -50px;
	margin-left: 1px;
	left: 100%;
	z-index: 1;
}

.breadcrumb1 li:first-child a {
	padding-left: 15px;
}

.breadcrumb1 li a:hover {
	background: rgb(75, 202, 129);
}

.breadcrumb1 li a:hover:after {
	border-left-color: rgb(75, 202, 129) !important;
}
</style>
<div class="content-wrapper" id="viewTaskController" ng-app="taskApp"
	ng-controller="viewTaskController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>View Task</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>View Task</a></li>
		</ol>
	</section>

	<section class="content" data-ng-init="startupView()">


		<div class="row">

			<div class="col-md-12">
				<!-- Widget: user widget style 1 -->
				<div class="box box-widget widget-user">
					<!-- Add the bg color to the header using any of the bg-* classes -->
					<div class="widget-user-header bg-aqua-active">
						<h3 class="widget-user-username ng-cloak">{{task.taskRelatedToModule}}</h3>
						<h5 class="widget-user-desc ng-cloak" ng-if="task.taskRelatedToModule != ''">[{{task.taskRelatedToId}}] {{task.taskRelatedName}}</h5>
					</div>
					<div class="widget-user-image">
						<img class="img-circle"
							src="${pageContext.request.contextPath}/resources/images/module/Task.png"
							alt="User Avatar">
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="col-md-12">
								<div class="nav-tabs-custom">
									<ul class="nav nav-tabs">										
										<li class="active"><a href="#detail_tap" data-toggle="tab"
											aria-expanded="true">Overview</a></li>	
										<li class=""><a href="#systemInfo_tap" data-toggle="tab"
											aria-expanded="false">System Information</a></li>										
									</ul>
									<div class="tab-content">
										<div class="tab-pane in active" id="detail_tap">
											<div class="row hidden-xs hidden-md hidden-sm">
												<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
													<form id="frmLeadDetail">
														<div class="col-sx-12 col-sm-12 col-md-12 col-lg-6">
															<ul class="list-group list-group-unbordered">																																
																<li class="list-group-item item_border">Subject<a
																	class="pull-right show-text-detail ng-cloak">{{task.taskSubject}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Start Date <a
																	class="pull-right show-text-detail ng-cloak">{{task.taskStartDate}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Due Date <a
																	class="pull-right show-text-detail ng-cloak">{{task.taskDueDate}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Priority<a
																	class="pull-right show-text-detail ng-cloak">{{task.taskPriority}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_lastName"
																			id="lea_lastName" class="form-control"
																			value="{{lead.lastName}}"> -->
																	</div>
																</li>
															</ul>
														</div>
														<div class="col-sx-12 col-sm-12 col-md-12 col-lg-6">
															<ul class="list-group list-group-unbordered">
																
																<li class="list-group-item item_border">Status <a
																	class="pull-right show-text-detail ng-cloak">{{task.taskStatusName}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Relate Type <a
																	class="pull-right show-text-detail ng-cloak">{{task.taskRelatedToModule}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_lastName"
																			id="lea_lastName" class="form-control"
																			value="{{lead.lastName}}"> -->
																	</div>
																</li>
																<li class="list-group-item item_border">Relate To<a
																	class="pull-right show-text-detail ng-cloak">[{{task.taskRelatedToId}}] {{task.taskRelatedName}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_title" id="lea_title"
																			class="form-control" value="{{lead.title}}"> -->
																	</div>
																</li>
																<li class="list-group-item item_border">Assign To <a
																	class="pull-right show-text-detail ng-cloak">{{task.username}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_no" id="lea_no"
																			class="form-control" value="{{lead.no}}"> -->
																	</div>
																</li>
															</ul>
														</div>
														<div class="clearfix"></div>
														<div class="col-sm-12" style="margin-top: 15px;">
															<ul class="list-group list-group-unbordered">
																<li class="list-group-item item_border">Description <!-- <a
																	class="pull-right cusor_pointer"
																	ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																		Edit</a> -->
																</li>
																<li class="list-group-item item_border" ng-if="task.taskingDes !=''">													
																	<a class="show-text-detail ng-cloak">{{task.taskDes}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
															</ul>
														</div>
													</form>
												</div>
											</div>
											<!-- Tablet and mobile block  -->
											<div class="row hidden-lg">
												<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
													<form id="frmLeadDetail">
														<div class="col-sx-12 col-sm-12 col-md-12 col-lg-6">
															<ul class="list-group list-group-unbordered">																																
																<li class="list-group-item item_border">Subject<a
																	class="pull-right show-text-detail ng-cloak">{{task.taskSubject}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Start Date <a
																	class="pull-right show-text-detail ng-cloak">{{task.taskStartDate}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Due Date <a
																	class="pull-right show-text-detail ng-cloak">{{task.taskDueDate}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Priority<a
																	class="pull-right show-text-detail ng-cloak">{{task.taskPriority}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_lastName"
																			id="lea_lastName" class="form-control"
																			value="{{lead.lastName}}"> -->
																	</div>
																</li>
																<li class="list-group-item item_border">Status <a
																	class="pull-right show-text-detail ng-cloak">{{task.taskStatusName}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Relate Type <a
																	class="pull-right show-text-detail ng-cloak">{{task.taskRelatedToModule}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_lastName"
																			id="lea_lastName" class="form-control"
																			value="{{lead.lastName}}"> -->
																	</div>
																</li>
																<li class="list-group-item item_border">Relate To<a
																	class="pull-right show-text-detail ng-cloak">[{{task.taskRelatedToId}}] {{task.taskRelatedName}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_title" id="lea_title"
																			class="form-control" value="{{lead.title}}"> -->
																	</div>
																</li>
																<li class="list-group-item item_border">Assign To <a
																	class="pull-right show-text-detail ng-cloak">{{task.username}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_no" id="lea_no"
																			class="form-control" value="{{lead.no}}"> -->
																	</div>
																</li>
																<li class="list-group-item item_border">Description <!-- <a
																	class="pull-right cusor_pointer"
																	ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																		Edit</a> -->
																</li>
																<li class="list-group-item item_border" ng-if="task.taskingDes !=''">													
																	
																	<a class="show-text-detail ng-cloak">{{task.taskDes}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																
															</ul>
														</div>
													</form>
												</div>
											</div>
											<!-- /.end block -->
										</div>
										<div class="tab-pane" id="systemInfo_tap">
											<div class="row hidden-xs hidden-sm hidden-md">
												<div class="col-sm-12">
													<form id="frmLeadDetail">
														<div class="col-sx-12 col-sm-12 col-md-12 col-lg-6">
															<ul class="list-group list-group-unbordered">																																
																<li class="list-group-item item_border">Create By<a
																	class="pull-right show-text-detail">{{task.taskCreateBy}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Create Date <a
																	class="pull-right show-text-detail">{{task.taskCreateDate | date:'dd/MM/yyyy h:mma'}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
															</ul>
														</div>
														<div class="col-sx-12 col-sm-12 col-md-12 col-lg-6">
															<ul class="list-group list-group-unbordered">																																
																<li class="list-group-item item_border">Modify By<a
																	class="pull-right show-text-detail">{{task.taskModifiedBy}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Modify Date <a ng-if="task.taskModifiedBy != null"
																	class="pull-right show-text-detail">{{task.taskModifiedDate | date:'dd/MM/yyyy h:mma'}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
															</ul>
														</div>
													</form>
												</div>
											</div>
											<!-- tablet and mobile block  -->
											<div class="row hidden-lg">
												<div class="col-sm-12">
													<form id="frmLeadDetail">
														<div class="col-sx-12 col-sm-12 col-md-12 col-lg-6">
															<ul class="list-group list-group-unbordered">																																
																<li class="list-group-item item_border">Create By<a
																	class="pull-right show-text-detail">{{task.taskCreateBy}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Create Date <a
																	class="pull-right show-text-detail">{{task.taskCreateDate | date:'dd/MM/yyyy h:mma'}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Modify By<a
																	class="pull-right show-text-detail">{{task.taskModifiedBy}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Modify Date <a ng-if="task.taskModifiedBy != null"
																	class="pull-right show-text-detail">{{task.taskModifiedDate | date:'dd/MM/yyyy h:mma'}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
															</ul>
														</div>
													</form>
												</div>
												<!-- /.end block -->
											</div>
										</div>
									</div>
									<!-- /.tab-content -->
								</div>
							</div>

						</div>
						<!-- /.row -->
					</div>
				</div>
				<!-- /.widget-user -->
			</div>
		</div>
	</section>
	<div id="errors"></div>
</div>

<jsp:include page="${request.contextPath}/footer"></jsp:include>

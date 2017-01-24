<%@page import="java.util.List"%>
<%@page import="com.app.entities.CrmUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<script type="text/javascript">
	var app = angular.module(
			'dashApp',
			[ 'angularUtils.directives.dirPagination', 'angular-loading-bar',
					'ngAnimate' ]).config(
			[ 'cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
				cfpLoadingBarProvider.includeSpinner = false;
			} ]);
	var self = this;
	var username = "${SESSION}";
	app.controller('dashController', [
			'$scope',
			'$http',
			function($scope, $http) {
				$scope.dashStartup = function() {

					$http.get("${pageContext.request.contextPath}/dashboard/startup/"+ username).success(function(response) {

						if (response.DASHBOARD != null) {
							$scope.meetings = response.DASHBOARD.MEETINGS;
							$scope.calls = response.DASHBOARD.CALLS;
							$scope.tasks = response.DASHBOARD.TASKS;
							$scope.events = response.DASHBOARD.EVENTS;
							$scope.notes = response.DASHBOARD.NOTES;
							$scope.locations = response.DASHBOARD.LOCATIONS;
							$scope.meetings = response.DASHBOARD.MEETINGS;
							$scope.leads = response.DASHBOARD.LEADS;
							$scope.campaigns = response.DASHBOARD.CAMPAIGNS;
							$scope.cases = response.DASHBOARD.CASES;
							$scope.customers = response.DASHBOARD.CUSTOMERS;
							$scope.contacts = response.DASHBOARD.CONTACTS;
							$scope.opportunities = response.DASHBOARD.OPPORTUNITIES;
							$scope.quotations = response.DASHBOARD.QUOTATIONS;
							$scope.saleorders = response.DASHBOARD.SALEORDERS;
						} else {
							$scope.meetings = [];
							$scope.calls = [];
							$scope.tasks = [];
							$scope.events = [];
							$scope.notes = [];
							$scope.locations = [];
							$scope.meetings = [];
							$scope.leads = [];
							$scope.campaigns = [];
							$scope.cases = [];
							$scope.customers = [];
							$scope.contacts = [];
							$scope.opportunities = [];
							$scope.quotations = [];
							$scope.saleorders = [];
						}

					});

				};

				$scope.sort = function(keyname) {
					$scope.sortKey = keyname; //set the sortKey to the param passed
					$scope.reverse = !$scope.reverse; //if true make it false and vice versa
				};

				$scope.pageSize = {};

				$scope.pageSize.rows = [ 
								{ value: "5", label: "5" },
                				{ value: "10", label: "10" },
                        		{ value: "15", label: "15" },
                        		{ value: "20", label: "20" },
                        		{ value: "25", label: "25" },
                        		{ value: "30", label: "30" },
                        		];
				$scope.pageSize.row = $scope.pageSize.rows[0].value;
				
				
				
				
				$scope.setting = function(){					
					$("#frm_setting").modal({backdrop: "static"});
				}
				
				
				$scope.btnSaveSettingClick = function(){
					var li = $("#listModuleShow li");
					var dataModule = [];
					for(var i=0; i<li.length; i++){
						var objLi = $(li.eq(i));						
						var chk = $("#ck_"+objLi.attr('data-value'))						
						var ckStatus = 0;
						
						if(chk.is(':checked')){
							ckStatus = 1;
						}
						
						dataModule.push({type: "module", moduleId: objLi.attr('data-value') , status: ckStatus , orderBy:  i+1 });
						
					}
					
					
					
					
					
				}
				
				$scope.ccSetting = function(){
					alert(1)
					
					
				}
				
				
			} ]);
	
	$(function(){
		
		$(".todo-list").sortable({
		    placeholder: "sort-highlight",
		    handle: ".handle",
		    forcePlaceholderSize: true,
		    zIndex: 999999
  		});	
	
	});
	
</script>

<div class="content-wrapper">
	<section class="content-header">
		<h1>Dashboard</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i
					class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i> Dashboard</a></li>
		</ol>
	</section>

	<section class="content" ng-app="dashApp" ng-controller="dashController">
		<div class="nav-tabs-custom" data-ng-init="dashStartup()">
			<ul class="nav nav-tabs ui-sortable-handle">
				<li class="active"><a href="#tabCamp" data-toggle="tab">Campaign<!--  <span class="badge bg-light-blue">3</span> --></a></li>
				<li><a href="#tabLead" data-toggle="tab">Lead</a> </li>
				<li><a href="#tabCustomer" data-toggle="tab">Customer</a></li>
				<li><a href="#tabContact" data-toggle="tab">Contact</a></li>
				<li><a href="#tabOpportunity" data-toggle="tab">Opportunity</a></li>
				<li><a href="#tabCall" data-toggle="tab">Call</a></li>
				<li><a href="#tabMeeting" data-toggle="tab">Meeting</a></li>
				<li><a href="#tabTask" data-toggle="tab">Task</a></li>
				<li><a href="#tabNote" data-toggle="tab">Note</a></li>
				<li><a href="#tabEvent" data-toggle="tab">Event</a></li>
				<li><a href="#tabCases" data-toggle="tab">Cases</a></li>
				<li><a href="#tabQuote" data-toggle="tab">Quotation</a></li>
				<li><a href="#tabSaleOrder" data-toggle="tab">Sale Order</a></li>
				
					
				<li class="pull-right header"><button ng-click="setting()" type="button" class="btn btn-default btn-sm"><i class="fa fa-gear"></i></button></li>
			</ul>
			<div class="tab-content no-padding">
				<div class="chart tab-pane active " id="tabCamp">
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<div class="input-group">
					        		 <span class="input-group-btn">
							       	 	<button class="btn btn-default" type="button" disabled="disabled"><i class="fa fa-search" aria-hidden="true"></i></button>
							      	</span>
					        		<input type="text" ng-model="search_campaign" class="form-control" placeholder="Search">
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<label>Row: </label>
					        	<div class="input-group">
					        		<select class="form-control" ng-model="pageSize.row" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<table class="table table-striped">
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Status</th>
								<th>Type</th>
								<th>Budget</th>
								<th>Start Date</th>
								<th>End Date</th>
							</tr>
							<tr dir-paginate="camp in campaigns|filter:search_campaign |itemsPerPage:pageSize.row"  pagination-id="camp_id"  class="ng-cloak">
								<td><a href="${pageContext.request.contextPath}/view-campaign/{{camp.campId}}">{{camp.campId}}</a></td>
								<td>{{camp.campName}}</td>								
								<td>{{camp.campType}}</td>
								<td>{{camp.campStatus}}</td>
								<td>{{camp.campBudget | number:2}}</td>	
								<td ng-if="camp.campStartDate == ''">-</td>
								<td ng-if="camp.campStartDate != ''">{{camp.campStartDate}}</td>							
								<td>{{camp.campEndDate}}</td>
								
							</tr>
							<tr>
								<td colspan="8">
									<div class="box-tools pull-right">
										<dir-pagination-controls  pagination-id="camp_id" 
									       max-size="pageSize.row"
									       direction-links="true"
									       boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="chart tab-pane " id="tabLead">
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<div class="input-group">
					        		 <span class="input-group-btn">
							       	 	<button class="btn btn-default" type="button" disabled="disabled"><i class="fa fa-search" aria-hidden="true"></i></button>
							      	</span>
					        		<input type="text" ng-model="search_lead" class="form-control" placeholder="Search">
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<label>Row: </label>
					        	<div class="input-group">
					        		<select class="form-control" ng-model="pageSize.row" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<table class="table table-striped">
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Status</th>
								<th>Company</th>
								<th>Email</th>
								<th>Phone</th>
							</tr>
							<tr dir-paginate="lead in leads |filter:search_lead |itemsPerPage:pageSize.row"  pagination-id="lead_id"  class="ng-cloak">
								<td><a href="${pageContext.request.contextPath}/view-lead/{{lead.leadId}}">{{lead.leadId}}</a></td>
								<td>{{lead.leadName}}</td>								
								<td>{{lead.leadStatus}}</td>
								<td>{{lead.leadCompany}}</td>
								<td ng-if="lead.leadEmail == ''">-</td>
								<td ng-if="lead.leadEmail != ''">{{lead.leadEmail}} </td>	
								<td ng-if="lead.leadPhone == ''">-</td>							
								<td ng-if="lead.leadPhone != ''">{{lead.leadPhone}}</td>
							</tr>
							<tr>
								<td colspan="6">
									<div class="box-tools pull-right">
										<dir-pagination-controls  pagination-id="lead_id" 
									       max-size="pageSize.row"
									       direction-links="true"
									       boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="chart tab-pane " id="tabCustomer">
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<div class="input-group">
					        		 <span class="input-group-btn">
							       	 	<button class="btn btn-default" type="button" disabled="disabled"><i class="fa fa-search" aria-hidden="true"></i></button>
							      	</span>
					        		<input type="text" ng-model="search_customer" class="form-control" placeholder="Search">
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<label>Row: </label>
					        	<div class="input-group">
					        		<select class="form-control" ng-model="pageSize.row" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<table class="table table-striped">
							<tbody>
								<tr>
									<th>ID</th>
									<th>Name</th>
									<th>Industry</th>
									<th>Lead Source</th>
									<th>Phone</th>
									<th>Email</th>
								</tr>
								<tr dir-paginate="cust in customers |filter:search_customer |itemsPerPage:pageSize.row" pagination-id="cust_id"  class="ng-cloak">
									<td><a href="${pageContext.request.contextPath}/view-customer/{{cust.custId}}">{{cust.custId}}</a></td>
									<td>{{cust.custName}}</td>
									<td ng-if="cust.custIndustry == ''">-</td>
									<td ng-if="cust.custIndustry != ''">{{cust.custIndustry}}</td>
									<td ng-if="cust.custLeadSource == ''">-</td>
									<td ng-if="cust.custLeadSource != ''">{{cust.custLeadSource}}</td>
									<td ng-if="cust.custPhone == ''">-</td>
									<td ng-if="cust.custPhone != ''">{{cust.custPhone}}</td>
									<td ng-if="cust.custEmail == ''">-</td>
									<td ng-if="cust.custEmail != ''">{{cust.custEmail}}</td>
								</tr>
								<tr>
									<td colspan="6">
										<div class="box-tools pull-right">
											<dir-pagination-controls  pagination-id="cust_id" 
										       max-size="pageSize.row"
										       direction-links="true"
										       boundary-links="true" >
										    </dir-pagination-controls>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="chart tab-pane " id="tabContact">
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<div class="input-group">
					        		 <span class="input-group-btn">
							       	 	<button class="btn btn-default" type="button" disabled="disabled"><i class="fa fa-search" aria-hidden="true"></i></button>
							      	</span>
					        		<input type="text" ng-model="search_contact" class="form-control" placeholder="Search">
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<label>Row: </label>
					        	<div class="input-group">
					        		<select class="form-control" ng-model="pageSize.row" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<table class="table table-striped">
							<tbody>
								<tr>
									<th>ID</th>
									<th>Name</th>
									<th>Customer</th>
									<th>Lead Source</th>
									<th>Phone</th>
									<th>Email</th>
								</tr>
								<tr dir-paginate="con in contacts |filter:search_contact |itemsPerPage:pageSize.row" pagination-id="con_id"  class="ng-cloak">
									<td><a href="${pageContext.request.contextPath}/view-contact/{{con.conId}}">{{con.conId}}</a></td>
									<td>{{con.conName}}</td>
									<td>[{{con.custId}}] {{con.custName}}</td>
									<td>{{con.leadSource}}</td>
									<td>{{con.conPhone}}</td>
									<td ng-if="con.conEmail == ''">-</td>
									<td ng-if="con.conEmail != ''">{{con.conEmail}}</td>
								</tr>
								<tr>
									<td colspan="6">
										<div class="box-tools pull-right">
											<dir-pagination-controls  pagination-id="con_id" 
										       max-size="pageSize.row"
										       direction-links="true"
										       boundary-links="true" >
										    </dir-pagination-controls>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="chart tab-pane " id="tabOpportunity">
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<div class="input-group">
					        		 <span class="input-group-btn">
							       	 	<button class="btn btn-default" type="button" disabled="disabled"><i class="fa fa-search" aria-hidden="true"></i></button>
							      	</span>
					        		<input type="text" ng-model="search_opportunity" class="form-control" placeholder="Search">
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<label>Row: </label>
					        	<div class="input-group">
					        		<select class="form-control" ng-model="pageSize.row" id ="quoteRow" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<table class="table table-striped">
							<tbody>
								<tr>
									<th>ID</th>
									<th>Name</th>
									<th>Customer</th>
									<th>Amount</th>
									<th>Stage</th>
									<th>Campaign</th>
									<th>Lead Source</th>
								</tr>
								<tr dir-paginate="op in opportunities |filter:search_opportunity |itemsPerPage:pageSize.row" pagination-id="opp_id"  class="ng-cloak">
									<td><a href="${pageContext.request.contextPath}/view-opportunity/{{op.opId}}">{{op.opId}}</a></td>
									<td>{{op.opName}}</td>
									<td>[{{op.opCustId}}] {{op.opCustName}}</td>
									<td>{{op.opAmount}}</td>
									<td>{{op.opStage}}</td>
									<td ng-if="op.opCampId == ''">-</td>
									<td ng-if="op.opCampId != ''">[{{op.opCampId}}] {{op.opCampName}}</td>
									<td ng-if="op.opLeadSource == ''">-</td>
									<td ng-if="op.opLeadSource != ''">{{op.opLeadSource}}</td>
								</tr>
								<tr>
									<td colspan="6">
										<div class="box-tools pull-right">
											<dir-pagination-controls  pagination-id="opp_id" 
										       max-size="pageSize.row"
										       direction-links="true"
										       boundary-links="true" >
										    </dir-pagination-controls>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="chart tab-pane " id="tabCall">
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<div class="input-group">
					        		 <span class="input-group-btn">
							       	 	<button class="btn btn-default" type="button" disabled="disabled"><i class="fa fa-search" aria-hidden="true"></i></button>
							      	</span>
					        		<input type="text" ng-model="search_call" class="form-control" placeholder="Search">
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<label>Row: </label>
					        	<div class="input-group">
					        		<select class="form-control" ng-model="pageSize.row" id ="quoteRow" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<table class="table table-striped">
							<tbody>
								<tr>
									<th>ID</th>
									<th>Subject</th>
									<th>Related To</th>
									<th>Start Date</th>
									<th>Duration</th>
									<th>Status</th>
								</tr>
								<tr dir-paginate="call in calls |filter:search_call |itemsPerPage:pageSize.row" pagination-id="call_id"  class="ng-cloak">
									<td><a href="${pageContext.request.contextPath}/view-call/{{call.callId}}">{{call.callId}}</a></td>
									<td>{{call.callSubject}}</td>
									<td ng-if="call.callRelatedToType == ''">-</td>
									<td ng-if=" call.callRelatedToType != '' "><span ><span class="badge bg-red">{{call.callRelatedToType}}</span> <span>[{{call.callRelatedToId}}] {{call.callRelatedTo}}</span></span></td>
									<td>{{call.callStartDate}}</td>
									<td>{{call.callDuration}} min</td>
									<td>{{call.callStatus}}</td>
									
								</tr>
								<tr>
									<td colspan="6">
										<div class="box-tools pull-right">
											<dir-pagination-controls  pagination-id="call_id" 
										       max-size="pageSize.row"
										       direction-links="true"
										       boundary-links="true" >
										    </dir-pagination-controls>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="chart tab-pane " id="tabMeeting">
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<div class="input-group">
					        		 <span class="input-group-btn">
							       	 	<button class="btn btn-default" type="button" disabled="disabled"><i class="fa fa-search" aria-hidden="true"></i></button>
							      	</span>
					        		<input type="text" ng-model="search_meeting" class="form-control" placeholder="Search">
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<label>Row: </label>
					        	<div class="input-group">
					        		<select class="form-control" ng-model="pageSize.row" id ="quoteRow" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<table class="table table-striped">
							<tbody>
								<tr>
									<th>ID</th>
									<th>Subject</th>
									<th>Related To</th>
									<th>Location</th>
									<th>Start Date</th>
									<th>End Date</th>
									<th>Status</th>
								</tr>
								<tr dir-paginate="meet in meetings |filter:search_meeting |itemsPerPage:pageSize.row"  pagination-id="meet_id"  class="ng-cloak">
									<td><a href="${pageContext.request.contextPath}/view-meeting/{{meet.meetingId}}">{{meet.meetingId}}</a></td>
									<td>{{meet.meetingSubject}}</td>
									<td ng-if="meet.meetingRelatedToType == '' ">-</td>
									<td ng-if="meet.meetingRelatedToType != '' "><span><span  class="badge bg-red">{{meet.meetingRelatedToType}}</span> <span>[{{meet.meetingRelatedToId}}] {{meet.relatedRelatedTo}}</span></span></td>
									<td ng-if="meet.meetingLocation == ''">-</td>
									<td ng-if="meet.meetingLocation != ''">{{meet.meetingLocation}}</td>
									<td>{{meet.meetingStartDate}}</td>
									<td>{{meet.meetingEndDate}}</td>
									<td>{{meet.meetingStatus}}</td>
									
								</tr>
								<tr>
									<td colspan="7">
										<div class="box-tools pull-right">
											<dir-pagination-controls  pagination-id="meet_id" 
										       max-size="pageSize.row"
										       direction-links="true"
										       boundary-links="true" >
										    </dir-pagination-controls>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="chart tab-pane " id="tabTask">
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<div class="input-group">
					        		 <span class="input-group-btn">
							       	 	<button class="btn btn-default" type="button" disabled="disabled"><i class="fa fa-search" aria-hidden="true"></i></button>
							      	</span>
					        		<input type="text" ng-model="search_task" class="form-control" placeholder="Search">
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<label>Row: </label>
					        	<div class="input-group">
					        		<select class="form-control" ng-model="pageSize.row" id ="quoteRow" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<table class="table table-striped">
							<tr>
								<th>ID</th>
								<th>Subject</th>
								<th>Related To</th>
								<th>Priority</th>								
								<th>Status</th>
								<th>Start Date</th>
								<th>Due Date</th>
							</tr>
							<tr dir-paginate="task in tasks |filter:search_task |itemsPerPage:pageSize.row" pagination-id="task_id"  class="ng-cloak">
								<td><a href="${pageContext.request.contextPath}/view-task/{{task.taskId}}">{{task.taskId}}</a></td>
								<td>{{task.taskSubject}}</td>
								<td ng-if=" task.taskRelatedToType == '' ">-</td>
								<td ng-if=" task.taskRelatedToType != '' "><span><span  class="badge bg-red">{{task.taskRelatedToType}}</span> <span>[{{task.taskRelatedToId}}] {{task.taskRelatedTo}}</span></span></td>
								<td>{{task.taskPriority}}</td>
								<td>{{task.taskStatus}}</td>
								<td ng-if="task.taskStartDate == ''">-</td>
								<td ng-if="task.taskStartDate != ''">{{task.taskStartDate}}</td>
								<td ng-if="task.taskDueDate == ''">-</td>
								<td ng-if="task.taskDueDate != ''">{{task.taskDueDate}}</td>
							</tr>
							<tr>
								<td colspan="7">
									<div class="box-tools pull-right">
										<dir-pagination-controls  pagination-id="task_id" 
									       max-size="pageSize.row"
									       direction-links="true"
									       boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>				
				<div class="chart tab-pane " id="tabNote">
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<div class="input-group">
					        		 <span class="input-group-btn">
							       	 	<button class="btn btn-default" type="button" disabled="disabled"><i class="fa fa-search" aria-hidden="true"></i></button>
							      	</span>
					        		<input type="text" ng-model="search_note" class="form-control" placeholder="Search">
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<label>Row: </label>
					        	<div class="input-group">
					        		<select class="form-control" ng-model="pageSize.row" id ="quoteRow" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<table class="table table-striped">
							<tr>
								<th>ID</th>
								<th>Subject</th>
								<th>Related To</th>
								<th>Date</th>
							</tr>
							<tr dir-paginate="note in notes|filter:search_note |itemsPerPage:pageSize.row"  pagination-id="note_id"  class="ng-cloak">
								<td><a href="${pageContext.request.contextPath}/view-note/{{note.noteId}}">{{note.noteId}}</a></td>
								<td>{{note.noteSubject}} </td>
								<td ng-if=" note.noteRelatedToType == '' ">-</td>
								<td ng-if=" note.noteRelatedToType != '' "><span><span  class="badge bg-red">{{note.noteRelatedToType}}</span> <span>[{{note.noteRelatedToId}}] {{note.noteRelatedTo}}</span></span></td>
								<td>{{note.noteCreatedDate}}</td>
							</tr>
							<tr>
								<td colspan="4">
									<div class="box-tools pull-right">
										<dir-pagination-controls  pagination-id="note_id" 
									       max-size="pageSize.row"
									       direction-links="true"
									       boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="chart tab-pane " id="tabEvent">
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<div class="input-group">
					        		 <span class="input-group-btn">
							       	 	<button class="btn btn-default" type="button" disabled="disabled"><i class="fa fa-search" aria-hidden="true"></i></button>
							      	</span>
					        		<input type="text" ng-model="search_event" class="form-control" placeholder="Search">
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<label>Row: </label>
					        	<div class="input-group">
					        		<select class="form-control" ng-model="pageSize.row" id ="quoteRow" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<table class="table table-striped">
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Related To</th>
								<th>Location</th>
								<th>Start Date</th>
								<th>End Date</th>
								<th>Budget</th>
							</tr>
							<tr dir-paginate="event in events|filter:search_event |itemsPerPage:pageSize.row"  pagination-id="event_id"  class="ng-cloak">
								<td><a href="${pageContext.request.contextPath}/view-event/{{event.eventId}}">{{event.eventId}}</a></td>
								<td>{{event.eventName}} </td>
								<td ng-if=" event.eventRelatedToType == '' ">-</td>
								<td ng-if=" event.eventRelatedToType != '' "><span><span  class="badge bg-red">{{event.eventRelatedToType}}</span> <span>[{{event.eventRelatedToId}}] {{event.eventRelatedTo}}</span></span></td>
								<td ng-if="event.eventLocation == ''">-</td>
								<td ng-if="event.eventLocation != ''">{{event.eventLocation}}</td>
								<td>{{event.eventStartDate}}</td>
								<td>{{event.eventEndDate}}</td>
								<td>{{event.eventBudget | number:2}}</td>	
							</tr>
							<tr>
								<td colspan="7">
									<div class="box-tools pull-right">
										<dir-pagination-controls  pagination-id="event_id" 
									       max-size="pageSize.row"
									       direction-links="true"
									       boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="chart tab-pane " id="tabCases">
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<div class="input-group">
					        		 <span class="input-group-btn">
							       	 	<button class="btn btn-default" type="button" disabled="disabled"><i class="fa fa-search" aria-hidden="true"></i></button>
							      	</span>
					        		<input type="text" ng-model="search_case" class="form-control" placeholder="Search">
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<label>Row: </label>
					        	<div class="input-group">
					        		<select class="form-control" ng-model="pageSize.row" id ="quoteRow" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<table class="table table-striped">
							<tr>
								<th>ID</th>
								<th>Subject</th>
								<th>Status</th>
								<th>Priority</th>
								<th>Type</th>
								<th>Contact</th>
								<th>Customer</th>
							</tr>
							<tr dir-paginate="case in cases |filter:search_case |itemsPerPage:pageSize.row"  pagination-id="case_id"  class="ng-cloak">
								<td><a href="${pageContext.request.contextPath}/view-case/{{case.caseId}}">{{case.caseId}}</a></td>
								<td>{{case.caseSubject}}</td>								
								<td>{{case.caseStatus}}</td>
								<td>{{case.casePriority}}</td>
								<td>{{case.caseType}} </td>	
								<td ng-if=" case.conId =='' ">-</td>
								<td ng-if=" case.conId !='' "><span>[{{case.conId}}] {{case.caseContact}}</span></td>	
								<td ng-if=" case.custId =='' ">-</td>						
								<td ng-if=" case.custId !='' "><span>[{{case.custId}}] {{case.caseCustomer}}</span></td>
							</tr>
							<tr>
								<td colspan="7">
									<div class="box-tools pull-right">
										<dir-pagination-controls  pagination-id="lead_id" 
									       max-size="pageSize.row"
									       direction-links="true"
									       boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</td>
							</tr>	
						</table>
					</div>
				</div>
				<div class="chart tab-pane " id="tabQuote">	
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<div class="input-group">
					        		 <span class="input-group-btn">
							       	 	<button class="btn btn-default" type="button" disabled="disabled"><i class="fa fa-search" aria-hidden="true"></i></button>
							      	</span>
					        		<input type="text" ng-model="search_quote" class="form-control" placeholder="Search">
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<label>Row: </label>
					        	<div class="input-group">
					        		<select class="form-control" ng-model="pageSize.row" id ="quoteRow" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<table class="table table-striped">
							<tr>
								<th>ID</th>
								<th>Customer</th>
								<th>Employee</th>
								<th>Quote Date</th>
								<th>Start Date</th>
								<th>Expire Date</th>
							</tr>
							<tr dir-paginate="qu in quotations |filter:search_quote |itemsPerPage:pageSize.row"  pagination-id="quote_id"  class="ng-cloak">
								<td>{{qu.quoteId}}</td>
								<td>[{{qu.custId}}] {{qu.custName}}</td>								
								<td>[{{qu.empId}}] {{qu.empName}}</td>
								<td>{{qu.quoteDate}}</td>
								<td>{{qu.startDate}} </td>	
								<td>{{qu.expireDate}}</td>
							</tr>
							<tr>
								<td colspan="6">
									<div class="box-tools pull-right">
										<dir-pagination-controls  pagination-id="quote_id" 
									       max-size="pageSize.row"
									       direction-links="true"
									       boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</td>
							</tr>	
						</table>
					</div>	
				</div>
				
				<div class="chart tab-pane " id="tabSaleOrder">	
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<div class="input-group">
					        		 <span class="input-group-btn">
							       	 	<button class="btn btn-default" type="button" disabled="disabled"><i class="fa fa-search" aria-hidden="true"></i></button>
							      	</span>
					        		<input type="text" ng-model="search_saleorder" class="form-control" placeholder="Search">
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="col-sm-2">
					  <form class="form-inline">
					        <div class="form-group" style="padding-top: 20px;">
					        	<label>Row: </label>
					        	<div class="input-group">
					        		<select class="form-control" ng-model="pageSize.row" id ="quoteRow" ng-options="obj.value as obj.label for obj in pageSize.rows"></select>
					        	</div>
					        </div>
					    </form>
					    <br/>
					</div>
					<div class="clearfix"></div>
					<div class="col-sm-12">
						<table class="table table-striped">
							<tr>
								<th>ID</th>
								<th>Customer</th>
								<th>Employee</th>
								<th>Sale Date</th>
								<th>Due Date</th>
							</tr>
							<tr dir-paginate="sal in saleorders|filter:search_saleorder |itemsPerPage:pageSize.row"  pagination-id="sale_id"  class="ng-cloak">
								<td>{{sal.saleId}}</td>
								<td>[{{sal.custId}}] {{sal.custName}}</td>								
								<td>[{{sal.empId}}] {{sal.empName}}</td>
								<td>{{sal.saleDate}}</td>
								<td>{{sal.dueDate}} </td>	
							</tr>
							<tr>
								<td colspan= "5">
									<div class="box-tools pull-right">
										<dir-pagination-controls  pagination-id="sale_id" 
									       max-size="pageSize.row"
									       direction-links="true"
									       boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</td>
							</tr>	
						</table>
					</div>				
				</div>
			</div>
		</div>
		
		
		<input type="hidden" id="btn_frm_setting" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="frm_setting" />
		<div class="modal fade modal-default" id="frm_setting" role="dialog">
			<div class="modal-dialog  modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" ng-click="ccSetting()" class="close"
							data-dismiss="modal">&times;</button>
						<h4 class="modal-title">
							<b  id="tCompetitorToProduct">Dashboard Setting</b>
						</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-sm-12">
							
								<div class="nav-tabs-custom" data-ng-init="dashSettingStartup()">
									<ul class="nav nav-tabs ui-sortable-handle">
										<li class="active"><a href="#tabModule" data-toggle="tab">Module</a></li>
										<li><a href="#tabChart" data-toggle="tab">Chart</a> </li>
									</ul>
								</div>
								<div class="tab-content no-padding">
									<div class="chart tab-pane active " id="tabModule">
										<ul class="todo-list ui-sortable" id="listModuleShow">
											<li class="" data-value="CA">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" id="ck_CA" value="CA" name="module">
												<span class="text">Campaign</span>										
											</li>
											<li class="" data-value="LE">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" id="ck_LE" value="LE" name="module">
												<span class="text">Lead</span>										
											</li>
											
											
											<li class="" data-value="CUST">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" id="ck_CUST" value="CUST" name="module">
												<span class="text">Customer</span>										
											</li>
											<li class="" data-value="CO">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" id="ck_CO" value="CO" name="module">
												<span class="text">Contact</span>										
											</li>
											<li class="" data-value="OP">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" value="OP" id="ck_OP" name="module">
												<span class="text">Opportunity</span>										
											</li>
											
											
											<li class="" data-value="AC_CL">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" value="AC_CL" id="ck_AC_CL" name="module">
												<span class="text">Call</span>										
											</li>
											<li class="" data-value="AC_ME">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" value="AC_ME" id="ck_AC_ME" name="module">
												<span class="text">Meeting</span>										
											</li>
											<li class="" data-value="AC_TA">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" id="ck_AC_TA" value="AC_TA" name="module">
												<span class="text">Task</span>										
											</li>
											<li class="" data-value="AC_NO">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" id="ck_AC_NO" value="AC_NO" name="module">
												<span class="text">Note</span>										
											</li>
											<li class="" data-value="AC_EV">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" id="ck_AC_EV" value="AC_EV" name="module">
												<span class="text">Event</span>										
											</li>
											
											
											<li class="" data-value="CS">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" id="ck_CS" value="CS" name="module">
												<span class="text">Case & Solution</span>										
											</li>
											
											
											
											<li class="" data-value="Q">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" id="ck_Q" value="Q" name="module">
												<span class="text">Quotation</span>										
											</li>
											<li class="" data-value="S">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" id="ck_S" value="S" name="module">
												<span class="text">Sale Order</span>										
											</li>
											
										</ul>
									</div>
									<div class="chart tab-pane" id="tabChart">
										<!-- <ul class="todo-list ui-sortable">
											<li class="">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" value="S" name="module">
												<span class="text">All Opportunities By Lead Source By Outcome</span>										
											</li>
											<li class="">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" value="S" name="module">
												<span class="text">All Opportunities by Lead Source</span>										
											</li>
											<li class="">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" value="S" name="module">
												<span class="text">Campaign ROI</span>										
											</li>
											<li class="">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" value="S" name="module">
												<span class="text">My Pipeline By Sales Stage</span>										
											</li>
											<li class="">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" value="S" name="module">
												<span class="text">Outcome by Month</span>										
											</li>
											<li class="">
												<span class="handle ui-sortable-handle"> <i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i></span> 
												<input type="checkbox" value="S" name="module">
												<span class="text">Pipeline By Sales Stage</span>										
											</li>
										</ul> -->
									</div>
								</div>							
							</div>
							
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="btnCCSetting" ng-click="ccSetting()" name="btnCCSetting" class="btn btn-danger" data-dismiss="modal">Cancel</button>
						&nbsp;&nbsp;
						<button type="button"  class="btn btn-primary pull-right" id="btnSaveSetting" ng-click="btnSaveSettingClick()"  name="btnSaveSetting">Save</button>
					</div>
				</div>
			</div>
		</div>
		<div id="errors"></div>
	</section>
</div>

<jsp:include page="${request.contextPath}/footer"></jsp:include>

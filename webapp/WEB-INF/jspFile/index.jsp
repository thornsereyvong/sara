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

			} ]);
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
			</ul>
			<div class="tab-content no-padding">
				<div class="chart tab-pane active min-height-300" id="tabCamp">
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
					        		<select class="form-control">
					        			<option value="5">5</option>
					        			<option value="10">10</option>
					        			<option value="15">15</option>
					        			<option value="20">20</option>
					        			<option value="25">25</option>
					        		</select>
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
							<tr dir-paginate="camp in campaigns|filter:search_campaign |itemsPerPage:10"  pagination-id="camp_id"  class="ng-cloak">
								<td><a href="${pageContext.request.contextPath}/view-campaign/{{camp.campId}}">{{camp.campId}}</a></td>
								<td>{{camp.campName}}</td>								
								<td>{{camp.campType}}</td>
								<td>{{camp.campStatus}}</td>
								<td>{{camp.campBudget | number:2}}</td>	
								<td>{{camp.campStartDate}}</td>							
								<td>{{camp.campEndDate}}</td>
								
							</tr>
							<tr>
								<td colspan="8">
									<div class="box-tools pull-right">
										<dir-pagination-controls  pagination-id="camp_id" 
									       max-size="10"
									       direction-links="true"
									       boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="chart tab-pane min-height-300" id="tabLead">
					<table class="table table-striped">
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Status</th>
							<th>Company</th>
							<th>Email</th>
							<th>Phone</th>
						</tr>
						<tr dir-paginate="lead in leads |itemsPerPage:15"  pagination-id="lead_id"  class="ng-cloak">
							<td><a href="${pageContext.request.contextPath}/view-lead/{{lead.leadId}}">{{lead.leadId}}</a></td>
							<td>{{lead.leadName}}</td>								
							<td>{{lead.leadStatus}}</td>
							<td>{{lead.leadCompany}}</td>
							<td>{{lead.leadEmail}} </td>								
							<td>{{lead.leadPhone}}</td>
						</tr>
						<tr>
							<td colspan="6">
								<div class="box-tools pull-right">
									<dir-pagination-controls  pagination-id="lead_id" 
								       max-size="15"
								       direction-links="true"
								       boundary-links="true" >
								    </dir-pagination-controls>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<div class="chart tab-pane min-height-300" id="tabCustomer">
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
							<tr dir-paginate="cust in customers |itemsPerPage:15" pagination-id="cust_id"  class="ng-cloak">
								<td><a href="${pageContext.request.contextPath}/view-customer/{{cust.custId}}">{{cust.custId}}</a></td>
								<td>{{cust.custName}}</td>
								<td>{{cust.custIndustry}}</td>
								<td>{{cust.custLeadSource}}</td>
								<td>{{cust.custPhone}}</td>
								<td>{{cust.custEmail}}</td>
							</tr>
							<tr>
								<td colspan="6">
									<div class="box-tools pull-right">
										<dir-pagination-controls  pagination-id="cust_id" 
									       max-size="15"
									       direction-links="true"
									       boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="chart tab-pane min-height-300" id="tabContact">
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
							<tr dir-paginate="con in contacts |itemsPerPage:15" pagination-id="con_id"  class="ng-cloak">
								<td><a href="${pageContext.request.contextPath}/view-contact/{{con.conId}}">{{con.conId}}</a></td>
								<td>{{con.conName}}</td>
								<td>[{{con.custId}}] {{con.custName}}</td>
								<td>{{con.leadSource}}</td>
								<td>{{con.conPhone}}</td>
								<td>{{con.conEmail}}</td>
							</tr>
							<tr>
								<td colspan="6">
									<div class="box-tools pull-right">
										<dir-pagination-controls  pagination-id="con_id" 
									       max-size="15"
									       direction-links="true"
									       boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="chart tab-pane min-height-300" id="tabOpportunity">
					<table class="table table-striped">
						<tbody>
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Amount</th>
								<th>Customer</th>
								<th>Campaign</th>
								<th>Lead Source</th>
							</tr>
							<tr dir-paginate="op in opportunities |itemsPerPage:15" pagination-id="opp_id"  class="ng-cloak">
								<td><a href="${pageContext.request.contextPath}/view-opportunity/{{op.opId}}">{{op.opId}}</a></td>
								<td>{{op.opName}}</td>
								<td>{{op.opAmount}}</td>
								<td>[{{op.opCustId}}] {{op.opCustName}}</td>
								<td>[{{op.opCampId}}] {{op.opCampName}}</td>
								<td>{{op.opLeadSource}}</td>
							</tr>
							<tr>
								<td colspan="6">
									<div class="box-tools pull-right">
										<dir-pagination-controls  pagination-id="opp_id" 
									       max-size="15"
									       direction-links="true"
									       boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="chart tab-pane min-height-300" id="tabCall">
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
							<tr dir-paginate="call in calls |itemsPerPage:15" pagination-id="call_id"  class="ng-cloak">
								<td><a href="${pageContext.request.contextPath}/view-call/{{call.callId}}">{{call.callId}}</a></td>
								<td>{{call.callSubject}}</td>
								<td><span ng-if=" call.callRelatedToType != '' "><span class="badge bg-red">{{call.callRelatedToType}}</span> <span>[{{call.callRelatedToId}}] {{call.callRelatedTo}}</span></span></td>
								<td>{{call.callStartDate}}</td>
								<td>{{call.callDuration}} min</td>
								<td>{{call.callStatus}}</td>
								
							</tr>
							<tr>
								<td colspan="6">
									<div class="box-tools pull-right">
										<dir-pagination-controls  pagination-id="call_id" 
									       max-size="15"
									       direction-links="true"
									       boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="chart tab-pane min-height-300" id="tabMeeting">
					<table class="table">
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
							<tr dir-paginate="meet in meetings |itemsPerPage:15"  pagination-id="meet_id"  class="ng-cloak">
								<td><a href="${pageContext.request.contextPath}/view-meeting/{{meet.meetingId}}">{{meet.meetingId}}</a></td>
								<td>{{meet.meetingSubject}}</td>
								<td><span ng-if=" meet.meetingRelatedToType != '' "><span  class="badge bg-red">{{meet.meetingRelatedToType}}</span> <span>[{{meet.meetingRelatedToId}}] {{meet.relatedRelatedTo}}</span></span></td>
								<td>{{meet.meetingLocation}}</td>
								<td>{{meet.meetingStartDate}}</td>
								<td>{{meet.meetingEndDate}}</td>
								<td>{{meet.meetingStatus}}</td>
								
							</tr>
							<tr>
								<td colspan="7">
									<div class="box-tools pull-right">
										<dir-pagination-controls  pagination-id="meet_id" 
									       max-size="15"
									       direction-links="true"
									       boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="chart tab-pane min-height-300" id="tabTask">
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
						<tr dir-paginate="task in tasks |itemsPerPage:15" pagination-id="task_id"  class="ng-cloak">
							<td><a href="${pageContext.request.contextPath}/view-task/{{task.taskId}}">{{task.taskId}}</a></td>
							<td>{{task.taskSubject}}</td>
							<td><span ng-if=" task.taskRelatedToType != '' "><span  class="badge bg-red">{{task.taskRelatedToType}}</span> <span>[{{task.taskRelatedToId}}] {{task.taskRelatedTo}}</span></span></td>
							<td>{{task.taskPriority}}</td>
							<td>{{task.taskStatus}}</td>
							<td>{{task.taskStartDate}}</td>
							<td>{{task.taskDueDate}}</td>
						</tr>
						<tr>
							<td colspan="7">
								<div class="box-tools pull-right">
									<dir-pagination-controls  pagination-id="task_id" 
								       max-size="15"
								       direction-links="true"
								       boundary-links="true" >
								    </dir-pagination-controls>
								</div>
							</td>
						</tr>
					</table>
				</div>				
				<div class="chart tab-pane min-height-300" id="tabNote">
					<table class="table table-striped">
						<tr>
							<th>ID</th>
							<th>Subject</th>
							<th>Related To</th>
							<th>Date</th>
						</tr>
						<tr dir-paginate="note in notes |itemsPerPage:15"  pagination-id="note_id"  class="ng-cloak">
							<td><a href="${pageContext.request.contextPath}/view-note/{{note.noteId}}">{{note.noteId}}</a></td>
							<td>{{note.noteSubject}} </td>
							<td><span ng-if=" note.noteRelatedToType != '' "><span  class="badge bg-red">{{note.noteRelatedToType}}</span> <span>[{{note.noteRelatedToId}}] {{note.noteRelatedTo}}</span></span></td>
							<td>{{note.noteCreatedDate}}</td>
							
						</tr>
						<tr>
							<td colspan="4">
								<div class="box-tools pull-right">
									<dir-pagination-controls  pagination-id="note_id" 
								       max-size="15"
								       direction-links="true"
								       boundary-links="true" >
								    </dir-pagination-controls>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<div class="chart tab-pane min-height-300" id="tabEvent">
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
						<tr dir-paginate="event in events |itemsPerPage:15"  pagination-id="event_id"  class="ng-cloak">
							<td><a href="${pageContext.request.contextPath}/view-event/{{event.eventId}}">{{event.eventId}}</a></td>
							<td>{{event.eventName}} </td>
							<td><span ng-if=" event.eventRelatedToType != '' "><span  class="badge bg-red">{{event.eventRelatedToType}}</span> <span>[{{event.eventRelatedToId}}] {{event.eventRelatedTo}}</span></span></td>
							<td>{{event.loName}}</td>
							<td>{{event.eventStartDate}}</td>
							<td>{{event.eventEndDate}}</td>
							<td>{{event.eventBudget | number:2}}</td>	
						</tr>
						<tr>
							<td colspan="7">
								<div class="box-tools pull-right">
									<dir-pagination-controls  pagination-id="event_id" 
								       max-size="15"
								       direction-links="true"
								       boundary-links="true" >
								    </dir-pagination-controls>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<div class="chart tab-pane min-height-300" id="tabCases">
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
					        		<select class="form-control">
					        			<option value="5">5</option>
					        			<option value="10">10</option>
					        			<option value="15">15</option>
					        			<option value="20">20</option>
					        			<option value="25">25</option>
					        		</select>
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
							<tr dir-paginate="case in cases |filter:search_case |itemsPerPage:10"  pagination-id="case_id"  class="ng-cloak">
								<td><a href="${pageContext.request.contextPath}/view-case/{{case.caseId}}">{{case.caseId}}</a></td>
								<td>{{case.caseSubject}}</td>								
								<td>{{case.caseStatus}}</td>
								<td>{{case.casePriority}}</td>
								<td>{{case.caseType}} </td>	
								<td><span ng-if=" case.conId !='' ">[{{case.conId}}] {{case.caseContact}}</span></td>							
								<td><span ng-if=" case.custId !='' ">[{{case.custId}}] {{case.caseCustomer}}</span></td>
							</tr>
							<tr>
								<td colspan="7">
									<div class="box-tools pull-right">
										<dir-pagination-controls  pagination-id="lead_id" 
									       max-size="10"
									       direction-links="true"
									       boundary-links="true" >
									    </dir-pagination-controls>
									</div>
								</td>
							</tr>	
						</table>
					</div>
				</div>
				<div class="chart tab-pane min-height-300" id="tabQuote">	
					<table class="table table-striped">
						<tr>
							<th>ID</th>
							<th>Customer</th>
							<th>Employee</th>
							<th>Quote Date</th>
							<th>Start Date</th>
							<th>Expire Date</th>
						</tr>
						<tr dir-paginate="qu in quotations |itemsPerPage:10"  pagination-id="quote_id"  class="ng-cloak">
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
								       max-size="10"
								       direction-links="true"
								       boundary-links="true" >
								    </dir-pagination-controls>
								</div>
							</td>
						</tr>	
					</table>				
				</div>
				
				<div class="chart tab-pane min-height-300" id="tabSaleOrder">	
					<table class="table table-striped">
						<tr>
							<th>ID</th>
							<th>Customer</th>
							<th>Employee</th>
							<th>Sale Date</th>
							<th>Due Date</th>
						</tr>
						<tr dir-paginate="sal in saleorders |itemsPerPage:15"  pagination-id="sale_id"  class="ng-cloak">
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
								       max-size="15"
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

		<div id="errors"></div>
	</section>
</div>

<jsp:include page="${request.contextPath}/footer"></jsp:include>


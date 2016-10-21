<%@page import="java.util.List"%>
<%@page import="com.app.entities.CrmUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<script type="text/javascript">
var app = angular.module('dashApp', ['angularUtils.directives.dirPagination']);
var self = this;
var username = "${SESSION}";
app.controller('dashController',['$scope','$http',function($scope, $http){
	$scope.dashStartup = function(){
		
		$http.get("${pageContext.request.contextPath}/dashboard/startup/"+username).success(function(response){
		
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
		});
		
	};
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	
}]);


</script>



<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Dashboard</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i> Dashboard</a></li>
		</ol>
	</section>


	<section class="content" ng-app="dashApp" ng-controller="dashController">
		<div class="row" data-ng-init="dashStartup()">
			
				<div  class="col-md-12">			
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">My Calls</h3>
							
						</div>
						<!-- /.box-header -->
						<div class="box-body no-padding">
							<table class="table table-striped">
								<tbody>
									<tr>
										<th>#</th>
										<th>Subject</th>
										<th>Related To</th>
										<th>Start Date</th>
										<th>Duration</th>
										<th>Status</th>
									</tr>
									<tr dir-paginate="call in calls |itemsPerPage:5" pagination-id="call_id"  class="ng-cloak">
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
											       max-size="5"
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
				
				</div>
				<div class="col-md-12">
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">My Meetings</h3>
							<div class="box-tools">
								
							</div>
						</div>
						<!-- /.box-header -->
						<div class="box-body no-padding">
							<table class="table">
								<tbody>
									<tr>
										<th>#</th>
										<th>Subject</th>
										<th>Related To</th>
										<th>Location</th>
										<th>Start Date</th>
										<th>End Date</th>
										<th>Status</th>
									</tr>
									<tr dir-paginate="meet in meetings |itemsPerPage:5"  pagination-id="meet_id"  class="ng-cloak">
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
											       max-size="5"
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
				</div>
				<div  class="col-md-12">			
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">My Notes</h3>
						</div>
						<!-- /.box-header -->
						<div class="box-body no-padding">
							<table class="table table-striped">
								<tr>
									<th>#</th>
									<th>Subject</th>
									<th>Related To</th>
									<th>Date</th>
								</tr>
								<tr dir-paginate="note in notes |itemsPerPage:5"  pagination-id="note_id"  class="ng-cloak">
									<td><a href="${pageContext.request.contextPath}/view-note/{{note.noteId}}">{{note.noteId}}</a></td>
									<td>{{note.noteSubject}} </td>
									<td><span ng-if=" note.noteRelatedToType != '' "><span  class="badge bg-red">{{note.noteRelatedToType}}</span> <span>[{{note.noteRelatedToId}}] {{note.noteRelatedTo}}</span></span></td>
									<td>{{note.noteCreatedDate}}</td>
									
								</tr>
								<tr>
									<td colspan="7">
										<div class="box-tools pull-right">
											<dir-pagination-controls  pagination-id="note_id" 
										       max-size="5"
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
				
			
				<div  class="col-md-12">			
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">My Tasks</h3>
							
						</div>
						<!-- /.box-header -->
						<div class="box-body no-padding">
							<table class="table table-striped">
								<tr>
									<th>#</th>
									<th>Subject</th>
									<th>Related To</th>
									<th>Priority</th>								
									<th>Status</th>
									<th>Start Date</th>
									<th>Due Date</th>
								</tr>
								<tr dir-paginate="task in tasks |itemsPerPage:5" pagination-id="task_id"  class="ng-cloak">
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
										       max-size="5"
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
				<div  class="col-md-12">			
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">My Events</h3>
							
						</div>
						<!-- /.box-header -->
						<div class="box-body no-padding">
							<table class="table table-striped">
								<tr>
									<th>#</th>
									<th>Name</th>
									<th>Related To</th>
									<th>Location</th>
									<th>Start Date</th>
									<th>End Date</th>
									<th>Budget</th>
								</tr>
								<tr dir-paginate="event in events |itemsPerPage:5"  pagination-id="event_id"  class="ng-cloak">
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
										       max-size="5"
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
				<div  class="col-md-12">			
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">My Locations</h3>
						</div>
						<!-- /.box-header -->
						<div class="box-body no-padding">
							<table class="table table-striped">
								<tr>
									<th>#</th>
									<th>Name</th>
									<th>Date</th>
								</tr>
								<tr dir-paginate="location in locations |itemsPerPage:5"  pagination-id="location_id"  class="ng-cloak">
									<td><a href="${pageContext.request.contextPath}/view-location/{{location.locationId}}">{{location.locationId}}</a></td>
									<td>{{location.locationName}} </td>								
									<td>{{location.locationCreatedDate}}</td>
									
								</tr>
								<tr>
									<td colspan="7">
										<div class="box-tools pull-right">
											<dir-pagination-controls  pagination-id="location_id" 
										       max-size="5"
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
				<div  class="col-md-12">			
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">My Campaigns</h3>
						</div>
						<!-- /.box-header -->
						<div class="box-body no-padding">
							<table class="table table-striped">
								<tr>
									<th>#</th>
									<th>Name</th>
									<th>Status</th>
									<th>Type</th>
									<th>Budget</th>
									<th>Start Date</th>
									<th>End Date</th>
								</tr>
								<tr dir-paginate="camp in campaigns |itemsPerPage:5"  pagination-id="camp_id"  class="ng-cloak">
									<td><a href="${pageContext.request.contextPath}/view-campaign/{{camp.campId}}">{{camp.campId}}</a></td>
									<td>{{camp.campName}}</td>								
									<td>{{camp.campType}}</td>
									<td>{{camp.campStatus}}</td>
									<td>{{camp.campBudget | number:2}}</td>	
									<td>{{camp.campStartDate}}</td>							
									<td>{{camp.campEndDate}}</td>
									
								</tr>
								<tr>
									<td colspan="6">
										<div class="box-tools pull-right">
											<dir-pagination-controls  pagination-id="camp_id" 
										       max-size="5"
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
				<div  class="col-md-12">			
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">My Leads</h3>
						</div>
						<!-- /.box-header -->
						<div class="box-body no-padding">
							<table class="table table-striped">
								<tr>
									<th>#</th>
									<th>Name</th>
									<th>Status</th>
									<th>Company</th>
									<th>Email</th>
									<th>Phone</th>
								</tr>
								<tr dir-paginate="lead in leads |itemsPerPage:5"  pagination-id="lead_id"  class="ng-cloak">
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
										       max-size="5"
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
				<div  class="col-md-12">			
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">My Cases</h3>
						</div>
						<!-- /.box-header -->
						<div class="box-body no-padding">
							<table class="table table-striped">
								<tr>
									<th>#</th>
									<th>Subject</th>
									<th>Status</th>
									<th>Priority</th>
									<th>Type</th>
									<th>Contact</th>
									<th>Customer</th>
								</tr>
								<tr dir-paginate="case in cases |itemsPerPage:5"  pagination-id="case_id"  class="ng-cloak">
									<td><a href="${pageContext.request.contextPath}/view-case/{{case.caseId}}">{{case.caseId}}</a></td>
									<td>{{case.caseSubject}}</td>								
									<td>{{case.caseStatus}}</td>
									<td>{{case.casePriority}}</td>
									<td>{{case.caseType}} </td>	
									<td><span ng-if=" case.conId !='' ">[{{case.conId}}] {{case.caseContact}}</span></td>							
									<td><span ng-if=" case.custId !='' ">[{{case.custId}}] {{case.caseCustomer}}</span></td>
								</tr>
								<tr>
									<td colspan="6">
										<div class="box-tools pull-right">
											<dir-pagination-controls  pagination-id="lead_id" 
										       max-size="5"
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
			
			<div id="errors"></div>
		</div>
		
	</section>
	<!-- /.content -->


</div>


<!-- /.content-wrapper -->




<jsp:include page="${request.contextPath}/footer"></jsp:include>


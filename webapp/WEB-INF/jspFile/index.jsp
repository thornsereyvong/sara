<%@page import="java.util.List"%>
<%@page import="com.app.entities.CrmUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<script type="text/javascript">
var app = angular.module('dashApp', ['angularUtils.directives.dirPagination','oitozero.ngSweetAlert']);
var self = this;
app.controller('dashController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	$scope.dashStartup = function(){
		$http.get("${pageContext.request.contextPath}/meeting/list").success(function(response){
				$scope.meetings = response.DATA;
				
		});
		$http.get("${pageContext.request.contextPath}/call/list").success(function(response){
			$scope.calls = response.DATA;			
			
		});
		$http.get("${pageContext.request.contextPath}/task/list").success(function(response){
			$scope.tasks = response.DATA;
		});
		
		$http.get("${pageContext.request.contextPath}/event/list").success(function(response){
			$scope.events = response.DATA;
		});
		$http.get("${pageContext.request.contextPath}/note/list").success(function(response){
			$scope.notes = response.DATA;
			
		});
		$http.get("${pageContext.request.contextPath}/event_location/list").success(function(response){
			$scope.locations = response.DATA;
			
		});
		
		
		$http({
		    method: 'POST',
		    url: '${pageContext.request.contextPath}/lead/list',
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    },
		    data: {
		    	"username":"${SESSION}"
		    }
		}).success(function(response){
			$scope.leads = response.DATA;
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
		<div class="row" data-ng-init="dashStartup()" style="margin-right: -30px; margin-left: -30px;">
			
			<div class="col-md-6" style="padding-right: 0px;">
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
										<td>{{call.callId}}</td>
										<td>{{call.callSubject}}</td>
										<td></td>
										<td>{{call.callStartDate | date:'dd-MM-yyyy h:mma'}}</td>
										<td>{{call.callDuration}}</td>
										<td>{{call.callStatusName}}</td>
										
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
								<dir-pagination-controls
							       max-size="5"
							       direction-links="true"
							       boundary-links="true" >
							    </dir-pagination-controls>
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
										<td>{{meet.meetingId}}</td>
										<td>{{meet.meetingSubject}}</td>
										<td></td>
										<td>{{meet.meetingLocation}}</td>
										<td>{{meet.meetingStartDate | date:'dd-MM-yyyy'}}</td>
										<td>{{meet.meetingEndDate | date:'dd-MM-yyyy'}}</td>
										<td>{{meet.statusName}}</td>
										
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
									<td>{{note.noteId}}</td>
									<td>{{note.noteSubject}} </td>
									<td>{{note.noteRelatedToModuleType | uppercase}}: [{{note.noteRelatedToModuleId}}] {{note.noteRelatedName}}</td>
									<td>{{note.createDate}}</td>
									
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
									<td>{{lead.leadID}}</td>
									<td><a href="${pageContext.request.contextPath}/view-leads/{{lead.leadID}}">{{lead.salutation}} {{lead.firstName}} {{lead.lastName}} </a></td>								
									<td>{{lead.statusName}}</td>
									<td>{{lead.accountName}}</td>
									<td>{{lead.email}} </td>								
									<td>{{lead.phone}}</td>
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
			<div class="col-md-6" style="padding-left: 0px;">
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
									<td>{{task.taskId}}</td>
									<td>{{task.taskSubject}}</td>
									<td></td>
									<td>{{task.taskPriority}}</td>
									<td>{{task.taskStatusName}}</td>
									<td>{{task.taskStartDate | date:'dd-MM-yyyy h:mma'}}</td>
									<td>{{task.taskDueDate | date:'dd-MM-yyyy h:mma'}}</td>
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
									<td>{{event.evId}}</td>
									<td>{{event.evName}} </td>
									<td></td>
									<td>{{event.loName}}</td>
									<td>{{event.evStartDate | date:'dd-MM-yyyy h:mma'}}</td>
									<td>{{event.evEndDate | date:'dd-MM-yyyy h:mma'}}</td>
									<td>{{event.evBudget | number:2}}</td>	
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
									<td>{{location.loId}}</td>
									<td>{{location.loName}} </td>								
									<td>{{location.loCreateDate}}</td>
									
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



<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>
<%
	String roleDelete = (String) request.getAttribute("role_delete");
%>


<script type="text/javascript">
var permission = ${permission};
var curAssign = "";
var ownerItem = "";

var app = angular.module('viewOpportunity', ['angularUtils.directives.dirPagination','angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;

var username = "${SESSION}";
var server = "${pageContext.request.contextPath}";

var leadId = "";

var lLead = "";

var oppId = "${custId}";
var lOpportunity = "";

var typeModule = "Customer";
var noteIdEdit = "";
var response=[];
var LEAD = [];
var OPPORTUNITY = [];

var callIdForEdit = null;
var meetIdForEdit = null;
var taskIdForEdit = null;
var eventIdForEdit = null;

var leadStatusData = ["Prospecting", "Qualification", "Analysis", "Proposal", "Negotiation","Close"];
var opportunityStatusData = ["Prospecting", "Qualification", "Analysis", "Proposal", "Negotiation","Close"];

app.controller('viewOpportunityController',['$scope','$http',function($scope, $http){
	
	angular.element(document).ready(function () {				
		/* $("#oppStage").select2('val',response.OPPORTUNITY.osId);
		$("#oppType").select2('val',response.OPPORTUNITY.otId);
		$("#oppLeadSource").select2('val',response.OPPORTUNITY.sourceID);
		$("#oppCustomer").select2('val',response.OPPORTUNITY.custID);
		$("#oppCampaign").select2('val',response.OPPORTUNITY.campID);
		$("#oppAssignTo").select2('val',response.OPPORTUNITY.userId); */
		
		//setTimeout(dis($scope.response), 1000)
		
		
    });
	
	$scope.collaborates = [];
	$scope.tags = [];
	$scope.username = username; 
	
	$scope.listLeads = function(){
			//response = getLeadData();
			
			$http.get('${pageContext.request.contextPath}/customer/view/'+username+"/"+oppId).success(function(data){
				$scope.response = response = data;
				
				$scope.opportunity = response.OPPORTUNITIES;
				$scope.customer = response.CUSTOMER;
				curAssign = fmNull(response.CUSTOMER.assignToUsername);
				ownerItem = "";
				
				$scope.listNote1(response.NOTES);
				
				$scope.contactList = response.CONTACT_RELATED_TO;
				$scope.caseList = response.CASES;
				$scope.quoteList = response.QUOTES;
				$scope.saleOrderList = response.SALE_ORDERS;
				
				userAllList(response.ASSIGN_TO,'#callAssignTo','');
				userAllList(response.ASSIGN_TO,'#meetAssignTo','');
				userAllList(response.ASSIGN_TO,'#taskAssignTo','');
				userAllList(response.ASSIGN_TO,'#eventAssignTo','');
				
				
				$scope.listAllCallByLeadId(response.CALLS);	
				$scope.listAllMeetByLeadId(response.MEETINGS);	
				$scope.listAllTaskByLeadId(response.TASKS);
				$scope.listAllEventByLeadId(response.EVENTS);
				
				$scope.listAllEmailByLeadId = function(){	
					$scope.listAllEmailByLead = [];	
				}
				
				
				$scope.listCollab(response.COLLABORATIONS);							
				$scope.callStatusStartup = response.CALL_STATUS;
				$scope.taskStatusStartup = response.TASK_STATUS;
				$scope.taskContactStartup = response.CONTACTS;	
				$scope.eventLocationStartup = response.EVENT_LOCATION;
				$scope.meetStatusStartup = response.MEETING_STATUS;				
				$scope.tags = response.TAG_TO;
				
				addContactToTask(response.CONTACTS);
				
				
		    });
			
		   //	dis(response)
			 
			/* $scope.oppLeadSource = response.LEAD_SOURCE;
			$scope.oppType = response.OPP_TYPES;
			$scope.oppAssignTo = response.ASSIGN_TO;
			$scope.oppCampaign = response.CAMPAIGNS;
			$scope.oppStage = response.OPP_STAGES;
			$scope.oppCustomer = response.CUSTOMERS; */
			
			
	}
	
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	
// Tab Collaborate***************************
	
	$scope.listCollab = function(response){
		$scope.collaborates = response;		
	}
		
	$scope.listCollabByLeadByUser = function(){
		$http({
		    method: 'POST',
		    url: "${pageContext.request.contextPath}/collaborate/list/lead/user",
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    },
		    data: {"moduleId":oppId, "username":username}
		}).success(function(response) {		
			$scope.listCollab(response.DATA);		
		});	
	}
	
	$scope.resetFrmCollab = function(){
		collabIdEdit = "";
		$("#collabTags").select2("val","");
		$('#frmCollab').bootstrapValidator('resetForm', true);
	}
	
	$scope.addCollab = function(){
		$('#frmCollab').submit();
	}
	
	$scope.postLike = function(key,collabId){		
		var status = $scope.collaborates[key].checkLike;
		status = (status == true) ? false : true ;   		
		$http({
		    method: 'POST',
		    url: "${pageContext.request.contextPath}/collaborate/like",
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    },
		    data: {"collapId":collabId, "username":username,"likeStatus":status.toString()}
		}).success(function(response) {	
			$scope.collaborates[key].checkLike = status;		
		});
	} 
		
	
	$scope.newcomment = {};
    $scope.postCommand = function(key,colId){
    	var txtComment = $.trim($scope.newcomment[key].comment);
    	if(txtComment != ""){
    		$http({
    		    method: 'POST',
    		    url: "${pageContext.request.contextPath}/collaborate/add/comment",
    		    headers: {
    		    	'Accept': 'application/json',
    		        'Content-Type': 'application/json'
    		    },
    		    data: {"postId":colId, "username":username,"comment":txtComment}
    		}).success(function(response) {					
    			$scope.collaborates[key].details.push(response.COMMENTS);
    	      	$scope.newcomment = {};			
    		});
    	}     	
    };
	
    
 	$scope.btnDeleteCollabCom = function(keyParent,keyChild,comId){	    	
    	
    	swal({
            title: "<span style='font-size: 25px;'>You are about to delete comment.</span>",
            text: "Click OK to continue or CANCEL to abort.",
            type: "info",
			html: true,
			showCancelButton: true,
			closeOnConfirm: false,
			showLoaderOnConfirm: true,
        }, 
        function(isConfirm){ 
        	  if(isConfirm){        		
        		  $http.delete("${pageContext.request.contextPath}/collaborate/comment/remove/"+comId).success(function(){
	        		 swal({
	              		title:"SUCCESSFUL",
	              		text:"The comment have been deleted!",
	              		type:"success",  
	              		timer: 2000,   
	              		showConfirmButton: false
      			  	  }); 	        		 
        		  });
        		  $scope.collaborates[keyParent].details.splice(keyChild, 1);
        	  }else{
        		 swal({
  	                title:"Cancelled",
  	                text:"This comment is safe!",
  	                type:"error",
  	                timer:2000,
  	                showConfirmButton: false});
        	  }        	        	        	       		
        });
    }
    
	$scope.btnDeleteCollabPost = function(key,postId){
    	swal({
    		 title: "<span style='font-size: 25px;'>You are about to delete post.</span>",
             text: "Click OK to continue or CANCEL to abort.",
             type: "info",
 			html: true,
 			showCancelButton: true,
 			closeOnConfirm: false,
 			showLoaderOnConfirm: true,
        }, 
        function(isConfirm){              	
        	 if(isConfirm){
	       		  $http.delete("${pageContext.request.contextPath}/collaborate/delete/"+postId).success(function(){
		        		  swal({
		              		title:"SUCCESSFUL",
		              		text:"The post have been deleted!",
		              		type:"success",  
		              		timer: 2000,   
		              		showConfirmButton: false
	     			  	  }); 
		        		  $scope.collaborates.splice(key, 1);
	       		  }); 
	       	  }else{
	       		  swal({
	 	                title:"Cancelled",
	 	                text:"This post is safe!",
	 	                type:"error",
	 	                timer:2000,
	 	                showConfirmButton: false});
	       	  }         			
        });    	    	    	
    }	
	
	// End Collaborate***************************
	
	// note
	$scope.addNote = function(){
		$('#frmAddNote').submit();
	}
	$scope.editNoteById = function(noteId){
		$scope.getNoteById(noteId); 
	}
	$scope.deleteNoteById = function(noteId){
		$scope.resetFrmNote();		
		if(getPermissionByModule("AC_NO","delete") == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete note with ID: <span class='color_msg'>"+noteId+"</span>.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					$.ajax({ 
						url : "${pageContext.request.contextPath}/note/remove/"+noteId,
						type : "DELETE",
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){					    						    
							if(result.MESSAGE == "DELETED"){						
								$scope.getListNoteByLead();
			    				swal({
		    						title: "SUCCESSFUL",
		    					  	text: result.MSG,
		    					  	html: true,
		    					  	timer: 2000,
		    					  	type: "success"
		    					});																								
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
		}else{
			alertMsgNoPermision();
		}
	}
	$scope.resetFrmNote = function(){
		noteIdEdit = "";
		$("#btnAddNote").text('Note');
		$('#frmAddNote').bootstrapValidator('resetForm', true);
	}
	$scope.listNote1 = function(data){
		$scope.notes = data;		
	};
	var indexedTeams = [];
    
    $scope.noteToFilter = function() {
        indexedTeams = [];
        return $scope.notes;
    }
    
    $scope.filterNote = function(note) {
        var teamIsNew = indexedTeams.indexOf(note.createDate) == -1;
        if (teamIsNew) {
            indexedTeams.push(note.createDate);
        }
        return teamIsNew;
    }
	
    $scope.getNoteById = function(noteId){
    	 angular.forEach($scope.notes, function(value, key) {
	   		if(value.noteId === noteId) {
	   			noteIdEdit = noteId;
    	        $("#note_subject").val(value.noteSubject);
    	        $("#note_description").val(value.noteDes);
    	        $("#btnAddNote").text('Update');
    	   	}
   		});
    }
    $scope.getListNoteByLead = function(){    	
		$http.get("${pageContext.request.contextPath}/note/list/module/"+oppId).success(function(response){ 
			$scope.listNote1(response.NOTES);
		});
	};
    
	
	
	// lead
	
	
	$scope.editDetailLead = function(){
		$(".show-edit").show();
		$(".show-edit-non-style").show();
		
		$(".show-text-detail").hide();
		$("#showBtnEditLead").show();
		
		addDataToDetailLead();
	}
	
	$scope.saveEditDetailLead = function(){		
		$('#frmOpportDetail').submit();
	}
	
	$scope.cancelEditDetailLead = function(){
		$('#frmOpportDetail').bootstrapValidator('resetForm', true);
		$(".show-edit").hide();
		$(".show-edit-non-style").hide();
		$(".show-text-detail").show();
		$("#showBtnEditLead").hide();
	}
	
    
	// Call path
	$scope.listAllCallByLeadId = function(data){
		$scope.listAllCallByLead = data;	
	}
	$scope.listDataCallByRalateType = function(){
		$http.get("${pageContext.request.contextPath}/call/list/module/"+oppId).success(function(response){	
			$scope.listAllCallByLeadId(response.CALLS);				
		});	
	}
	
	$scope.call_click = function(){
		$("#btn_show_call").click();
	}
	$scope.actEditCall = function(callId){				
		$http.get("${pageContext.request.contextPath}/call/list/"+callId).success(function(response){
			addDataCallToForm(response.DATA);
			callIdForEdit = callId;
			$("#btnCallSave").text("Update");
			$("#tCall").text("Update Call");
			$("#btn_show_call").click();
		});		
	}
	$scope.actDeleteCall = function(callId){
		if(getPermissionByModule("AC_CL","delete") == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete call with ID: <span class='color_msg'>"+callId+"</span>.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					$.ajax({ 
						url : "${pageContext.request.contextPath}/call/remove/"+callId,
						type : "DELETE",
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){					    						    
							if(result.MESSAGE == "DELETED"){						
								$scope.listDataCallByRalateType();
			    				swal({
		    						title: "SUCCESSFUL",
		    					  	text: result.MSG,
		    					  	html: true,
		    					  	timer: 2000,
		    					  	type: "success"
		    					});																								
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
		}else{
			alertMsgNoPermision();
		}
		
		
	}
	// end call path
	
	// meeting path
	
	$scope.listAllMeetByLeadId = function(data){
		$scope.listAllMeetByLead = data;	
	}
	
	$scope.listDataMeetByRalateType = function(){
		$http.get("${pageContext.request.contextPath}/meeting/list/module/"+oppId).success(function(response){		
			$scope.listAllMeetByLeadId(response.MEETINGS);	
		});	
	}
	
	$scope.meet_click = function(){
		$("#btn_show_meet").click();
	}
	$scope.actEditMeeting = function(meetingId){				
		$http.get("${pageContext.request.contextPath}/meeting/list/"+meetingId).success(function(response){			
			addDataMeetToForm(response.DATA);
			meetIdForEdit = meetingId;
			$("#btnMeetSave").text("Update");
			$("#tMeet").text("Update Meeting");
			$("#btn_show_meet").click();
		});		
	}
	$scope.actDeleteMeeting = function(meetingId){	
		
		if(getPermissionByModule("AC_ME","delete") == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete meeting with ID: <span class='color_msg'>"+meetingId+"</span>.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					$.ajax({ 
						url : "${pageContext.request.contextPath}/meeting/remove/"+meetingId,
						type : "DELETE",
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){					    						    
							if(result.MESSAGE == "DELETED"){						
								$scope.listDataMeetByRalateType();
			    				swal({
		    						title: "SUCCESSFUL",
		    					  	text: result.MSG,
		    					  	html: true,
		    					  	timer: 2000,
		    					  	type: "success"
		    					});																								
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
		}else{
			alertMsgNoPermision();
		}
		
		
	}
	
	
	
	// end meeting path
	
	// Task path
	
	$scope.task_click = function(){
		$("#btn_show_task").click();
	}
	$scope.listAllTaskByLeadId = function(data){
		$scope.listAllTaskByLead = data;	
	}
	$scope.listDataTaskByRalateType = function(){
		$http.get("${pageContext.request.contextPath}/task/list/module/"+oppId).success(function(response){		
			$scope.listAllTaskByLeadId(response.TASKS);	
		});	
	}
	$scope.actEditTask = function(taskId){				
		$http.get("${pageContext.request.contextPath}/task/list/"+taskId).success(function(response){			
			addDataTaskToForm(response.DATA);
			taskIdForEdit = taskId;
			$("#btnTaskSave").text("Update");
			$("#tTask").text("Update Task");
			$("#btn_show_task").click();
		});		
	}
	
	$scope.actDeleteTask = function(taskId){						
		
		if(getPermissionByModule("AC_TA","delete") == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete task with ID: <span class='color_msg'>"+taskId+"</span>.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					$.ajax({ 
						url : "${pageContext.request.contextPath}/task/remove/"+taskId,
						type : "DELETE",
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){					    						    
							if(result.MESSAGE == "DELETED"){						
								$scope.listDataTaskByRalateType();
			    				swal({
		    						title: "SUCCESSFUL",
		    					  	text: result.MSG,
		    					  	html: true,
		    					  	timer: 2000,
		    					  	type: "success"
		    					});																								
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
		}else{
			alertMsgNoPermision();
		}
		
	}
	
	
	
	// end Task path
	
	
	
	
	
	// event path
	
	
	$scope.event_click = function(){
		$("#btn_show_event").click();
	}

	$scope.listAllEventByLeadId = function(data){
		$scope.listAllEventByLead = data;	
	}
	$scope.listDataEventByRalateType = function(){
		$http.get("${pageContext.request.contextPath}/event/list/module/"+oppId).success(function(response){
			$scope.listAllEventByLeadId(response.EVENTS);	
		});	
	}
	$scope.actEditEvent = function(eventId){				
		$http.get("${pageContext.request.contextPath}/event/list/"+eventId).success(function(response){			
			addDataEventToForm(response.DATA);
			eventIdForEdit = eventId;
			$("#btnEventSave").text("Update");
			$("#tEvent").text("Update Event");
			$("#btn_show_event").click();
		});		
	}
	
	$scope.actDeleteEvent = function(eventId){				
		
		if(getPermissionByModule("AC_EV","delete") == "YES"){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to delete event with ID: <span class='color_msg'>"+eventId+"</span>.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					$.ajax({ 
						url : "${pageContext.request.contextPath}/event/remove/"+eventId,
						type : "DELETE",
						beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
					    }, 
					    success: function(result){					    						    
							if(result.MESSAGE == "DELETED"){						
								$scope.listDataEventByRalateType();
			    				swal({
		    						title: "SUCCESSFUL",
		    					  	text: result.MSG,
		    					  	html: true,
		    					  	timer: 2000,
		    					  	type: "success"
		    					});																								
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
		}else{
			alertMsgNoPermision();
		}
		
		
	}
	
	
	
	// end event path
	
	
	
	
	$scope.email_click = function(){
		$("#btn_show_email").click();
	}
	
	
}]);


app.controller('callController',['$scope','$http',function($scope, $http){
	$scope.startupCallForm = function(){
	/* 	$http.get("${pageContext.request.contextPath}/call_status/list")
			.success(function(response){
				$scope.callStatusStartup = response.DATA;
	    }); */
	}
	$scope.cancelCallClick = function(){
		callIdForEdit = null;
		$("#callStatus").select2('val',"");
		$("#callAssignTo").select2('val',"");	
		$("#btnCallSave").text("Save");
		$("#tCall").text("Create Call");
		$('#frmAddCall').bootstrapValidator('resetForm', true);
	}	
}]);



app.controller('meetController',['$scope','$http',function( $scope, $http){
	$scope.startupMeetForm = function(){
		/* $http.get("${pageContext.request.contextPath}/meeting_status/list").success(function(response){
			$scope.meetStatusStartup = response.DATA;
	    }); */
	}
	$scope.cancelMeetClick = function(){
		 meetIdForEdit = null;
		$("#meetStatus").select2('val',"");
		$("#meetAssignTo").select2('val',"");	
		$("#btnMeetSave").text("Save");
		$("#tMeet").text("Create Meeting");
		$('#frmAddMeet').bootstrapValidator('resetForm', true);
	}	
}]);

app.controller('taskController',['$scope','$http',function( $scope, $http){
	
	$scope.startupTaskForm = function(){
/* 		$http.get("${pageContext.request.contextPath}/task_status/list").success(function(response){
			$scope.taskStatusStartup = response.DATA;
		});

		$http.get("${pageContext.request.contextPath}/contact/list").success(function(response){
			$scope.taskContactStartup = response.DATA;
		}); */
		
	}
	
	$scope.cancelTaskClick = function(){
		taskIdForEdit = null;
		$("#taskPriority").select2('val',"");
		$("#taskContact").select2('val',"");
		$("#taskStatus").select2('val',"");
		$("#taskAssignTo").select2('val',"");	
		$("#btnTaskSave").text("Save");
		$("#tTask").text("Create Task");
		$('#frmAddTask').bootstrapValidator('resetForm', true);
	}	
}]);

app.controller('eventController',['$scope','$http',function( $scope, $http){
	
	$scope.startupEventForm = function(){
		/* $http.get("${pageContext.request.contextPath}/event_location/list").success(function(response){
			$scope.eventLocationStartup = response.DATA;
		}); */
	}
	
	$scope.cancelEventClick = function(){
		eventIdForEdit = null;
		$("#eventLocation").select2('val',"");
		$("#eventAssignTo").select2('val',"");	
		$("#btnEventSave").text("Save");
		$("#tEvent").text("Create Event");
		$('#frmAddEvent').bootstrapValidator('resetForm', true);
	}	
}]);


function addDataCallToForm(data){
	$("#callStatus").select2('val',data.callStatusId);
	$("#callAssignTo").select2('val',data.userID);	
	
	setValueById('callStartDate', data.callStartDate);
	setValueById('callSubject', data.callSubject);
	setValueById('callDescription', data.callDes);
	setValueById('callDuration', data.callDuration);
}

function addDataMeetToForm(data){
	
	$("#meetStatus").select2('val',data.statusId);
	$("#meetAssignTo").select2('val',data.userID);	
	$("#meetDuration").select2('val',data.meetingDuration);
	
	setValueById('meetEndDate', data.meetingEndDate);
	setValueById('meetStartDate', data.meetingStartDate);
	setValueById('meetSubject', data.meetingSubject);
	setValueById('meetDescription', data.meetingDes);
	setValueById('meetLocation', data.meetingLocation);
}

function addDataTaskToForm(data){
	
	$("#taskStatus").select2('val',data.taskStatusId);
	$("#taskAssignTo").select2('val',data.userID);	
	$("#taskPriority").select2('val',data.taskPriority);
	$("#taskContact").select2('val',data.conID);
	
	setValueById('taskEndDate', data.taskDueDate);
	setValueById('taskStartDate', data.taskStartDate);
	setValueById('taskSubject', data.taskSubject);
	setValueById('taskDescription', data.taskDes);
}

function addDataEventToForm(data){
	
	$("#eventDuration").select2('val',data.evDuration);
	$("#eventAssignTo").select2('val',data.userID);	
	$("#eventLocation").select2('val',data.locateId);
	
	setValueById('eventEndDate', data.evEndDate);
	setValueById('eventStartDate', data.evStartDate);
	setValueById('eventSubject', data.evName);
	setValueById('eventDescription', data.evDes);
	setValueById('eventBudget', data.evBudget);
}


function getLeadData(){	
	var data = JSON.parse(
		$.ajax({
			method: 'GET',
		    url: '${pageContext.request.contextPath}/customer/view/'+username+"/"+oppId,
		    async: false,
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    }
		}).responseText);	
	return data;	
}

function getLeadById(){
	var data = JSON.parse(
		$.ajax({
			method: 'GET',
		    url: '${pageContext.request.contextPath}/customer/list/'+oppId,
		    async: false
		}).responseText);	
	return data;
}

function clickStatus(num){
	/* if(num == 4){
		window.location.href = server+"/convert-lead/"+leadId;
	} */
}
function addContactToTask(data){
	if(data.length>0){
		for(var i=0; i< data.length; i++){
			$("#taskContact").append("<option value='"+data[i].conID+"'>"+data[i].conSalutation+" "+data[i].conFirstname+" "+data[i].conLastname+"</option>");
		}
	}
}
function displayStatusLead(Status){	
	var obj = "";	
	for(var i=1; i<=leadStatusData.length; i++){		
		if(i<Status){		
			obj += "<li onClick='clickStatus("+i+")' class='completed'><a href='#'><i class='fa fa-check-circle'></i> "+leadStatusData[i-1]+"</a></li>";	
		}else if(i==Status){			
			if(Status == 5){
				obj += "<li onClick='clickStatus("+i+")' class='dead'><a href='#'><i class='fa fa-check-circle'></i> "+leadStatusData[i-1]+"</a></li>";
			}else{
				obj += "<li onClick='clickStatus("+i+")' class='active'><a href='#'><i class='fa fa-check-circle'></i> "+leadStatusData[i-1]+"</a></li>";
			}
		}else{
			obj += "<li onClick='clickStatus("+i+")' class=''>         <a href='#'><i class='fa fa-lock'></i> "+leadStatusData[i-1]+"</a></li>";
		}
	}
	$("#objStatus").append(obj);
}

function addDataToDetailLead(){
	
	
	$("#oppStage").select2('val', OPPORTUNITY.osId);
	$("#oppType").select2('val', OPPORTUNITY.otId);
	$("#oppLeadSource").select2('val', OPPORTUNITY.sourceID);
	$("#oppCustomer").select2('val', OPPORTUNITY.custID);
	$("#oppCampaign").select2('val', OPPORTUNITY.campID);
	$("#oppAssignTo").select2('val', OPPORTUNITY.userID);
	
	setValueById('oppName', OPPORTUNITY.opName);
	setValueById('oppAmout', OPPORTUNITY.opAmount);
	setValueById('oppCloseDate', conDateSqlToNormal(OPPORTUNITY.opCloseDate,'/'));
	setValueById('oppNextStep', OPPORTUNITY.opNextStep);
	setValueById('appProbability', OPPORTUNITY.opProbability);
	setValueById('appDescription', OPPORTUNITY.opDes);
	
	
}

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
<div class="content-wrapper" id="viewOpportunityController" ng-app="viewOpportunity"
	ng-controller="viewOpportunityController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>View Customer</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>View Customer</a></li>
		</ol>
	</section>

	<section class="content" data-ng-init="listLeads()">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<!-- Widget: user widget style 1 -->
				<div class="box box-widget widget-user">
					<!-- Add the bg color to the header using any of the bg-* classes -->
					<div class="widget-user-header bg-aqua-active">
						<h3 class="widget-user-username ng-cloak">[{{customer.custID}}] {{customer.custName}}</h3>
						<h5 class="widget-user-desc">CUSTOMER NAME</h5>
					</div>
					<div class="widget-user-image">
						<img class="img-circle"
							src="${pageContext.request.contextPath}/resources/images/module/Customer.png"
							alt="User Avatar">
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak">{{customer.custTel1 == ''?'-':customer.custTel1}}</h5>
									<span class="description-text">Tel</span>
								</div>
							</div>
							<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak">{{customer.custEmail == ''?'-':customer.custEmail}}</h5>
									<span class="description-text">Email</span>
								</div>
							</div>
							<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak">{{customer.industID.industName == null?'-':customer.industID.industName}}</h5>
									<span class="description-text">Industry</span>
								</div>
							</div>
							<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak">[{{customer.custGroup.custGroupId}}] {{customer.custGroup.custGroupName}}</h5>
									<span class="description-text">Group</span>
								</div>
							</div>
							
							<!-- <div class="col-sm-12">
								<ul class="breadcrumb1" id="objStatus">
								</ul>
							</div> -->

							<div class="clearfix"></div>
							<br />
							<div class="col-md-12">
								<div id="note" class="nav-tabs-custom">
									<ul class="nav nav-tabs">
										<li class="active"><a href="#activity" data-toggle="tab"
											aria-expanded="true">ACTIVITY</a></li>
										<li class=""><a href="#collaborate" data-toggle="tab"
											aria-expanded="false">COLLABORATE</a></li>
										<li class=""><a href="#note_tap" data-toggle="tab"
											aria-expanded="false">NOTES</a></li>
										<li class=""><a href="#detail_tap" data-toggle="tab"
											aria-expanded="false">DETAILS</a></li>
										<li class=""><a href="#related_tap" data-toggle="tab"
											aria-expanded="false">RELATED</a></li>
									</ul>
									<div class="tab-content">
										<div class="tab-pane active" id="activity">
											<div class="row">

												<div class="col-md-12" >
													<a style="margin-left: 0px;" class="btn btn-app" ng-click="call_click()"> 
														<i class="fa fa-phone"></i> Call
													</a> 
													<a class="btn btn-app" ng-click="meet_click()"> 
														<i class="fa fa-users"></i> Meeting
													</a> 
													<a class="btn btn-app" ng-click="task_click()"> 
														<i class="fa fa-list-alt "></i> Task
													</a> 
													<a class="btn btn-app" ng-click="event_click()"> 
														<i class="fa  fa-calendar-check-o"></i> Event
													</a> 
													<a class="btn btn-app" ng-click="email_click()"> 
														<i class="fa fa-envelope"></i> Email
													</a>
												</div>
												<div class="col-md-12">
													<div class="panel-group" id="accordion">
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title">
																	<a data-toggle="collapse" data-parent="#accordion" href="#collapse1">Calls</a>
																	<span class="badge bg-blue pull-right ng-cloak">{{listAllCallByLead.length <= 0 ? '' : listAllCallByLead.length }}</span>
																</h4>
															</div>
															<div id="collapse1" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages table-responsive">
																		<table class="table iTable"> 					
																			<thead>
																				<tr>
																					<th>ID</th>
																					<th>Subject</th>
																					<th>Start Date</th>
																					<th>Duration</th>
																					<th>Assign To</th>
																					<th>Create By</th>
																					<th class="text-center">Action</th>
																				</tr>
																			</thead>
																			<tbody dir-paginate="call in listAllCallByLead|itemsPerPage:5" pagination-id="callId">
																				<tr>
																					<td><a href="${pageContext.request.contextPath}/view-call/{{call.callId}}">{{call.callId}}</a></td>
																					<td>{{call.callSubject}}</td>
																					<td>{{call.callStartDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{call.callDuration}}</td>
																					<td>{{call.username == null?'-':call.username}}</td>
																					<td>{{call.callCreateBy}}</td>
																					<td class="text-center mailbox-date" style="min-width: 100px;">
																						<a href="#" ng-click="actEditCall(call.callId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
																						<a href="#" ng-click="actDeleteCall(call.callId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="delete"><i class="fa fa-trash text-danger"></i></button></a>
																						<a href="${pageContext.request.contextPath}/view-call/{{call.callId}}"><button type="button" data-toggle="tooltip" class="btn btn-xs" title="view"><i class="fa fa-eye text-info"></i></button></a>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																	<dir-pagination-controls pagination-id="callId" max-size="5" direction-links="true" boundary-links="true"> </dir-pagination-controls>
																</div>
															</div>
														</div>
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title">
																	<a data-toggle="collapse" data-parent="#accordion" href="#collapse2"> Meetings</a>
																	<span class="badge bg-blue pull-right ng-cloak">{{listAllMeetByLead.length <= 0 ? '' : listAllMeetByLead.length }}</span>
																</h4>
															</div>
															<div id="collapse2" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages table-responsive">
																		<table class="table iTable"> 
																			<thead>
																				<tr>
																					<th>ID</th>
																					<th>Subject</th>
																					<th>Status</th>
																					<th>Start Date</th>
																					<th>End Date</th>
																					<th>Assign To</th>
																					<th>Create By</th>
																					<th class="text-center">Action</th>
																				</tr>
																			</thead>
																			<tbody dir-paginate="meet in listAllMeetByLead|itemsPerPage:5" pagination-id="meetId">
																				<tr>
																					<td><a href="${pageContext.request.contextPath}/view-meeting/{{meet.meetingId}}">{{meet.meetingId}}</a></td>
																					<td>{{meet.meetingSubject.trunc(20)}}</td>
																					<td>{{meet.statusName}}</td>
																					<td>{{meet.meetingStartDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{meet.meetingEndDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{meet.username}}</td>
																					<td>{{meet.meetingCreateBy}}</td>
																					<td class="text-center mailbox-date" style="min-width: 100px;">
																						<a href="#" ng-click="actEditMeeting(meet.meetingId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
																						<a href="#" ng-click="actDeleteMeeting(meet.meetingId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="delete"><i class="fa fa-trash text-danger"></i></button></a>
																						<a href="${pageContext.request.contextPath}/view-meeting/{{meet.meetingId}}"><button type="button" data-toggle="tooltip" class="btn btn-xs" title="view"><i class="fa fa-eye text-info"></i></button></a>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																	<dir-pagination-controls pagination-id="meetId" max-size="5" direction-links="true" boundary-links="true"> </dir-pagination-controls>																
																</div>
															</div>
														</div>
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title">
																	<a data-toggle="collapse" data-parent="#accordion" href="#collapse3"> Tasks</a>
																	<span class="badge bg-blue pull-right ng-cloak">{{listAllTaskByLead.length <= 0 ? '' : listAllTaskByLead.length }}</span>
																</h4>
															</div>
															<div id="collapse3" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages table-responsive">
																		<table class="table iTable"> 
																			<thead>
																				<tr>
																					<th>ID</th>
																					<th>Subject</th>
																					<th>Status</th>
																					<th>Start Date</th>
																					<th>End Date</th>
																					<th>Assign To</th>
																					<th>Create By</th>
																					<th class="text-center">Action</th>
																				</tr>
																			</thead>
																			<tbody dir-paginate="task in listAllTaskByLead|itemsPerPage:5" pagination-id="taskId">
																				<tr>
																					<td><a href="${pageContext.request.contextPath}/view-task/{{task.taskId}}">{{task.taskId}}</a></td>
																					<td>{{task.taskSubject}}</td>
																					<td>{{task.taskStatusName}}</td>
																					<td>{{task.taskStartDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{task.taskDueDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{task.username}}</td>
																					<td>{{task.taskCreateBy}}</td>
																					<td class="text-center mailbox-date" style="min-width: 100px;">
																						<a href="#" ng-click="actEditTask(task.taskId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
																						<a href="#" ng-click="actDeleteTask(task.taskId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="delete"><i class="fa fa-trash text-danger"></i></button></a>
																						<a href="${pageContext.request.contextPath}/view-task/{{task.taskId}}"><button type="button" data-toggle="tooltip" class="btn btn-xs" title="view"><i class="fa fa-eye text-info"></i></button></a>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																	<dir-pagination-controls pagination-id="taskId" max-size="5" direction-links="true" boundary-links="true"> </dir-pagination-controls>	
																</div>
															</div>
														</div>
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title">
																	<a data-toggle="collapse" data-parent="#accordion" href="#collapse4"> Events</a>
																	<span class="badge bg-blue pull-right ng-cloak">{{listAllEventByLead.length <= 0 ? '' : listAllEventByLead.length }}</span>
																</h4>
															</div>
															<div id="collapse4" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages table-responsive">
																		<table class="table iTable"> 
																			<thead>
																				<tr>
																					<th>ID</th>
																					<th>Name</th>
																					<th>Location</th>
																					<th>Start Date</th>
																					<th>End Date</th>
																					<th>Assign To</th>
																					<th>Create By</th>
																					<th class="text-center">Action</th>
																				</tr>
																			</thead>
																			<tbody dir-paginate="event in listAllEventByLead|itemsPerPage:5" pagination-id="eventId">
																				<tr>
																					<td><a href="${pageContext.request.contextPath}/view-event/{{event.evId}}">{{event.evId}}</a></td>
																					<td>{{event.evName}}</td>
																					<td>{{event.locateName}}</td>
																					<td>{{event.evStartDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{event.evEndDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{event.username}}</td>
																					<td>{{event.evCreateBy}}</td>
																					<td class="text-center mailbox-date" style="min-width: 100px;">
																						<a href="#" ng-click="actEditEvent(event.evId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
																						<a href="#" ng-click="actDeleteEvent(event.evId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="delete"><i class="fa fa-trash text-danger"></i></button></a>
																						<a href="${pageContext.request.contextPath}/view-event/{{event.evId}}"><button type="button" data-toggle="tooltip" class="btn btn-xs" title="view"><i class="fa fa-eye text-info"></i></button></a>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																	<dir-pagination-controls pagination-id="eventId" max-size="5" direction-links="true" boundary-links="true"> </dir-pagination-controls>
																</div>
															</div>
														</div>
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title">
																	<a data-toggle="collapse" data-parent="#accordion" href="#collapse5"> Emails</a>
																	<span class="badge bg-blue pull-right ng-cloak">{{listAllEmailByLead.length <= 0 ? '' : listAllEmailByLead.length }}</span>
																</h4>
															</div>
															<div id="collapse5" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages table-responsive">
																		<table class="table iTable" data-ng-init="listAllEmailByLeadId()"> 
																			<thead>
																				<tr>
																					<th>ID</th>
																					<th>Subject</th>
																					<th>Sent To</th>
																					<th>Date</th>
																					<th>Status</th>
																					<th>Assign To</th>
																					<th>Create By</th>
																					<th class="text-center">Action</th>
																				</tr>
																			</thead>
																			<tbody ng-repeat="email in listAllEmailByLead">
																				<tr>
																					<td class="iTD-width-50">
																						{{event.evId}}
																					</td>
																					<td>{{event.evName}}</td>
																					<td>{{event.locateName}}</td>
																					<td>{{event.evStartDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{event.evEndDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{event.username}}</td>
																					<td>{{event.evCreateBy}}</td>
																					<td class="text-center mailbox-date" style="min-width: 100px;">
																						<a href="#" ng-click="actEditEvent(event.evId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
																						<a href="#" ng-click="actDeleteEvent(event.evId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="delete"><i class="fa fa-trash text-danger"></i></button></a>
																						<a href="${pageContext.request.contextPath}/view-event/{{event.evId}}"><button type="button" data-toggle="tooltip" class="btn btn-xs" title="view"><i class="fa fa-eye text-info"></i></button></a>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>

										<div class="tab-pane" id="collaborate">
											<div class="col-md-12" style="padding-right: 0px; padding-left: 0px;">
												<form id="frmCollab">													
													<div class="col-sm-12"  style="padding-right: 0px; padding-left: 0px;">
														<div class="form-group">
															<label>Post <span class="requrie">(Required)</span></label> 
															<textarea rows="3" cols="" name="collabPostDescription" id="collabPostDescription" class="form-control" placeholder=""></textarea>
														</div>
													</div>
													<div class="col-sm-12"  style="padding-right: 0px; padding-left: 0px;">
														<div class="form-group">
															<label>Tags </label> 
															<select  class="form-control" multiple name="collabTags" id="collabTags" style="width: 100%;">
																<option ng-repeat="tag in tags" value="{{tag.username}}">{{tag.username}}</option>																
															</select>
														</div>
													</div>
												</form>
												<div class="col-sm-12"  style="padding-right: 0px; padding-left: 0px;">
													<button style="margin-top: 10px; margin-left: 10px;" ng-click="resetFrmCollab()" type="button" class="btn btn-danger pull-right">Reset</button>
													<button type="button" style="margin-top: 10px;" ng-click="addCollab()" name="collabBtnPost" id="collabBtnPost" class="btn btn-primary pull-right">POST</button>
												</div>
											</div>
											<div class="clearfix"></div>
											<br>
											<!-- content collab -->
											
											<div class="post clearfix" ng-repeat="(key_post,collab) in collaborates track by $index">
												<div class="user-block">
													<img class="img-circle img-bordered-sm" src="${pageContext.request.contextPath}/resources/images/av.png" alt="user image"> 
													<span class="username"> 
														<a href="#">{{collab.colUser}}</a> <a style="color: #999;font-size: 13px;">on {{collab.createDate}}</a>
														<span ng-if="collab.colOwn == 'true'" ng-click="btnDeleteCollabPost(key_post,collab.colId)" class="pull-right btn-box-tool cusor_pointer"><button class="btn btn-default btn-sm"><i class="fa fa-trash trask-btn"></i></button></span>
													</span> 													
													<span class="description"><i ng-if="collab.tags.length > 0 " class="fa fa-tags"></i> <span ng-repeat="t in collab.tags">{{t.username}} </span></span>
												</div>
												<p>{{collab.colDes}}</p>																													
												
												<ul class="list-inline">
													<li>
														<span href="#" class="link-black text-sm ">																													
															<span ng-if="collab.checkLike == true"><button ng-click="postLike(key_post,collab.colId)" class="btn btn-default btn-sm"><i  class="fa fa-thumbs-up like-btn"></i></button>&nbsp;&nbsp;&nbsp;You  {{collab.like <= 0 ? "" : collab.like==1 ? "and 1 other" : "and "+collab.like+" others"}}</span>
															<span ng-if="collab.checkLike == false"><button ng-click="postLike(key_post,collab.colId)" class="btn btn-default btn-sm"><i  class="fa fa-thumbs-o-up unlike-btn"></i></button>&nbsp;&nbsp;&nbsp;{{collab.like <= 0 ? "" : collab.like}}</span> 														
														</span>
													</li>
													<li class="pull-right">
														<a href="#" class="link-black text-sm"><i class="fa fa-comments-o margin-r-5"></i> <span> Comments{{collab.details.length <= 0 ? "" : "("+collab.details.length+")"}}</span></a>
													</li>
												</ul>
												
												
												<div style="padding-top: 15px;" class="box-footer box-comments">													
													<div class="box-comment" ng-repeat="(key_comment, com) in collab.details">
														<img class="img-circle img-sm" src="${pageContext.request.contextPath}/resources/images/av.png" alt="user image">
														<div class="comment-text">
															<span class="username"> 
																<span> {{com.username}} <span class="text-muted"> on {{com.formatCreateDate}}</span></span> 
																<span ng-if="com.username == username" ng-click="btnDeleteCollabCom(key_post, key_comment,com.commentId)"  class="pull-right btn-box-tool cusor_pointer"><button class="btn btn-default btn-sm"><i class="fa fa-trash trask-btn"></i></button></span>
															</span>
															{{com.comment}}
														</div>
													</div>
												</div>
												
																							
												<form id="" ng-submit="postCommand(key_post, collab.colId)">
													<div class="form-group">
														<input ng-model="newcomment[key_post].comment" id="txtComment"  class="form-control input-sm" type="text" placeholder="Type a comment">
													</div>
												</form>
												
											</div>
											
											
											
											
											<!-- end content collab -->
										</div>

										<div class="tab-pane" id="note_tap">
											<div class="post clearfix">
												<form id="frmAddNote">
													<div class="form-group">
														<input ng-model="note_subject" data-ng-init="note_subject"
															style="margin-top: 10px;" type="text"
															class="form-control" name="note_subject"
															id="note_subject" placeholder="Subject">
													</div>
													<div class="form-group">
														<textarea ng-model="note_description"
															data-ng-init="note_description" style="margin-top: 10px;"
															rows="3" cols="" name="note_description"
															id="note_description" class="form-control"
															placeholder="Description"></textarea>
													</div>
													<button style="margin-top: 10px; margin-left: 10px;"
														ng-click="resetFrmNote()" type="button"
														ng-click="resetNote()" class="btn btn-danger pull-right">Reset</button>
													<button style="margin-top: 10px;" type="button"
														id="btnAddNote" ng-click="addNote()"
														class="btn btn-primary pull-right">Note</button>
												</form>
											</div>
											<div class="clearfix"></div>
											<ul class="timeline timeline-inverse"
												ng-repeat="notePerDate in noteToFilter() | filter:filterNote">

												<!-- START DATE -->
												<li class="time-label"><span class="bg-red">{{notePerDate.createDate}}</span>
												</li>
												<li ng-repeat="note in notes | filter:{createDate: notePerDate.createDate}">
													<i class="fa  fa-edit bg-blue"></i>
													<div class="timeline-item">
														<span class="time"><i class="fa fa-clock-o"></i>
															&nbsp;{{note.createTime}}</span>
														<h3 class="timeline-header">
															{{note.noteSubject}} <a>by {{note.noteCreateBy}}</a>
														</h3>
														<div class="timeline-body">{{note.noteDes}}</div>
														<div class="timeline-footer">
															<a href="#note" class="btn btn-primary btn-xs"
																ng-click="editNoteById(note.noteId)">Edit</a> <a
																class="btn btn-danger btn-xs"
																ng-click="deleteNoteById(note.noteId)">Delete</a>
														</div>
													</div>
												</li>


											</ul>
										</div>

										<div class="tab-pane " id="detail_tap">
											<div class="row">
												<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
													<form id="frmLeadDetail">
														<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
															<ul class="list-group list-group-unbordered">
																<li class="list-group-item" style="border-top: 0px;"><b>Overview</b> <!-- <a
																	class="pull-right cusor_pointer"
																	ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																		Edit</a> --></li>
																
																<li class="list-group-item item_border">ID <a
																	class="pull-right show-text-detail">{{customer.custID}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Name <a
																	class="pull-right show-text-detail">{{customer.custName}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Tel 1 <a
																	class="pull-right show-text-detail">{{customer.custTel1}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_lastName"
																			id="lea_lastName" class="form-control"
																			value="{{lead.lastName}}"> -->
																	</div>
																</li>
																<li class="list-group-item item_border">Tel 2 <a
																	class="pull-right show-text-detail">{{customer.custTel2}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_title" id="lea_title"
																			class="form-control" value="{{lead.title}}"> -->
																	</div>
																</li>
																<li class="list-group-item item_border">Email <a
																	class="pull-right show-text-detail">{{customer.custEmail}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_title" id="lea_title"
																			class="form-control" value="{{lead.title}}"> -->
																	</div>
																</li>
																<li class="list-group-item item_border">Web Site <a taget="_blank" href="{{customer.custWebsite}}"
																	class="pull-right show-text-detail">{{customer.custWebsite}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_title" id="lea_title"
																			class="form-control" value="{{lead.title}}"> -->
																	</div>
																</li>
																<li class="list-group-item item_border">Fax<a
																	class="pull-right show-text-detail">{{customer.custFax}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_title" id="lea_title"
																			class="form-control" value="{{lead.title}}"> -->
																	</div>
																</li>
																
															</ul>
														</div>
														<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
															<ul class="list-group list-group-unbordered">
																<li class="list-group-item" style="border-top: 0px;"><b>Other</b> <!-- <a
																	class="pull-right cusor_pointer"
																	ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																		Edit</a> --></li>
																<li class="list-group-item item_border">Industry <a
																	class="pull-right show-text-detail">{{customer.industID.industName}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Type <a
																	class="pull-right show-text-detail">{{customer.accountTypeID.accountName}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_lastName"
																			id="lea_lastName" class="form-control"
																			value="{{lead.lastName}}"> -->
																	</div>
																</li>
																<li class="list-group-item item_border">Facebook<a
																	class="pull-right show-text-detail">{{customer.facebook}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_title" id="lea_title"
																			class="form-control" value="{{lead.title}}"> -->
																	</div>
																</li>
																<li class="list-group-item item_border">Line <a
																	class="pull-right show-text-detail">{{customer.line}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_title" id="lea_title"
																			class="form-control" value="{{lead.title}}"> -->
																	</div>
																</li>
																<li class="list-group-item item_border">WhatApp<a
																	class="pull-right show-text-detail">{{customer.whatApp}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_title" id="lea_title"
																			class="form-control" value="{{lead.title}}"> -->
																	</div>
																</li>
																<li class="list-group-item item_border">Viber<a
																	class="pull-right show-text-detail">{{customer.viber}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_title" id="lea_title"
																			class="form-control" value="{{lead.title}}"> -->
																	</div>
																</li>
																
															</ul>
														</div>
														<div class="clearfix"></div>										
														<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
															<ul class="list-group list-group-unbordered">
																<li class="list-group-item" style="border-top: 0px;"><b>Setting</b> <!-- <a
																	class="pull-right cusor_pointer"
																	ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																		Edit</a> --></li>
																<li class="list-group-item item_border">Customer Group <a
																	class="pull-right show-text-detail">[{{customer.custGroup.custGroupId}}] {{customer.custGroup.custGroupName.trunc(10)}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_no" id="lea_no"
																			class="form-control" value="{{lead.no}}"> -->
																	</div>
																</li>
																<li class="list-group-item item_border">Price Code
																	<a class="pull-right show-text-detail">[{{customer.priceCode.priceCode}}] {{customer.priceCode.des}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_street" id="lea_street"
																			class="form-control" value="{{lead.street}}"> -->
																	</div>
																</li>
															</ul>
														</div>
														<div class="clearfix"></div>
														<div class="col-sm-12">
															<ul class="list-group list-group-unbordered">
																<li class="list-group-item" style="border-top: 0px;"><b>Address</b> <!-- <a
																	class="pull-right cusor_pointer"
																	ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																		Edit</a> -->
																</li>
																<li class="list-group-item item_border">Bill To Address</li>
																
																<li class="list-group-item item_border" ng-if="customer.custAddress != ''">													
																	<i class="fa fa-home"></i>
																	<a class="show-text-detail">{{customer.custAddress}}</a>
																	<div class="form-group show-edit" style="display: none;">
																		<!-- <input type="text" name="lea_firstName"
																			id="lea_firstName" class="form-control"
																			value="{{lead.firstName}}"> -->
																		<div class="clearfix"></div>
																	</div>
																</li>
																<li class="list-group-item item_border">Ship To Address</li>
																<li class="list-group-item item_border" ng-repeat="add in customer.shipAddresses">
																	<i class="fa fa-home"></i>
																	<a class="show-text-detail">[{{add.shipId}}] {{add.shipName}}</a>
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

										</div>
										
										<div class="tab-pane " id="related_tap">
											<div class="row">
												<div class="col-md-12" >
													<a href="${pageContext.request.contextPath}/create-opportunity/{{customer.custID}}"  style="margin-left: 0px;" class="btn btn-app"> 
														<i class="fa  fa-lightbulb-o"></i> Opportunity
													</a> 
													<a href="${pageContext.request.contextPath}/create-contact/{{customer.custID}}"  class="btn btn-app"> 
														<i class="fa fa-user"></i> Contact
													</a> 
													<a  href="${pageContext.request.contextPath}/create-case/{{customer.custID}}" class="btn btn-app"> 
														<i class="fa fa-briefcase "></i> Case
													</a> 
													<a href="${pageContext.request.contextPath}/quote/add/{{customer.custID}}" class="btn btn-app"> 
														<i class="fa fa-file-code-o"></i> Quotation
													</a> 
													<a href="${pageContext.request.contextPath}/sale-order/add/{{customer.custID}}" class="btn btn-app"> 
														<i class="fa fa-file-text-o"></i> Sale Order
													</a>
												</div>
												<div class="col-md-12">
													<div class="panel-group" id="relatedGroup">
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title pull-left">
																	<a data-toggle="collapse" data-parent="relatedGroup" href="#ROpportunity">Opportunities  </a>																	
																</h4>
																<span class="badge bg-blue pull-right">{{opportunity.length <= 0 ? '' : opportunity.length }}</span>
																<%-- <a href="${pageContext.request.contextPath}/create-opportunity" class="btn btn-default pull-right">New</a> --%>
																<div class="clearfix"></div>
															</div>
															<div id="ROpportunity" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages table-responsive">
																		<table class="table iTable"> 					
																			<thead>
																				<tr>
																					<th>ID</th>
																					<th>Name</th>
																					<th>Stage</th>
																					<th>Amount</th>
																					<th>Close Date</th>
																					<th  class="text-center">Action</th>
																				</tr>
																			</thead>
																			<tbody dir-paginate="opp in opportunity|itemsPerPage:5" pagination-id="oppId">
																				<tr>
																					<td><a href="${pageContext.request.contextPath}/view-opportunity/{{opp.opId}}">{{opp.opId}}</a></td>
																					<td>{{opp.opName}}</td>
																					<td>{{opp.stageName}}</td>
																					<td><span>$</span>{{opp.opAmount | number:2}}</td>
																					<td>{{opp.opCloseDate | date:'dd/MM/yyyy'}}</td>
																					<td class="text-center mailbox-date" style="min-width: 100px;">
																						<a href="${pageContext.request.contextPath}/update-opportunity/{{opp.opId}}"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
																						<a href="${pageContext.request.contextPath}/view-opportunity/{{opp.opId}}"><button type="button" data-toggle="tooltip" class="btn btn-xs" title="view"><i class="fa fa-eye text-info"></i></button></a>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																	<dir-pagination-controls pagination-id="oppId" max-size="5" direction-links="true" boundary-links="true"> </dir-pagination-controls>
																</div>
															</div>
														</div>
														
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title pull-left">
																	<a data-toggle="collapse" data-parent="relatedGroup" href="#RContact">Contacts  </a>																	
																</h4>
																<span class="badge bg-blue pull-right">{{contactList.length <= 0 ? '' : contactList.length }}</span>
																<%-- <a href="${pageContext.request.contextPath}/create-contact" class="btn btn-default pull-right">New</a> --%>
																<div class="clearfix"></div>
															</div>
															<div id="RContact" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages table-responsive">
																		<table class="table iTable"> 					
																			<thead>
																				<tr>
																					<th>ID</th>
																					<th>Name</th>
																					<th>Title</th>
																					<th>Department</th>
																					<th>Phone</th>
																					<th>Email</th>
																					<th class="text-center">Action</th>
																				</tr>
																			</thead>
																			<tbody dir-paginate="con in contactList|itemsPerPage:5" pagination-id="contactId">
																				<tr>
																					<td><a href="${pageContext.request.contextPath}/view-contact/{{con.conID}}">{{con.conID}}</a></td>
																					<td>{{con.fullName}}</td>
																					<td>{{con.conTitle}}</td>
																					<td>{{con.conDepartment}}</td>
																					<td>{{con.conPhone}}</td>
																					<td>{{con.conEmail}}</td>
																					<td class="text-center mailbox-date" style="min-width: 100px;">
																						<a href="${pageContext.request.contextPath}/update-contact/{{con.conID}}"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
																						<a href="${pageContext.request.contextPath}/view-contact/{{con.conID}}"><button type="button" data-toggle="tooltip" class="btn btn-xs" title="view"><i class="fa fa-eye text-info"></i></button></a>
																					</td>
																				</tr>
																			</tbody>	
																		</table>
																	</div>
																	<dir-pagination-controls pagination-id="contactId" max-size="5" direction-links="true" boundary-links="true"> </dir-pagination-controls>
																</div>
															</div>
														</div>
														
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title pull-left">
																	<a data-toggle="collapse" data-parent="relatedGroup" href="#RCase">Cases  </a>																	
																</h4>
																<%-- <a href="${pageContext.request.contextPath}/create-case" class="btn btn-default pull-right">New</a> --%>
																<span class="badge bg-blue pull-right">{{caseList.length <= 0 ? '' : caseList.length }}</span>
																<div class="clearfix"></div>
															</div>
															<div id="RCase" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages table-responsive">
																		<table class="table iTable"> 					
																			<thead>
																				<tr>
																					<th>ID</th>
																					<th>Subject</th>
																					<th>Status</th>
																					<th>Priority</th>
																					<th>Product</th>
																					<th>Date</th>
																					<th class="text-center">Action</th>
																				</tr>
																			</thead>
																			<tbody dir-paginate="case in caseList|itemsPerPage:5" pagination-id="caseId">
																				<tr>
																					<td><a href="${pageContext.request.contextPath}/view-case/{{case.caseId}}">{{case.caseId}}</a></td>
																					<td>{{case.subject.trunc(20)}}</td>
																					<td>{{case.statusName}}</td>
																					<td>{{case.priorityName}}</td>
																					<td>[{{case.itemId}}] {{case.itemName}}</td>
																					<td>{{case.createDate}}</td>
																					<td class="text-center mailbox-date" style="min-width: 100px;">
																						<a href="${pageContext.request.contextPath}/update-case/{{case.caseId}}"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
																						<a href="${pageContext.request.contextPath}/view-case/{{case.caseId}}"><button type="button" data-toggle="tooltip" class="btn btn-xs" title="view"><i class="fa fa-eye text-info"></i></button></a>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																	<dir-pagination-controls pagination-id="caseId" max-size="5" direction-links="true" boundary-links="true"> </dir-pagination-controls>
																</div>
															</div>
														</div>
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title pull-left">
																	<a data-toggle="collapse" data-parent="relatedGroup" href="#RQuote">Quotations  </a>																	
																</h4>
																<%-- <a href="${pageContext.request.contextPath}/create-case" class="btn btn-default pull-right">New</a> --%>
																<span class="badge bg-blue pull-right">{{quoteList.length <= 0 ? '' : quoteList.length }}</span>
																<div class="clearfix"></div>
															</div>
															<div id="RQuote" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages table-responsive">
																		<table class="table iTable"> 					
																			<thead>
																				<tr>
																					<th>ID</th>
																					<th>Employee</th>
																					<th>Total Amount</th>
																					<th>Net Total Amount</th>
																					<th>Post Status</th>
																					<th>Quote Date</th>
																					<th class="text-center">Action</th>
																				</tr>
																			</thead>
																			<tbody dir-paginate="q in quoteList|itemsPerPage:5" pagination-id="quoteId">
																				<tr>
																					<td><a href="${pageContext.request.contextPath}/quote/edit/{{q.saleId}}">{{q.saleId}}</a></td>
																					<td>[{{q.empId}}]{{q.empName}}</td>
																					<td><span>$</span>{{q.totalAmt}}</td>
																					<td><span>$</span>{{q.netTotalAmt}}</td>
																					<td>{{q.postStatus}}</td>
																					<td>{{q.saleDate}}</td>
																					<td class="text-center mailbox-date" style="min-width: 100px;">
																						<a href="${pageContext.request.contextPath}/quote/edit/{{q.saleId}}"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																	<dir-pagination-controls pagination-id="quoteId" max-size="5" direction-links="true" boundary-links="true"> </dir-pagination-controls>
																</div>
															</div>
														</div>
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title pull-left">
																	<a data-toggle="collapse" data-parent="relatedGroup" href="#RSaleOrder">Sale Orders  </a>																	
																</h4>
																<%-- <a href="${pageContext.request.contextPath}/create-case" class="btn btn-default pull-right">New</a> --%>
																<span class="badge bg-blue pull-right">{{saleOrderList.length <= 0 ? '' : saleOrderList.length }}</span>
																<div class="clearfix"></div>
															</div>
															<div id="RSaleOrder" class="panel-collapse collapse">
																<div class="panel-body">
																	<div class="mailbox-messages table-responsive">
																		<table class="table iTable"> 					
																			<thead>
																				<tr>
																					<th>ID</th>
																					<th>Employee</th>
																					<th>Total Amount</th>
																					<th>Net To talAmount</th>
																					<th>Post Status</th>
																					<th>Payment Status</th>
																					<th>Sale Date</th>
																					<th>Due Date</th>
																					<th class="text-center">Action</th>
																				</tr>
																			</thead>
																			<tbody dir-paginate="s in saleOrderList |itemsPerPage:5" pagination-id="saleId">
																				<tr>
																					<td><a href="${pageContext.request.contextPath}/sale-order/edit/{{s.saleId}}">{{s.saleId}}</a></td>
																					<td>[{{s.empId}}]{{s.empName}}</td>
																					<td><span>$</span>{{s.totalAmt}}</td>
																					<td><span>$</span>{{s.netTotalAmt}}</td>
																					<td>{{s.PostStatus}}</td>
																					<td>{{s.pmtStatus}}</td>
																					<td>{{s.saleDate}}</td>
																					<td>{{s.dueDate}}</td>
																					<td class="text-center mailbox-date" style="min-width: 100px;">
																						<a href="${pageContext.request.contextPath}/sale-order/edit/{{s.saleId}}"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
																					</td>
																				</tr>
																			</tbody>	
																		</table>
																	</div>
																	<dir-pagination-controls pagination-id="saleId" max-size="5" direction-links="true" boundary-links="true"> </dir-pagination-controls>
																</div>
															</div>
														</div>
													</div>
												</div>
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


	<input type="hidden" id="btn_show_call" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmCall" />
	<div ng-controller="callController" class="modal fade modal-default" id="frmCall" role="dialog">
		<div class="modal-dialog  modal-lg" data-ng-init="startupCallForm()">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelCallClick()" class="close"
						data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<b id="tCall">Create Call</b>
					</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form id="frmAddCall">
							<div class="col-md-12">
								<div class="col-md-12">
									<div class="form-group">
										<label>Subject <span class="requrie">(Required)</span></label>
										<input id="callSubject" name="callSubject"
											class="form-control" type="text" placeholder="">
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Start Date<span class="requrie">(Required)</span></label>
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input value="" name="callStartDate" id="callStartDate" readonly="readonly"
												type="text" class="form-control date pull-right active">
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="bootstrap-timepicker">
										<div class="form-group">
											<label>Duration <span class="requrie">(Required)</span></label>
											<div class="input-group">
												<div class="input-group-addon">
													<i class="fa fa-clock-o"></i>
												</div>
												<input type="text" class="form-control timepicker active" readonly="readonly"
													name="callDuration" id="callDuration" placeholder="hours:minutes">
											</div>
										</div>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Status <span class="requrie">(Required)</span></label>
										<select class="form-control select2" name="callStatus"
											id="callStatus" style="width: 100%;">
											<option value="">--SELECT A Status</option>
											<option ng-repeat="st in callStatusStartup"
												value="{{st.callStatusId}}">{{st.callStatusName}}</option>
										</select>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Assign To </label> <select class="form-control select2"
											name="callAssignTo" id="callAssignTo" style="width: 100%;">
											<option value="">--SELECT A Assign To</option>
										</select>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-12">
									<div class="form-group">
										<label>Description </label>
										<textarea rows="5" cols="" name="callDescription"
											id="callDescription" class="form-control"></textarea>
									</div>
								</div>
							</div>
						</form>
					</div>



				</div>
				<div class="modal-footer">
					<button type="button" id="btnCallCancel"
						ng-click="cancelCallClick()" name="btnCallCancel"
						class="btn btn-danger" data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" class="btn btn-primary pull-right"
						id="btnCallSave" name="btnCallSave">Save</button>

				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="btn_show_meet" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmMeet" />
	<div ng-controller="meetController"  class="modal fade modal-default" id="frmMeet" role="dialog">
		<div class="modal-dialog  modal-lg" data-ng-init="startupMeetForm()">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelMeetClick()" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"><b id="tMeet">Create Meeting</b></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form id="frmAddMeet">
						<div class="col-md-12">
							<div class="col-md-6">
								<div class="form-group">
									<label>Subject <span class="requrie">(Required)</span></label>
									<input id="meetSubject" name="meetSubject" class="form-control" type="text"
										placeholder="">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Start Date<span class="requrie">(Required)</span></label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input value="" name="meetStartDate" id="meetStartDate" readonly="readonly" type="text" class="form-control meet-data-time pull-right active" onchange="calculateMeetingDuration('meetStartDate','meetEndDate','meetDuration','frmAddMeet')">
									</div>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>End Date<span class="requrie">(Required)</span></label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input name="meetEndDate" id="meetEndDate" readonly="readonly" type="text" class="form-control meet-data-time pull-right active" onchange="calculateMeetingDuration('meetStartDate','meetEndDate','meetDuration','frmAddMeet')">
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Duration <span class="requrie">(Required)</span></label>
									<input type="text" class="form-control" name="meetDuration" id="meetDuration"/>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Assign To </label> 
									<select class="form-control select2" name="meetAssignTo" id="meetAssignTo" style="width: 100%;">
										<option value="">-- SELECT A Assign To --</option>
									</select>
								</div>
							</div>

							<div class="col-md-6">
								<div class="form-group">
									<label>Status</label> 
									<select class="form-control select2" name="meetStatus" id="meetStatus" style="width: 100%;">
										<option value="">-- SELECT A Status --</option>
										<option ng-repeat="st in meetStatusStartup" value="{{st.statusId}}">{{st.statusName}}</option>
									</select>
								</div>
							</div>

							<div class="clearfix"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Location </label> 
									<input id="meetLocation" name="meetLocation" class="form-control" type="text" placeholder="">
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Description </label>
									<textarea rows="4" cols="" name="meetDescription" id="meetDescription" class="form-control"></textarea>
								</div>
							</div>
						</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="btnMeetCancel" ng-click="cancelMeetClick()" name="btnMeetCancel" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" id="btnMeetSave" name="btnMeetSave" class="btn btn-primary pull-right">Save</button>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="btn_show_task" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmTask" />
	<div ng-controller="taskController" class="modal fade modal-default" id="frmTask" role="dialog">
		<div class="modal-dialog  modal-lg" data-ng-init="startupTaskForm()">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelTaskClick()" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"><b id="tTask">Create Task</b></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form id="frmAddTask">
						<div class="col-md-12">
							<div class="col-md-12">
								<div class="form-group">
									<label>Subject <span class="requrie">(Required)</span></label>
									<input id="taskSubject" name="taskSubject" class="form-control" type="text"
										placeholder="">
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Start Date</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input value="" name="taskStartDate" id="taskStartDate" type="text" readonly="readonly" class="form-control task-data-time pull-right active">
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Due Date</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input name="taskEndDate" id="taskEndDate" type="text" readonly="readonly" class="form-control task-data-time pull-right active">
									</div>
								</div>
							</div>
								
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Priority <span class="requrie">(Required)</span></label>
									<select class="form-control select2" id="taskPriority" name="taskPriority"  style="width: 100%;">
										<option value="">-- Select A Priority --</option>
										<option value="High">High</option>
										<option value="Medium">Medium</option>
										<option value="Low">Low</option>
									</select>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Status <span class="requrie">(Required)</span></label> 
									<select class="form-control select2" name="taskStatus" id="taskStatus" style="width: 100%;">
										<option value="">-- SELECT A Status --</option>
										<option ng-repeat="st in taskStatusStartup" value="{{st.taskStatusId}}">{{st.taskStatusName}}</option>
									</select>
								</div>
							</div>
							
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Assign To </label> 
									<select class="form-control select2" name="taskAssignTo" id="taskAssignTo" style="width: 100%;">
										<option value="">-- SELECT A Assign To --</option>
									</select>
								</div>
							</div>

							<div class="col-md-6">
								<div class="form-group">
									<label>Contact</label> 
									<select class="form-control select2" name="taskContact" id="taskContact" style="width: 100%;">
										<option value="">-- SELECT A Contact --</option>
										
									</select>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Description </label>
									<textarea rows="4" cols="" name="taskDescription" id="taskDescription"
										class="form-control"></textarea>
								</div>
							</div>
						</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="btnTaskCancel" ng-click="cancelTaskClick()" name="btnTaskCancel" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					 &nbsp;&nbsp;
					<button type="button" id="btnTaskSave" name="btnTaskSave" class="btn btn-primary pull-right" >Save</button>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="btn_show_event" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmEvent" />
	<div ng-controller="eventController" class="modal fade modal-default" id="frmEvent" role="dialog">
		<div class="modal-dialog  modal-lg" data-ng-init="startupEventForm()">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelEventClick()" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"><b id="tEvent">Create Event</b></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form id="frmAddEvent">
						<div class="col-md-12">
							<div class="col-md-12">
								<div class="form-group">
									<label>Subject <span class="requrie">(Required)</span></label>
									<input id="eventSubject" name="eventSubject" class="form-control" type="text" placeholder="">
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Start Date<span class="requrie">(Required)</span></label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input  name="eventStartDate" id="eventStartDate" type="text" readonly="readonly" class="form-control event-date-time pull-right active" onchange="calculateMeetingDuration('eventStartDate','eventEndDate','eventDuration','frmAddEvent')">
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>End Date<span class="requrie">(Required)</span></label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input name="eventEndDate" id="eventEndDate" readonly="readonly" type="text" class="form-control event-date-time pull-right active" onchange="calculateMeetingDuration('eventStartDate','eventEndDate','eventDuration','frmAddEvent')">
									</div>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-xs-12 col-sm-12 col-md-6">
								<div class="form-group">
									<label>Duration <span class="requrie">(Required)</span></label>
									<input type="text" class="form-control" name="eventDuration" id="eventDuration"/>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Assign To </label> 
									<select class="form-control select2" name="eventAssignTo" id="eventAssignTo" style="width: 100%;">
										<option value="">-- SELECT A Assign To --</option>
									</select>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Budget</label> 
									<input id="eventBudget" name="eventBudget" class="form-control" type="text" placeholder="">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Location </label> 
									<select class="form-control select2" name="eventLocation" id="eventLocation" style="width: 100%;">
										<option value="">-- SELECT A Location --</option>
										<option ng-repeat="loc in eventLocationStartup" value="{{loc.loId}}">{{loc.loName}}</option>
									</select>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Description </label>
									<textarea rows="4" cols="" name="eventDescription" id="eventDescription" class="form-control"></textarea>
								</div>
							</div>
						</div>
						</form>
					</div>



				</div>
				<div class="modal-footer">
					<button type="button" id="btnEventCancel" ng-click="cancelEventClick()" name="btnEventCancel" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" id="btnEventSave" name="btnEventSave"  class="btn btn-primary pull-right">Save</button>

				</div>
			</div>
		</div>
	</div>
	
	<div id="errors"></div>
</div>

<jsp:include page="${request.contextPath}/footer"></jsp:include>
<script src="${pageContext.request.contextPath}/resources/js.mine/customer/viewCustomer.js"></script>

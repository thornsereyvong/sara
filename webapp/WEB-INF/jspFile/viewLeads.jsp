<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>
<%
	String roleDelete = (String) request.getAttribute("role_delete");
%>


<script type="text/javascript">

var app = angular.module('viewLead', ['angularUtils.directives.dirPagination','oitozero.ngSweetAlert']);
var self = this;
var leadId = "${leadId}";
var username = "${SESSION}";
var lLead = "";
var server = "${pageContext.request.contextPath}";
var noteIdEdit = "";
var collabIdEdit = "";
var response=[];
var LEAD = [];
var callIdForEdit = null;
var meetIdForEdit = null;
var taskIdForEdit = null;
var eventIdForEdit = null;
var leadStatusData = ["New", "Assigned", "In Process", "Converted", "Dead"];
var startupCallForm = [];

var finStartupCollab = false;

app.controller('viewLeadController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	
	$scope.collaborates = [];
	$scope.tags = [];
	$scope.username = username; 
	angular.element(document).ready(function () {		
		$("#lea_salutation option[value='"+response.LEAD.salutation+"']").attr('selected','selected');
		$("#lea_status").select2('val',response.LEAD.statusID);
		$("#lea_source").select2('val',response.LEAD.sourceID);
		$("#lea_industry").select2('val',response.LEAD.industID);
		$("#lea_campaign").select2('val',response.LEAD.campID);
		$("#lea_assignto").select2('val',response.LEAD.assignToUserID);
    });
	
	$scope.listLeads = function(){
			response = getLeadData();					
			LEAD = response.LEAD;
			
			//dis(response);
			
			$scope.leadStatus = response.LEAD_STATUS;
			$scope.leadSource = response.LEAD_SOURCE;
			$scope.leadIndustry = response.INDUSTRY;
			$scope.leadAssignTo = response.ASSIGN_TO;
			$scope.leadCampaign = response.CAMPAIGN;
			$scope.lead = response.LEAD;
			$scope.listNote1(response.NOTES);
					
			userAllList($scope.leadAssignTo,'#callAssignTo','');
			userAllList($scope.leadAssignTo,'#meetAssignTo','');
			userAllList($scope.leadAssignTo,'#taskAssignTo','');
			userAllList($scope.leadAssignTo,'#eventAssignTo','');
			
			displayStatusLead(LEAD.statusID);
			
			
			$scope.listAllCallByLeadId(response.CALLS);	
			$scope.listAllMeetByLeadId(response.METTINGS);	
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
		    data: {"moduleId":leadId, "username":username}
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
		}).success(function(response) {	alert(status)
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
    	SweetAlert.swal({
            title: "Are you sure?",
            text: "This comment will not be able to recover!", 
            type: "warning",
            showCancelButton: true, 
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes, delete!",
            closeOnConfirm: false, 
            closeOnCancel: false
        }, 
        function(isConfirm){ 
        	  if(isConfirm){        		
        		  $http.delete("${pageContext.request.contextPath}/collaborate/comment/remove/"+comId).success(function(){
	        		  SweetAlert.swal({
	              		title:"Deleted",
	              		text:"The comment have been deleted!",
	              		type:"success",  
	              		timer: 2000,   
	              		showConfirmButton: false
      			  	  }); 	        		 
        		  });
        		  $scope.collaborates[keyParent].details.splice(keyChild, 1);
        	  }else{
        		  SweetAlert.swal({
  	                title:"Cancelled",
  	                text:"This comment is safe!",
  	                type:"error",
  	                timer:2000,
  	                showConfirmButton: false});
        	  }        	        	        	       		
        });
    }
    
	$scope.btnDeleteCollabPost = function(key,postId){
    	SweetAlert.swal({
            title: "Are you sure?",
            text: "This post will not be able to recover!", 
            type: "warning",
            showCancelButton: true, 
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes, delete!",
            closeOnConfirm: false, 
            closeOnCancel: false
        }, 
        function(isConfirm){      
        	 if(isConfirm){
	       		  $http.delete("${pageContext.request.contextPath}/collaborate/delete/"+postId).success(function(){
		        		  SweetAlert.swal({
		              		title:"Deleted",
		              		text:"The post have been deleted!",
		              		type:"success",  
		              		timer: 2000,   
		              		showConfirmButton: false
	     			  	  }); 
		        		  $scope.collaborates.splice(key, 1);
	       		  }); 
	       	  }else{
	       		  SweetAlert.swal({
	 	                title:"Cancelled",
	 	                text:"This post is safe!",
	 	                type:"error",
	 	                timer:2000,
	 	                showConfirmButton: false});
	       	  }         			
        });    	    	    	
    }	
	
	// End Collaborate***************************
	
	
	// Tab Note***************************
	
	
	$scope.addNote = function(){
		$('#frmAddNote').submit();
	}
	$scope.editNoteById = function(noteId){
		$scope.getNoteById(noteId); 
	}
	$scope.deleteNoteById = function(noteId){
		$scope.resetFrmNote();
		SweetAlert.swal({
            title: "Are you sure?", //Bold text
            text: "This note will not be able to recover!", //light text
            type: "warning", //type -- adds appropiriate icon
            showCancelButton: true, // displays cancel btton
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes, delete!",
            closeOnConfirm: false, //do not close popup after click on confirm, usefull when you want to display a subsequent popup
            closeOnCancel: false
        }, 
        function(isConfirm){ //Function that triggers on user action.
           
	            var str = 'YES';
	            
	            if(isConfirm){

					if(str == "YES"){
						$http.delete("${pageContext.request.contextPath}/note/remove/"+noteId)
			            .success(function(){
			            		SweetAlert.swal({
					            		title:"Deleted",
					            		text:"Note have been deleted!",
					            		type:"success",  
					            		timer: 2000,   
					            		showConfirmButton: false
			            		});
			            		$scope.getListNoteByLead();
					      });
					}else{
						SweetAlert.swal({
			                title:"Cancelled",
			                text:"You don't have permission delete!",
			                type:"error",
			                timer:2000,
			                showConfirmButton: false});
					}    
            } else {
                SweetAlert.swal({
	                title:"Cancelled",
	                text:"This note is safe!",
	                type:"error",
	                timer:2000,
	                showConfirmButton: false});
            }
        });
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
        var teamIsNew = indexedTeams.indexOf(note.noteCreateDate) == -1;
        if (teamIsNew) {
            indexedTeams.push(note.noteCreateDate);
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
		$http.get("${pageContext.request.contextPath}/note/list/lead/"+leadId).success(function(response){
			$scope.listNote1(response.NOTES);
		});
	};
    
	//End Tab Note***************************
	
	
	
	// lead
	
	
	$scope.editDetailLead = function(){
		$(".show-edit").show();
		$(".show-edit-non-style").show();
		
		$(".show-text-detail").hide();
		$("#showBtnEditLead").show();
		
		addDataToDetailLead();
	}
	$scope.saveEditDetailLead = function(){		
		$('#frmLeadDetail').submit();
	}
	$scope.cancelEditDetailLead = function(){
		$('#frmLeadDetail').bootstrapValidator('resetForm', true);
		$(".show-edit").hide();
		$(".show-edit-non-style").hide();
		$(".show-text-detail").show();
		$("#showBtnEditLead").hide();
	}
	
		
	
	
	
	//Tab Activity ***************************
	
	
	
	
    
	// Call path
	$scope.listAllCallByLeadId = function(data){
		$scope.listAllCallByLead = data;	
	}
	$scope.listDataCallByRalateType = function(){
		$http.get("${pageContext.request.contextPath}/call/list-by-lead/"+leadId).success(function(response){	
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
			$("#btn_show_call").click();
		});		
	}
	$scope.actDeleteCall = function(callId){				
		SweetAlert.swal({
            title: "Are you sure?", //Bold text
            text: "This call will not be able to recover!", //light text
            type: "warning", //type -- adds appropiriate icon
            showCancelButton: true, // displays cancel btton
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes, delete!",
            closeOnConfirm: false, //do not close popup after click on confirm, usefull when you want to display a subsequent popup
            closeOnCancel: false
        }, 
        function(isConfirm){ //Function that triggers on user action.
           
	            var str = '<%=roleDelete%>';
	        	
	            if(isConfirm){

	            	if(str == "YES"){
	            		 $http.delete("${pageContext.request.contextPath}/call/remove/"+callId)
	     	            .success(function(){
	     	            		SweetAlert.swal({
	     			            		title:"Deleted",
	     			            		text:"Call have been deleted!",
	     			            		type:"success",  
	     			            		timer: 2000,   
	     			            		showConfirmButton: false
	     	            		});
	     	            		
	     	            		$scope.listDataCallByRalateType();
	     		            });
					}else{
						SweetAlert.swal({
			                title:"Cancelled",
			                text:"You don't have permission delete!",
			                type:"error",
			                timer:2000,
			                showConfirmButton: false});
					} 
            } else {
                SweetAlert.swal({
	                title:"Cancelled",
	                text:"This call is safe!",
	                type:"error",
	                timer:2000,
	                showConfirmButton: false});
            }
        });
	}
	// end call path
	
	// meeting path
	
	$scope.listAllMeetByLeadId = function(data){
		$scope.listAllMeetByLead = data;	
	}
	
	$scope.listDataMeetByRalateType = function(){
		$http.get("${pageContext.request.contextPath}/meeting/list-by-lead/"+leadId).success(function(response){		
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
			$("#btn_show_meet").click();
		});		
	}
	$scope.actDeleteMeeting = function(meetingId){				
		SweetAlert.swal({
            title: "Are you sure?", //Bold text
            text: "This meeting will not be able to recover!", //light text
            type: "warning", //type -- adds appropiriate icon
            showCancelButton: true, // displays cancel btton
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes, delete!",
            closeOnConfirm: false, //do not close popup after click on confirm, usefull when you want to display a subsequent popup
            closeOnCancel: false
        }, 
        function(isConfirm){ //Function that triggers on user action.
           
	            var str = '<%=roleDelete%>';
	        	
	            if(isConfirm){

	            	if(str == "YES"){
	            		 $http.delete("${pageContext.request.contextPath}/meeting/remove/"+meetingId)
	     	            .success(function(){
	     	            		SweetAlert.swal({
	     			            		title:"Deleted",
	     			            		text:"Meeting have been deleted!",
	     			            		type:"success",  
	     			            		timer: 2000,   
	     			            		showConfirmButton: false
	     	            		});
	     	            		
	     	            		$scope.listDataMeetByRalateType();
	     		            });
					}else{
						SweetAlert.swal({
			                title:"Cancelled",
			                text:"You don't have permission delete!",
			                type:"error",
			                timer:2000,
			                showConfirmButton: false});
					} 
            } else {
                SweetAlert.swal({
	                title:"Cancelled",
	                text:"This meeting is safe!",
	                type:"error",
	                timer:2000,
	                showConfirmButton: false});
            }
        });
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
		$http.get("${pageContext.request.contextPath}/task/list-by-lead/"+leadId).success(function(response){		
			$scope.listAllTaskByLeadId(response.TASKS);	
		});	
	}
	$scope.actEditTask = function(taskId){				
		$http.get("${pageContext.request.contextPath}/task/list/"+taskId).success(function(response){			
			addDataTaskToForm(response.DATA);
			taskIdForEdit = taskId;
			$("#btnTaskSave").text("Update");
			$("#btn_show_task").click();
		});		
	}
	
	$scope.actDeleteTask = function(taskId){				
		SweetAlert.swal({
            title: "Are you sure?", //Bold text
            text: "This task will not be able to recover!", //light text
            type: "warning", //type -- adds appropiriate icon
            showCancelButton: true, // displays cancel btton
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes, delete!",
            closeOnConfirm: false, //do not close popup after click on confirm, usefull when you want to display a subsequent popup
            closeOnCancel: false
        }, 
        function(isConfirm){ //Function that triggers on user action.
           
	            var str = '<%=roleDelete%>';
	        	
	            if(isConfirm){

	            	if(str == "YES"){
	            		 $http.delete("${pageContext.request.contextPath}/task/remove/"+taskId)
	     	            .success(function(){
	     	            		SweetAlert.swal({
	     			            		title:"Deleted",
	     			            		text:"Task have been deleted!",
	     			            		type:"success",  
	     			            		timer: 2000,   
	     			            		showConfirmButton: false
	     	            		});
	     	            		
	     	            		$scope.listDataTaskByRalateType();
	     		            });
					}else{
						SweetAlert.swal({
			                title:"Cancelled",
			                text:"You don't have permission delete!",
			                type:"error",
			                timer:2000,
			                showConfirmButton: false});
					} 
            } else {
                SweetAlert.swal({
	                title:"Cancelled",
	                text:"This task is safe!",
	                type:"error",
	                timer:2000,
	                showConfirmButton: false});
            }
        });
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
		$http.get("${pageContext.request.contextPath}/event/list-by-lead/"+leadId).success(function(response){	
			$scope.listAllEventByLeadId(response.EVENTS);	
		});	
	}
	$scope.actEditEvent = function(eventId){				
		$http.get("${pageContext.request.contextPath}/event/list/"+eventId).success(function(response){			
			addDataEventToForm(response.DATA);
			eventIdForEdit = eventId;
			$("#btnEventSave").text("Update");
			$("#btn_show_event").click();
		});		
	}
	
	$scope.actDeleteEvent = function(eventId){				
		SweetAlert.swal({
            title: "Are you sure?", //Bold text
            text: "This event will not be able to recover!", //light text
            type: "warning", //type -- adds appropiriate icon
            showCancelButton: true, // displays cancel btton
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes, delete!",
            closeOnConfirm: false, //do not close popup after click on confirm, usefull when you want to display a subsequent popup
            closeOnCancel: false
        }, 
        function(isConfirm){ //Function that triggers on user action.
           
	            var str = '<%=roleDelete%>';
	        	
	            if(isConfirm){

	            	if(str == "YES"){
	            		 $http.delete("${pageContext.request.contextPath}/event/remove/"+eventId)
	     	            .success(function(){
	     	            		SweetAlert.swal({
	     			            		title:"Deleted",
	     			            		text:"Event have been deleted!",
	     			            		type:"success",  
	     			            		timer: 2000,   
	     			            		showConfirmButton: false
	     	            		});
	     	            		
	     	            		$scope.listDataEventByRalateType();
	     		            });
					}else{
						SweetAlert.swal({
			                title:"Cancelled",
			                text:"You don't have permission delete!",
			                type:"error",
			                timer:2000,
			                showConfirmButton: false});
					} 
            } else {
                SweetAlert.swal({
	                title:"Cancelled",
	                text:"This event is safe!",
	                type:"error",
	                timer:2000,
	                showConfirmButton: false});
            }
        });
	}
	
	
	
	// end event path
	
	
	
	
	$scope.email_click = function(){
		$("#btn_show_email").click();
	}
	
	
	
	
	//End Tab Activity ***************************
	
	
	
}]);


app.controller('callController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	$scope.startupCallForm = function(){
		/* $http.get("${pageContext.request.contextPath}/call_status/list")
			.success(function(response){
				$scope.callStatusStartup = response.DATA;
	    }); */
	}
	$scope.cancelCallClick = function(){
		callIdForEdit = null;
		$("#callStatus").select2('val',"");
		$("#callAssignTo").select2('val',"");	
		$("#btnCallSave").text("Save");
		$('#frmAddCall').bootstrapValidator('resetForm', true);
	}	
}]);



app.controller('meetController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	$scope.startupMeetForm = function(){
		/* $http.get("${pageContext.request.contextPath}/meeting_status/list").success(function(response){
			$scope.meetStatusStartup = response.DATA;
	    }); */
	}
	$scope.cancelMeetClick = function(){
		 meetIdForEdit = null;
		$("#meetDuration").select2('val',"");
		$("#meetStatus").select2('val',"");
		$("#meetAssignTo").select2('val',"");	
		$("#btnMeetSave").text("Save");
		$('#frmAddMeet').bootstrapValidator('resetForm', true);
	}	
}]);

app.controller('taskController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	
	$scope.startupTaskForm = function(){
		/* $http.get("${pageContext.request.contextPath}/task_status/list").success(function(response){
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
		$('#frmAddTask').bootstrapValidator('resetForm', true);
	}	
}]);

app.controller('eventController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	
	$scope.startupEventForm = function(){
		/* $http.get("${pageContext.request.contextPath}/event_location/list").success(function(response){
			$scope.eventLocationStartup = response.DATA;
		}); */
	}
	
	$scope.cancelEventClick = function(){
		eventIdForEdit = null;
		$("#eventDuration").select2('val',"");
		$("#eventLocation").select2('val',"");
		$("#eventAssignTo").select2('val',"");	
		$("#btnEventSave").text("Save");
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
			method: 'POST',
		    url: '${pageContext.request.contextPath}/lead/view',
		    async: false,
		    headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    },
		    data: JSON.stringify({
		    	"username":username,
		    	"leadId":leadId
		    })
		}).responseText);	
	return data;	
}

function getLeadById(){
	var data = JSON.parse(
		$.ajax({
			method: 'GET',
		    url: '${pageContext.request.contextPath}/lead/list/'+leadId,
		    async: false
		}).responseText);	
	return data;
}

function clickStatus(num){
	if(num == 4){
		window.location.href = server+"/convert-lead/"+leadId;
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
	
	$("#lea_salutation option[value='"+LEAD.salutation+"']").attr('selected','selected');
	$("#lea_status").select2('val',LEAD.statusID);
	$("#lea_source").select2('val',LEAD.sourceID);
	$("#lea_industry").select2('val',LEAD.industID);
	$("#lea_campaign").select2('val',LEAD.campID);
	$("#lea_assignto").select2('val',LEAD.assignToUserID);
	
	
	setValueById('lea_firstName', LEAD.firstName);
	setValueById('lea_lastName', LEAD.lastName);
	setValueById('lea_title', LEAD.title);
	setValueById('lea_department', LEAD.department);
	setValueById('lea_phone', LEAD.phone);
	setValueById('lea_mobilePhone', LEAD.mobile);
	setValueById('lea_website', LEAD.website);
	setValueById('lea_accountName', LEAD.accountName);
	setValueById('lea_email', LEAD.email);
	
	setValueById('lea_no', LEAD.no);
	setValueById('lea_street', LEAD.street);
	setValueById('lea_village', LEAD.village);
	setValueById('lea_commune', LEAD.commune);
	setValueById('lea_district', LEAD.district);
	setValueById('lea_city', LEAD.city);
	setValueById('lea_state', LEAD.state);
	setValueById('lea_country', LEAD.country);
	setValueById('lea_description', LEAD.description);
	
	
	
}

</script>
<style>

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
<div class="content-wrapper" id="viewLeadController" ng-app="viewLead"
	ng-controller="viewLeadController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>View Lead</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>View Lead</a></li>
		</ol>
	</section>

	<section class="content" data-ng-init="listLeads()">


		<div class="row">

			<div class="col-md-12">
				<!-- Widget: user widget style 1 -->
				<div class="box box-widget widget-user">
					<!-- Add the bg color to the header using any of the bg-* classes -->
					<div class="widget-user-header bg-aqua-active">
						<h3 class="widget-user-username ng-cloak">{{lead.salutation}}
							{{lead.firstName}} {{lead.lastName}}</h3>
						<h5 class="widget-user-desc ng-cloak">{{lead.title}}</h5>
					</div>
					<div class="widget-user-image">
						<img class="img-circle"
							src="${pageContext.request.contextPath}/resources/images/module/AV.png"
							alt="User Avatar">
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="col-sm-3">
								<div class="description-block">
									<h5 class="description-header ng-cloak">{{lead.accountName}}</h5>
									<span class="description-text">Company</span>
								</div>
							</div>
							<div class="col-sm-3 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak">{{lead.sourceName}}</h5>
									<span class="description-text">Lead Source</span>
								</div>
							</div>
							<div class="col-sm-3 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak">{{lead.assignToUsername}}</h5>
									<span class="description-text">Assign To</span>
								</div>
							</div>
							<div class="col-sm-3 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak">{{lead.phone}}</h5>
									<span class="description-text">Tel</span>
								</div>
							</div>

							<div class="col-sm-12">
								<ul class="breadcrumb1" id="objStatus">
								</ul>
							</div>

							<div class="clearfix"></div>
							<br />
							<div class="col-md-12">
								<div class="nav-tabs-custom">
									<ul class="nav nav-tabs">
										<li class="active"><a href="#activity" data-toggle="tab"
											aria-expanded="true">ACTIVITY</a></li>
										<li class=""><a href="#collaborate" data-toggle="tab"
											aria-expanded="false">COLLABORATE</a></li>
										<li class=""><a href="#note_tap" data-toggle="tab"
											aria-expanded="false">NOTES</a></li>
										<li class=""><a href="#detail_tap" data-toggle="tab"
											aria-expanded="false">DETAILS</a></li>
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
																	<div class="mailbox-messages">
																			<table class="table iTable"> 					
																				<thead>
																					<tr>
																						<th>#</th>
																						<th colspan="2">Subject</th>
																						<th>Start Date</th>
																						<th>Duration</th>
																						<th>Assign To</th>
																						<th>Create By</th>
																					</tr>
																				</thead>
																				<tbody ng-repeat="call in listAllCallByLead">
																					<tr>
																						<td class="iTD-width-50">
																							<a href="#">
																								<i class="fa fa-phone text-yellow font-size-icon-30"></i>
																							</a>
																						</td>
																						<td colspan="2">{{call.callSubject}}</td>
																						<td> 
																							{{call.callStartDate | date:'dd/MM/yyyy'}}
																						</td>
																						<td>{{call.callDuration}}</td>
																						<td>{{call.username}}</td>
																						<td>{{call.callCreateBy}}</td>
																					</tr>
																					<tr>
																						<td colspan="6">
																							<a href="#">{{call.callDes | limitTo:200}}{{call.callDes.length <= 200 ? '' : '...'}}</a>
																						</td>
																						<td class="mailbox-date">
																							<div class="col-sm-2">
																								<div class="btn-group">
																									<button type="button"
																										class="btn btn-default dropdown-toggle"
																										data-toggle="dropdown" aria-expanded="false">
																										<span class="caret"></span> <span class="sr-only">Toggle
																											Dropdown</span>
																									</button>
																									<ul class="dropdown-menu" role="menu">
																										<li><a href="#" ng-click="actEditCall(call.callId)">
																												<i class="fa fa-pencil"></i> Edit
																										</a></li>
																										<li ng-click="actDeleteCall(call.callId)"><a
																											href="#"><i class="fa fa-trash"></i> Delete</a></li>
																										<li><a href="${pageContext.request.contextPath}/view-call/{{call.callId}}"><i class="fa fa-eye"></i> View</a></li>
					
																									</ul>
																								</div>
																							</div>
																						</td>
																					</tr>
																			</table>
																		</div>
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
																	<div class="mailbox-messages">
																		<table class="table iTable"> 
																			<thead>
																				<tr>
																					<th>#</th>
																					<th colspan="2">Subject</th>
																					<th>Status</th>
																					<th>Start Date</th>
																					<th>End Date</th>
																					<th>Assign To</th>
																					<th>Create By</th>
																				</tr>
																			</thead>
																			<tbody ng-repeat="meet in listAllMeetByLead">
																				<tr>
																					<td class="iTD-width-50">
																						<a href="#"><i class="fa fa-users text-aqua font-size-icon-30"></i></a>
																					</td>
																					<td colspan="2">{{meet.meetingSubject}}</td>
																					<td>{{meet.statusName}}</td>
																					<td>{{meet.meetingStartDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{meet.meetingEndDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{meet.username}}</td>
																					<td>{{meet.meetingCreateBy}}</td>
																				</tr>
																				<tr>
																					<td colspan="7">
																						<a href="#">{{meet.meetingDes | limitTo:200}}{{meet.meetingDes.length <= 200 ? '' : '...'}}</a>
																					</td>
																					<td class="mailbox-date">
																						<div class="col-sm-2">
																							<div class="btn-group">
																								<button type="button"
																									class="btn btn-default dropdown-toggle"
																									data-toggle="dropdown" aria-expanded="false">
																									<span class="caret"></span> <span class="sr-only">Toggle
																										Dropdown</span>
																								</button>
																								<ul class="dropdown-menu" role="menu">
																									<li ng-click="actEditMeeting(meet.meetingId)">
																										<a href="#"><i class="fa fa-pencil"></i> Edit</a>
																									</li>
																									<li ng-click="actDeleteMeeting(meet.meetingId)">
																										<a href="#"><i class="fa fa-trash"></i> Delete</a></li>
																									<li><a href="${pageContext.request.contextPath}/view-meeting/{{meet.meetingId}}"><i class="fa fa-eye"></i> View</a></li>
				
																								</ul>
																							</div>
																						</div>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>																
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
																	<div class="mailbox-messages">
																		<table class="table iTable"> 
																			<thead>
																				<tr>
																					<th>#</th>
																					<th colspan="2">Subject</th>
																					<th>Status</th>
																					<th>Start Date</th>
																					<th>End Date</th>
																					<th>Assign To</th>
																					<th>Create By</th>
																				</tr>
																			</thead>
																			<tbody ng-repeat="task in listAllTaskByLead">
																				<tr>
																					<td class="iTD-width-50">
																						<a href="#"><i class="fa fa-list-alt text-blue font-size-icon-30"></i></a>
																					</td>
																					<td colspan="2">{{task.taskSubject}}</td>
																					<td>{{task.taskStatusName}}</td>
																					<td>{{task.taskStartDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{task.taskDueDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{task.username}}</td>
																					<td>{{task.taskCreateBy}}</td>
																				</tr>
																				<tr>
																					<td colspan="7">
																						<a href="#">{{task.taskDes | limitTo:200}}{{task.taskDes.length <= 200 ? '' : '...'}}</a>
																					</td>
																					<td class="mailbox-date">
																						<div class="col-sm-2">
																							<div class="btn-group">
																								<button type="button"
																									class="btn btn-default dropdown-toggle"
																									data-toggle="dropdown" aria-expanded="false">
																									<span class="caret"></span> <span class="sr-only">Toggle
																										Dropdown</span>
																								</button>
																								<ul class="dropdown-menu" role="menu">
																									<li ng-click="actEditTask(task.taskId)">
																										<a href="#"><i class="fa fa-pencil"></i> Edit</a>
																									</li>
																									<li ng-click="actDeleteTask(task.taskId)">
																										<a href="#"><i class="fa fa-trash"></i> Delete</a></li>
																									<li><a href="${pageContext.request.contextPath}/view-task/{{task.taskId}}"><i class="fa fa-eye"></i> View</a></li>
				
																								</ul>
																							</div>
																						</div>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
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
																	<div class="mailbox-messages">
																		<table class="table iTable"> 
																			<thead>
																				<tr>
																					<th>#</th>
																					<th colspan="2">Name</th>
																					<th>Location</th>
																					<th>Start Date</th>
																					<th>End Date</th>
																					<th>Assign To</th>
																					<th>Create By</th>
																				</tr>
																			</thead>
																			<tbody ng-repeat="event in listAllEventByLead">
																				<tr>
																					<td class="iTD-width-50">
																						<a href="#"><i class="fa  fa-calendar-check-o text-red font-size-icon-30"></i></a>
																					</td>
																					<td colspan="2">{{event.evName}}</td>
																					<td>{{event.locateName}}</td>
																					<td>{{event.evStartDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{event.evEndDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{event.username}}</td>
																					<td>{{event.evCreateBy}}</td>
																				</tr>
																				<tr>
																					<td colspan="7">
																						<a href="#">{{event.evDes | limitTo:200}}{{event.evDes.length <= 200 ? '' : '...'}}</a>
																					</td>
																					<td class="mailbox-date">
																						<div class="col-sm-2">
																							<div class="btn-group">
																								<button type="button"
																									class="btn btn-default dropdown-toggle"
																									data-toggle="dropdown" aria-expanded="false">
																									<span class="caret"></span> <span class="sr-only">Toggle
																										Dropdown</span>
																								</button>
																								<ul class="dropdown-menu" role="menu">
																									<li ng-click="actEditEvent(event.evId)">
																										<a href="#"><i class="fa fa-pencil"></i> Edit</a>
																									</li>
																									<li ng-click="actDeleteEvent(event.evId)">
																										<a href="#"><i class="fa fa-trash"></i> Delete</a></li>
																									<li><a href="${pageContext.request.contextPath}/view-event/{{event.evId}}"><i class="fa fa-eye"></i> View</a></li>
				
																								</ul>
																							</div>
																						</div>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
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
																	<div class="mailbox-messages">
																		<table class="table iTable" data-ng-init="listAllEmailByLeadId()"> 
																			<thead>
																				<tr>
																					<th>#</th>
																					<th colspan="2">Subject</th>
																					<th>Sent To</th>
																					<th>Date</th>
																					<th>Status</th>
																					<th>Assign To</th>
																					<th>Create By</th>
																				</tr>
																			</thead>
																			<tbody ng-repeat="email in listAllEmailByLead">
																				<tr>
																					<td class="iTD-width-50">
																						<a href="#"><i class="fa fa-envelope text-green font-size-icon-30"></i></a>
																					</td>
																					<td colspan="2">{{event.evName}}</td>
																					<td>{{event.locateName}}</td>
																					<td>{{event.evStartDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{event.evEndDate | date:'dd/MM/yyyy'}}</td>
																					<td>{{event.username}}</td>
																					<td>{{event.evCreateBy}}</td>
																				</tr>
																				<tr>
																					<td colspan="7">
																						<a href="#">{{event.evDes | limitTo:200}}{{event.evDes.length <= 200 ? '' : '...'}}</a>
																					</td>
																					<td class="mailbox-date">
																						<div class="col-sm-2">
																							<div class="btn-group">
																								<button type="button"
																									class="btn btn-default dropdown-toggle"
																									data-toggle="dropdown" aria-expanded="false">
																									<span class="caret"></span> <span class="sr-only">Toggle
																										Dropdown</span>
																								</button>
																								<ul class="dropdown-menu" role="menu">
																									<li ng-click="actEditEvent(event.evId)">
																										<a href="#"><i class="fa fa-pencil"></i> Edit</a>
																									</li>
																									<li ng-click="actDeleteEvent(event.evId)">
																										<a href="#"><i class="fa fa-trash"></i> Delete</a></li>
																									<li><a href="${pageContext.request.contextPath}/view-event/{{event.evId}}"><i class="fa fa-eye"></i> View</a></li>
				
																								</ul>
																							</div>
																						</div>
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

										<div class="tab-pane" id="collaborate" data-ng-init="listCollab()">

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
													<button style="margin-top: 10px; margin-left: 10px;" ng-click="resetFrmNote()" type="button" class="btn btn-danger pull-right">Reset</button>
													<button style="margin-top: 10px;" type="button" id="btnAddNote" ng-click="addNote()" class="btn btn-primary pull-right">Note</button>
												</form>
											</div>
											<div class="clearfix"></div>
											<ul class="timeline timeline-inverse"
												ng-repeat="notePerDate in noteToFilter() | filter:filterNote">

												<!-- START DATE -->
												<li class="time-label"><span class="bg-red">{{notePerDate.noteCreateDate}}</span>
												</li>
												<li
													ng-repeat="note in notes | filter:{noteCreateDate: notePerDate.noteCreateDate}">
													<i class="fa  fa-edit bg-blue"></i>
													<div class="timeline-item">
														<span class="time"><i class="fa fa-clock-o"></i>
															&nbsp;{{notePerDate.noteTime}}</span>
														<h3 class="timeline-header">
															{{note.noteSubject}} <a style="font-size: 12px;">by {{note.noteCreateBy}}</a>
														</h3>
														<div class="timeline-body">{{note.noteDes}}</div>
														<div class="timeline-footer">
															<a class="btn btn-primary btn-xs"
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
												<form id="frmLeadDetail">
													<div class="col-md-4">
														<ul class="list-group list-group-unbordered">
															<li class="list-group-item"><b>Overview</b> <a
																class="pull-right cusor_pointer"
																ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																	Edit</a></li>
															<li class="list-group-item item_border">Salutation <a
																class="pull-right show-text-detail">{{lead.salutation}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<select class="form-control" name="lea_salutation"
																		id="lea_salutation">
																		<option value="Mr.">Mr.</option>
																		<option value="Ms.">Ms.</option>
																		<option value="Mrs.">Mrs.</option>
																		<option value="Dr.">Dr.</option>
																		<option value="Prof.">Prof.</option>
																	</select>
																</div>
															</li>

															<li class="list-group-item item_border">First Name <a
																class="pull-right show-text-detail">{{lead.firstName}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_firstName"
																		id="lea_firstName" class="form-control"
																		value="{{lead.firstName}}">
																	<div class="clearfix"></div>
																</div>
															</li>
															<li class="list-group-item item_border">Last Name <a
																class="pull-right show-text-detail">{{lead.lastName}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_lastName"
																		id="lea_lastName" class="form-control"
																		value="{{lead.lastName}}">
																</div>
															</li>
															<li class="list-group-item item_border">Title <a
																class="pull-right show-text-detail">{{lead.title}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_title" id="lea_title"
																		class="form-control" value="{{lead.title}}">
																</div>
															</li>
															<li class="list-group-item item_border">Department <a
																class="pull-right show-text-detail">{{lead.department}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_department"
																		id="lea_department" class="form-control"
																		value="{{lead.department}}">
																</div>
															</li>
															<li class="list-group-item item_border">Company <a
																class="pull-right show-text-detail">{{lead.accountName}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_accountName"
																		id="lea_accountName" class="form-control"
																		value="{{lead.accountName}}">
																</div>
															</li>
															<li class="list-group-item item_border">Phone <a
																class="pull-right show-text-detail">{{lead.phone}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_phone" id="lea_phone"
																		class="form-control" value="{{lead.phone}}">
																</div>
															</li>
															<li class="list-group-item item_border">Mobile <a
																class="pull-right show-text-detail">{{lead.mobile}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_mobilePhone"
																		id="lea_mobilePhone" class="form-control"
																		value="{{lead.mobile}}">
																</div>
															</li>
															<li class="list-group-item item_border">Web Site <a
																class="pull-right show-text-detail">{{lead.website}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_website" id="lea_website"
																		class="form-control" value="{{lead.website}}">
																</div>
															</li>
															<li class="list-group-item item_border">Email <a
																class="pull-right show-text-detail">{{lead.email}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_email" id="lea_email"
																		class="form-control" value="{{lead.email}}">
																</div>
															</li>
														</ul>
													</div>
													<div class="col-md-4">
														<ul class="list-group list-group-unbordered">
															<li class="list-group-item"><b>Address</b> <a
																class="pull-right cusor_pointer"
																ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																	Edit</a></li>
															<li class="list-group-item item_border">No <a
																class="pull-right show-text-detail">{{lead.no}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_no" id="lea_no"
																		class="form-control" value="{{lead.no}}">
																</div>
															</li>
															<li class="list-group-item item_border">Street <a
																class="pull-right show-text-detail">{{lead.street}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_street" id="lea_street"
																		class="form-control" value="{{lead.street}}">
																</div>
															</li>
															<li class="list-group-item item_border">Village <a
																class="pull-right show-text-detail">{{lead.village}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_village" id="lea_village"
																		class="form-control" value="{{lead.village}}">
																</div>
															</li>
															<li class="list-group-item item_border">Commune <a
																class="pull-right show-text-detail">{{lead.commune}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_commune" id="lea_commune"
																		class="form-control" value="{{lead.commune}}">
																</div>
															</li>
															<li class="list-group-item item_border">District <a
																class="pull-right show-text-detail">{{lead.district}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_district"
																		id="lea_district" class="form-control"
																		value="{{lead.district}}">
																</div>
															</li>
															<li class="list-group-item item_border">City <a
																class="pull-right show-text-detail">{{lead.city}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_city" id="lea_city"
																		class="form-control" value="{{lead.city}}">
																</div>
															</li>
															<li class="list-group-item item_border">State <a
																class="pull-right show-text-detail">{{lead.state}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_state" id="lea_state"
																		class="form-control" value="{{lead.state}}">
																</div>
															</li>
															<li class="list-group-item item_border">Country <a
																class="pull-right show-text-detail">{{lead.country}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<input type="text" name="lea_country" id="lea_country"
																		class="form-control" value="{{lead.country}}">
																</div>
															</li>
														</ul>
													</div>
													<div class="col-md-4">
														<ul class="list-group list-group-unbordered">
															<li class="list-group-item"><b>More Information
																	& Others</b> <a class="pull-right cusor_pointer"
																ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																	Edit</a></li>
															<li class="list-group-item item_border">Status <a
																class="pull-right show-text-detail">{{lead.statusName}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<select class="form-control select2" name="lea_status"
																		id="lea_status" style="width: 100%;">
																		<option value="">-- SELECT Status --</option>
																		<option ng-repeat="status in leadStatus"
																			value="{{status.statusID}}">{{status.statusName}}</option>
																	</select>
																</div>
															</li>
															<li class="list-group-item item_border">Industry <a
																class="pull-right show-text-detail">{{lead.industName}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<select class="form-control select2"
																		name="lea_industry" id="lea_industry"
																		style="width: 100%;">
																		<option value="">-- SELECT Industry --</option>
																		<option ng-repeat="industry in leadIndustry"
																			value="{{industry.industID}}">{{industry.industName}}</option>
																	</select>
																</div>
															</li>
															<li class="list-group-item item_border">Source <a
																class="pull-right show-text-detail">{{lead.industName}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<select class="form-control select2" name="lea_source"
																		id="lea_source" style="width: 100%;">
																		<option value="">-- SELECT Source --</option>
																		<option ng-repeat="source in leadSource"
																			value="{{source.sourceID}}">{{source.sourceName}}</option>
																	</select>
																</div>
															</li>
															<li class="list-group-item item_border">Campaign <a
																class="pull-right show-text-detail">{{lead.campName}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<select class="form-control select2"
																		name="lea_campaign" id="lea_campaign"
																		style="width: 100%;">
																		<option value="">-- SELECT Campaign --</option>
																		<option ng-repeat="camp in leadCampaign"
																			value="{{camp.campID}}">{{camp.campName}}</option>
																	</select>
																</div>
															</li>
															<li class="list-group-item item_border">Assign To <a
																class="pull-right show-text-detail">{{lead.assignToUsername}}</a>
																<div class="form-group show-edit" style="display: none;">
																	<select class="form-control select2"
																		name="lea_assignto" id="lea_assignto"
																		style="width: 100%;">
																		<option value="">-- SELECT Assign To --</option>
																		<option ng-repeat="user in leadAssignTo"
																			value="{{user.userID}}">{{user.username}}</option>
																	</select>
																</div>

															</li>
														</ul>
													</div>
													<div class="col-md-12">
														<ul class="list-group list-group-unbordered">
															<li style="border-top: 0px;" class="list-group-item"><b>Description</b>
																<a class="pull-right cusor_pointer"
																ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																	Edit</a></li>
														</ul>
													</div>
													<div class="col-md-12">
														<div class="show-text-detail">{{lead.description}}</div>
														<div class="form-group show-edit-non-style"
															style="display: none;">
															<textarea rows="3" cols="" name="lea_description"
																id="lea_description" class="form-control"
																placeholder="Description">{{lead.description}}</textarea>
														</div>
													</div>
													<br>
													<div class="col-md-12 text-center" id="showBtnEditLead"
														style="display: none;">
														<button type="button" class="btn btn-primary"
															ng-click="saveEditDetailLead()">Save</button>
														<button type="button" class="btn btn-danger"
															ng-click="cancelEditDetailLead()">Cancel</button>
													</div>
												</form>

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
											<input value="" name="callStartDate" id="callStartDate"
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
												<input type="text" class="form-control timepicker active"
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
									<label>Duration <span class="requrie">(Required)</span></label>
									<select class="form-control select2" name="meetDuration"
										id="meetDuration" style="width: 100%;">
										<option value="">-- Select A Duration --</option>
										<option value="15 minutes">15 minutes</option>
										<option value="30 minutes">30 minutes</option>
										<option value="45 minutes">45 minutes</option>
										<option value="1 hour">1 hour</option>
										<option value="1:30 hours">1:30 hours</option>
										<option value="2 hours">2 hours</option>
										<option value="3 hours">3 hours</option>
										<option value="6 hours">6 hours</option>
										<option value="1 day">1 day</option>
										<option value="2 days">2 days</option>
										<option value="3 days">3 days</option>
										<option value="1 week">1 week</option>
									</select>
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
										<input value="" name="meetStartDate" id="meetStartDate" type="text" class="form-control meet-data-time pull-right active">
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
										<input name="meetEndDate" id="meetEndDate" type="text" class="form-control meet-data-time pull-right active">
									</div>
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
										<input value="" name="taskStartDate" id="taskStartDate" type="text" class="form-control task-data-time pull-right active">
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
										<input name="taskEndDate" id="taskEndDate" type="text" class="form-control task-data-time pull-right active">
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
										<option ng-repeat="st in taskContactStartup" value="{{st.conID}}">{{st.conSalutation}}{{st.conFirstname}} {{st.conLastname}}</option>
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
										<input  name="eventStartDate" id="eventStartDate" type="text" class="form-control event-date-time pull-right active">
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
										<input name="eventEndDate" id="eventEndDate" type="text" class="form-control event-date-time pull-right active">
									</div>
								</div>
							</div>

							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Duration <span class="requrie">(Required)</span></label>
									<select class="form-control select2" name="eventDuration" id="eventDuration" style="width: 100%;">
										<option value="">-- SELECT A Duration --</option>
										<option value="15 minutes">15 minutes</option>
										<option value="30 minutes">30 minutes</option>
										<option value="45 minutes">45 minutes</option>
										<option value="1 hour">1 hour</option>
										<option value="1:30 hours">1:30 hours</option>
										<option value="2 hours">2 hours</option>
										<option value="3 hours">3 hours</option>
										<option value="6 hours">6 hours</option>
										<option value="1 day">1 day</option>
										<option value="2 days">2 days</option>
										<option value="3 days">3 days</option>
										<option value="1 week">1 week</option>
									</select>
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
<script src="${pageContext.request.contextPath}/resources/js.mine/lead/viewLead.js"></script>

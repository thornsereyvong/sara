
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

var app = angular.module('viewOpportunity', ['angularUtils.directives.dirPagination', 'angular-loading-bar', 'ngAnimate']).config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
var self = this;

var username = "${SESSION}";
var server = "${pageContext.request.contextPath}";

var leadId = "";

var lLead = "";

var oppId = "${caseId}";
var lOpportunity = "";




var typeModule = "Case";
var noteIdEdit = "";
var response=[];
var LEAD = [];
var OPPORTUNITY = [];

var callIdForEdit = null;
var meetIdForEdit = null;
var taskIdForEdit = null;
var eventIdForEdit = null;

var leadStatusData = ["Prospecting", "Qualification", "Analysis", "Proposal", "Negotiation","Close"];
var var_ResolvedBy = "";
var var_ResolveSolution = "";
app.controller('viewOpportunityController',['$scope','$http',function($scope, $http){
	
	angular.element(document).ready(function () {				
		/* $("#oppStage").select2('val',response.OPPORTUNITY.osId);
		$("#oppType").select2('val',response.OPPORTUNITY.otId);
		$("#oppLeadSource").select2('val',response.OPPORTUNITY.sourceID);
		$("#oppCustomer").select2('val',response.OPPORTUNITY.custID);
		$("#oppCampaign").select2('val',response.OPPORTUNITY.campID);
		$("#oppAssignTo").select2('val',response.OPPORTUNITY.userId); */
    });
	
	$scope.collaborates = [];
	$scope.tags = [];
	$scope.username = username; 
	
	$scope.listLeads = function(){
			$http({
			    method: 'GET',
			    url: '${pageContext.request.contextPath}/case/view/'+username+"/"+oppId,
			    headers: {
			    	'Accept': 'application/json',
			        'Content-Type': 'application/json'
			    },
			    data: {"moduleId":oppId, "username":username}
			}).success(function(response) {	
				leadStatusData =  response.CASE_STATUS;
				$scope.listNote1(response.NOTES);
				$scope.cases = response.CASE;
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
				
				
				
				
				
				curAssign = fmNull(response.CASE.username);
				ownerItem = fmNull(response.CASE.createBy);
				
				$scope.listCollab(response.COLLABORATIONS);							
				$scope.callStatusStartup = response.CALL_STATUS;
				$scope.taskStatusStartup = response.TASK_STATUS;
				$scope.taskContactStartup = response.CONTACTS;	
				$scope.eventLocationStartup = response.EVENT_LOCATION;
				$scope.meetStatusStartup = response.MEETING_STATUS;				
				$scope.tags = response.TAG_TO;
				$scope.users = response.ALL_USERS;
				$scope.articles = response.ARTICLES;
				
				//dis($scope.users)
				
				displayStatusLead(response.CASE.statusId);
				
				
				var_ResolvedBy = response.CASE.resolvedBy;
				var_ResolveSolution = response.CASE.resolution;
				CKEDITOR.instances['ca_resolution'].setData(response.CASE.resolution);
				
				
				$("#ca_resolvedDate").val(response.CASE.resolveDate);
				$("#display_solution").append(response.CASE.resolution);
				
				setTimeout(function(){ 
					$("#ca_resolvedBy").select2("val",response.CASE.resolvedBy); 
					if(response.CASE.articleId != null){
						$("#ca_article").prop("disabled", false);
						$("#ca_article").select2("val", response.CASE.articleId);
						$("#inp_existArticle").prop('checked', true);
					}
					
				}, 1000);
				
				
				
				
				
			});
			
			
	}
	
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	
	// resolve
	
	$scope.resolve_click = function(){
		$("#btn_show_resolve").click();
	}
	
	// escalate
	
	$scope.escalate_click = function(){
		$("#btn_show_escalate").click();
	}
	
	$scope.escalateClick = function(){
		
		if(getPermissionByModule("CS","edit") == "YES" || checkAssignTo() || checkOwner()){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to escalate case with ID: <span class='color_msg'>"+$scope.cases.caseId+"</span>.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					
					$('#frmEscalateTo').data('bootstrapValidator').validate();
					var statusResolution = $("#frmEscalateTo").data('bootstrapValidator').validate().isValid();
					
					if(statusResolution){
						$.ajax({ 
							url : "${pageContext.request.contextPath}/case/escalate",
							type : "PUT",
							data : JSON.stringify({
								  "caseId": $scope.cases.caseId,
								  "resolvedBy" : getValueStringById("ca_resolvedBy"),
								  "convertResolvedDate" : getValueStringById("ca_resolvedDate"),
								  "resolution" : CKEDITOR.instances['ca_resolution'].getData(),
								  "article" : getJsonById("articleId","ca_article","str"),
								  "assignTo" : getJsonById("userID","ca_escalateTo","str"),
								  "status" : {"statusId":4},
						    }),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){					    						    
								if(result.MESSAGE == "UPDATED"){						
									$scope.getListNoteByLead();
				    				swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
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
					
					}else{
						swal("UNSUCCESSFUL", "Data invalid!", "error");
					}
				}, 500);
			});
		}else{
			alertMsgNoPermision();
		}	
	}
	
	$scope.resolveClick = function(){
		
		if(getPermissionByModule("CS","edit") == "YES" || checkAssignTo() || checkOwner()){
			swal({   
				title: "<span style='font-size: 25px;'>You are about to resolve case with ID: <span class='color_msg'>"+$scope.cases.caseId+"</span>.</span>",
				text: "Click OK to continue or CANCEL to abort.",
				type: "info",
				html: true,
				showCancelButton: true,
				closeOnConfirm: false,
				showLoaderOnConfirm: true,		
			}, function(){ 
				setTimeout(function(){
					
					$('#frmResolution').data('bootstrapValidator').validate();
					var statusResolution = $("#frmResolution").data('bootstrapValidator').validate().isValid();
					
					if(statusResolution){
						
						var createArtStatus = false;
						if ($('#inp_newArticle').is(":checked")){
							createArtStatus = true;
						}
						
						$.ajax({ 
							url : "${pageContext.request.contextPath}/case/resolve",
							type : "PUT",
							data : JSON.stringify({
								"caseId": $scope.cases.caseId,
								  "resolvedBy" : getValueStringById("ca_resolvedBy"),
								  "convertResolvedDate" : getValueStringById("ca_resolvedDate"),
								  "resolution" : CKEDITOR.instances['ca_resolution'].getData(),
								  "article" : getJsonById("articleId","ca_article","str"),
								  "status" : {"statusId":5},
								  "createArt": createArtStatus,
								  "itemId" : $scope.cases.caseItemId,
								  "createBy" : username,
								  "assignTo" : getJsonByValue("userID", $scope.cases.username,"str") ,
								  "key" : $scope.cases.caseKey,
								  "title" : $scope.cases.subject
						    }),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){					    						    
								if(result.MESSAGE == "UPDATED"){						
									$scope.getListNoteByLead();
				    				swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
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
					
					}else{
						swal("UNSUCCESSFUL", "Data invalid!", "error");
					}
				}, 500);
			});
		}else{
			alertMsgNoPermision();
		}	
	}
	
	//$('#statusSelect').select2('disable');
	
	$scope.createNewArticleClick = function(){
		if ($('#inp_newArticle').is(":checked")){
			$('#inp_existArticle').prop('checked', false);
			$("#ca_article").select2("val","");
			$("#ca_article").prop("disabled", true);
		}else{
			//$('#inp_existArticle').prop('checked', true);
		}		
	}
	
	$scope.createExistArticleClick = function(){
		if ($('#inp_existArticle').is(":checked")){
			$("#ca_article").prop("disabled", false);
			$('#inp_newArticle').prop('checked', false);
		}else{
			$("#ca_article").select2("val","");
			$("#ca_article").prop("disabled", true);
		}
	}
	
	
	
	                                   
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
	              		title:"Deleted",
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
		              		title:"Deleted",
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


app.controller('callController',['$scope','$http',function( $scope, $http){
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
		$("#meetDuration").select2('val',"");
		$("#meetStatus").select2('val',"");
		$("#meetAssignTo").select2('val',"");	
		$("#btnMeetSave").text("Save");
		$("#tMeet").text("Create Meeting");
		$('#frmAddMeet').bootstrapValidator('resetForm', true);
	}	
}]);

app.controller('taskController',['$scope','$http',function( $scope, $http){
	
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
		$("#eventDuration").select2('val',"");
		$("#eventLocation").select2('val',"");
		$("#eventAssignTo").select2('val',"");	
		$("#btnEventSave").text("Save");
		$("#tEvent").text("Create Event");
		$('#frmAddEvent').bootstrapValidator('resetForm', true);
	}	
}]);

function setSelect2ToResolveBy(value){	
	$("#ca_resolvedBy").select2("val",value);	
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
	
	.trask-btn {
		color: #dd4b39 !important;
	}
	
	.like-btn {
		color: #3289c8 !important;
	}
	
	.unlike-btn {
		
	}
	
	.icon_color {
		color: #2196F3;
	}
	
	.iTable tbody {
		border-top: 1px solid #d2d6de !important;
	}
	
	.iTable thead, tr, td {
		border: 0px !important;
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
<div class="content-wrapper" id="viewOpportunityController"
	ng-app="viewOpportunity" ng-controller="viewOpportunityController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>View Case</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i
					class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>View Case</a></li>
		</ol>
	</section>

	<section class="content" data-ng-init="listLeads()">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<!-- Widget: user widget style 1 -->
				<div class="box box-widget widget-user">
					<!-- Add the bg color to the header using any of the bg-* classes -->
					<div class="widget-user-header bg-aqua-active">
						<h3 class="widget-user-username ng-cloak">{{'['+cases.caseId+']'}}</h3>
						<h5 class="widget-user-desc ng-cloak">{{cases.subject}}</h5>
					</div>
					<div class="widget-user-image">
						<img class="img-circle"
							src="${pageContext.request.contextPath}/resources/images/module/Case.png"
							alt="User Avatar">
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="col-xs-4 col-sm-4 col-md-4 col-lg-1 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak">{{cases.caseTypeName}}</h5>
									<span class="description-text">Type</span>
								</div>
								<hr class="hidden-lg">
							</div>
							<div class="col-xs-4 col-sm-4 col-md-4 col-lg-1 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak">{{cases.priorityName}}</h5>
									<span class="description-text">Priority</span>
								</div>
								<hr class="hidden-lg">
							</div>
							<div class="col-xs-4 col-sm-4 col-md-4 col-lg-1 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak">{{cases.originName}}</h5>
									<span class="description-text">Origin</span>
								</div>
								<hr class="hidden-lg">
							</div>
							<div class="clearfix hidden-lg"></div>
							<div class="col-xs-4 col-sm-4 col-md-4 col-lg-3 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak"
										ng-if="cases.custID != null">[{{cases.custID}}]
										{{cases.custName}}</h5>
									<span class="description-text">Customer</span>
								</div>
							</div>
							<div class="col-xs-4 col-sm-4 col-md-4 col-lg-3 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak"
										ng-if="cases.conID != null">[{{cases.conID}}]
										{{cases.conSalutation}}{{cases.conFirstname}}
										{{cases.conLastname}}</h5>
									<span class="description-text">Contact</span>
								</div>
							</div>
							<div class="col-xs-4 col-sm-4 col-md-4 col-lg-3 border-right">
								<div class="description-block">
									<h5 class="description-header ng-cloak">{{cases.followupDate}}</h5>
									<span class="description-text">Follow-up Date</span>
								</div>
							</div>
						</div>
						<ul class="breadcrumb1 hidden-xs" id="objStatus"></ul>
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="row">
							<div class="clearfix"></div>
							<br />
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
									<li class=""><a href="#resolution_tap" data-toggle="tab"
										aria-expanded="false">SOLUTION</a></li>
									<li class=""><a href="#escalate_tap" data-toggle="tab"
										aria-expanded="false">ESCALATE</a></li>
									<!-- <li class=""><a href="#history_tap" data-toggle="tab"
										aria-expanded="false">HISTORY</a></li> -->
								</ul>
								<div class="tab-content">
								
									<div class="tab-pane active" id="activity">
										<div class="row">
	
											<div class="col-md-12">
												<a style="margin-left: 0px;" class="btn btn-app"
													ng-click="call_click();startupCallForm()"> <i class="fa fa-phone"></i>
													Call
												</a> <a class="btn btn-app" ng-click="meet_click()"> <i
													class="fa fa-users"></i> Meeting
												</a> <a class="btn btn-app" ng-click="task_click()"> <i
													class="fa fa-list-alt "></i> Task
												</a> <a class="btn btn-app" ng-click="event_click()"> <i
													class="fa  fa-calendar-check-o"></i> Event
												</a> <a class="btn btn-app" ng-click="email_click()"> <i
													class="fa fa-envelope"></i> Email
												</a>
											</div>
											<div class="col-md-12">
												<div class="panel-group" id="accordion">
													<div class="panel panel-default">
														<div class="panel-heading">
															<h4 class="panel-title">
																<a data-toggle="collapse" data-parent="#accordion"
																	href="#collapse1">Calls</a> <span
																	class="badge bg-blue pull-right ng-cloak">{{listAllCallByLead.length
																	<= 0 ? '' : listAllCallByLead.length }}</span>
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
																		<tbody ng-repeat="call in listAllCallByLead">
																			<tr>
																				<td class="iTD-width-50">{{call.callId}}</td>
																				<td>{{call.callSubject}}</td>
																				<td>{{call.callStartDate | date:'dd/MM/yyyy'}}</td>
																				<td>{{call.callDuration}}<span> min</span></td>
																				<td>{{call.username == null?'-':call.username}}</td>
																				<td>{{call.callCreateBy}}</td>
																				<td class="text-center mailbox-date">
																					<a href="#" ng-click="actEditCall(call.callId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
																					<a href="#" ng-click="actDeleteCall(call.callId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="delete"><i class="fa fa-trash text-danger"></i></button></a>
																					<a href="${pageContext.request.contextPath}/view-call/{{call.callId}}"><button type="button" data-toggle="tooltip" class="btn btn-xs" title="view"><i class="fa fa-eye text-info"></i></button></a>
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
																<a data-toggle="collapse" data-parent="#accordion"
																	href="#collapse2"> Meetings</a> <span
																	class="badge bg-blue pull-right ng-cloak">{{listAllMeetByLead.length
																	<= 0 ? '' : listAllMeetByLead.length }}</span>
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
																		<tbody ng-repeat="meet in listAllMeetByLead">
																			<tr>
																				<td class="iTD-width-50">{{meet.meetingId}}</td>
																				<td>{{meet.meetingSubject}}</td>
																				<td>{{meet.statusName}}</td>
																				<td>{{meet.meetingStartDate |date:'dd/MM/yyyy'}}</td>
																				<td>{{meet.meetingEndDate |date:'dd/MM/yyyy'}}</td>
																				<td>{{meet.username}}</td>
																				<td>{{meet.meetingCreateBy}}</td>
																				<td class="text-center mailbox-date">
																					<a href="#" ng-click="actEditMeeting(meet.meetingId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
																					<a href="#" ng-click="actDeleteMeeting(meet.meetingId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="delete"><i class="fa fa-trash text-danger"></i></button></a>
																					<a href="${pageContext.request.contextPath}/view-meeting/{{meet.meetingId}}"><button type="button" data-toggle="tooltip" class="btn btn-xs" title="view"><i class="fa fa-eye text-info"></i></button></a>
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
																<a data-toggle="collapse" data-parent="#accordion"
																	href="#collapse3"> Tasks</a> <span
																	class="badge bg-blue pull-right ng-cloak">{{listAllTaskByLead.length
																	<= 0 ? '' : listAllTaskByLead.length }}</span>
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
																		<tbody ng-repeat="task in listAllTaskByLead">
																			<tr>
																				<td class="iTD-width-50">{{task.taskId}}</td>
																				<td>{{task.taskSubject}}</td>
																				<td>{{task.taskStatusName}}</td>
																				<td>{{task.taskStartDate | date:'dd/MM/yyyy'}}</td>
																				<td>{{task.taskDueDate | date:'dd/MM/yyyy'}}</td>
																				<td>{{task.username}}</td>
																				<td>{{task.taskCreateBy}}</td>
																				<td class="text-center mailbox-date">
																					<a href="#" ng-click="actEditTask(task.taskId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="edit"><i class="fa fa-pencil text-primary"></i></button></a>
																					<a href="#" ng-click="actDeleteTask(task.taskId)"><button type="button" class="btn btn-xs" data-toggle="tooltip" title="delete"><i class="fa fa-trash text-danger"></i></button></a>
																					<a href="${pageContext.request.contextPath}/view-task/{{task.taskId}}"><button type="button" data-toggle="tooltip" class="btn btn-xs" title="view"><i class="fa fa-eye text-info"></i></button></a>
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
																<a data-toggle="collapse" data-parent="#accordion"
																	href="#collapse4"> Events</a> <span
																	class="badge bg-blue pull-right ng-cloak">{{listAllEventByLead.length
																	<= 0 ? '' : listAllEventByLead.length }}</span>
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
																		<tbody ng-repeat="event in listAllEventByLead">
																			<tr>
																				<td class="iTD-width-50">{{event.evId}}</td>
																				<td>{{event.evName}}</td>
																				<td>{{event.locateName}}</td>
																				<td>{{event.evStartDate | date:'dd/MM/yyyy'}}</td>
																				<td>{{event.evEndDate | date:'dd/MM/yyyy'}}</td>
																				<td>{{event.username}}</td>
																				<td>{{event.evCreateBy}}</td>
																				<td class="text-center mailbox-date">
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
													<div class="panel panel-default">
														<div class="panel-heading">
															<h4 class="panel-title">
																<a data-toggle="collapse" data-parent="#accordion"
																	href="#collapse5"> Emails</a> <span
																	class="badge bg-blue pull-right ng-cloak">{{listAllEmailByLead.length
																	<= 0 ? '' : listAllEmailByLead.length }}</span>
															</h4>
														</div>
														<div id="collapse5" class="panel-collapse collapse">
															<div class="panel-body">
																<div class="mailbox-messages table-responsive">
																	<table class="table iTable"
																		data-ng-init="listAllEmailByLeadId()">
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
																				<td class="iTD-width-50"><a href="#"><i
																						class="fa fa-envelope text-green font-size-icon-30"></i></a>
																				</td>
																				<td colspan="2">{{event.evName}}</td>
																				<td>{{event.locateName}}</td>
																				<td>{{event.evStartDate | date:'dd/MM/yyyy'}}</td>
																				<td>{{event.evEndDate | date:'dd/MM/yyyy'}}</td>
																				<td>{{event.username}}</td>
																				<td>{{event.evCreateBy}}</td>
																			</tr>
																			<tr>
																				<td colspan="7"><a href="#">{{event.evDes
																						| limitTo:200}}{{event.evDes.length <= 200 ? '' :
																						'...'}}</a></td>
																				<td class="mailbox-date">
																					<div class="col-sm-2">
																						<div class="btn-group">
																							<button type="button"
																								class="btn btn-default dropdown-toggle btn-sm"
																								data-toggle="dropdown" aria-expanded="false">
																								<span class="caret"></span> <span
																									class="sr-only">Toggle Dropdown</span>
																							</button>
																							<ul class="dropdown-menu" role="menu">
																								<li ng-click="actEditEvent(event.evId)"><a
																									href="#"><i class="fa fa-pencil"></i> Edit</a>
																								</li>
																								<li ng-click="actDeleteEvent(event.evId)">
																									<a href="#"><i class="fa fa-trash"></i>
																										Delete</a>
																								</li>
																								<li><a
																									href="${pageContext.request.contextPath}/view-task/{{task.taskId}}">
																										<i class="fa fa-eye"></i>View
																								</a></li>
	
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
	
									<div class="tab-pane" id="collaborate">
	
										<div class="col-md-12"
											style="padding-right: 0px; padding-left: 0px;">
											<form id="frmCollab">
												<div class="col-sm-12"
													style="padding-right: 0px; padding-left: 0px;">
													<div class="form-group">
														<label>Post <span class="requrie">(Required)</span></label>
														<textarea rows="3" cols="" name="collabPostDescription"
															id="collabPostDescription" class="form-control"
															placeholder=""></textarea>
													</div>
												</div>
												<div class="col-sm-12"
													style="padding-right: 0px; padding-left: 0px;">
													<div class="form-group">
														<label>Tags </label> <select class="form-control"
															multiple name="collabTags" id="collabTags"
															style="width: 100%;">
															<option ng-repeat="tag in tags" value="{{tag.username}}">{{tag.username}}</option>
														</select>
													</div>
												</div>
											</form>
											<div class="col-sm-12"
												style="padding-right: 0px; padding-left: 0px;">
												<button style="margin-top: 10px; margin-left: 10px;"
													ng-click="resetFrmCollab()" type="button"
													class="btn btn-danger pull-right">Reset</button>
												<button type="button" style="margin-top: 10px;"
													ng-click="addCollab()" name="collabBtnPost"
													id="collabBtnPost" class="btn btn-primary pull-right">POST</button>
											</div>
										</div>
										<div class="clearfix"></div>
										<br>
										<!-- content collab -->
	
										<div class="post clearfix" ng-repeat="(key_post,collab) in collaborates track by $index">
											<div class="user-block">
												<img class="img-circle img-bordered-sm"
													src="${pageContext.request.contextPath}/resources/images/av.png"
													alt="user image"> <span class="username"> <a
													href="#">{{collab.colUser}}</a> <a
													style="color: #999; font-size: 13px;">on
														{{collab.createDate}}</a> <span
													ng-if="collab.colOwn == 'true'"
													ng-click="btnDeleteCollabPost(key_post,collab.colId)"
													class="pull-right btn-box-tool cusor_pointer"><button
															class="btn btn-default btn-sm">
															<i class="fa fa-trash trask-btn"></i>
														</button></span>
												</span> <span class="description"><i
													ng-if="collab.tags.length > 0 " class="fa fa-tags"></i> <span
													ng-repeat="t in collab.tags">{{t.username}} </span></span>
											</div>
											<p>{{collab.colDes}}</p>
	
											<ul class="list-inline">
												<li><span href="#" class="link-black text-sm ">
														<span ng-if="collab.checkLike == true"><button
																ng-click="postLike(key_post,collab.colId)"
																class="btn btn-default btn-sm">
																<i class="fa fa-thumbs-up like-btn"></i>
															</button>&nbsp;&nbsp;&nbsp;You {{collab.like <= 0 ? "" :
															collab.like==1 ? "and 1 other" : "and "+collab.like+"
															others"}}</span> <span ng-if="collab.checkLike == false"><button
																ng-click="postLike(key_post,collab.colId)"
																class="btn btn-default btn-sm">
																<i class="fa fa-thumbs-o-up unlike-btn"></i>
															</button>&nbsp;&nbsp;&nbsp;{{collab.like <= 0 ? "" :
															collab.like}}</span>
												</span></li>
												<li class="pull-right"><a href="#"
													class="link-black text-sm"><i
														class="fa fa-comments-o margin-r-5"></i> <span>
															Comments{{collab.details.length <= 0 ? "" :
															"("+collab.details.length+")"}}</span></a></li>
											</ul>
	
	
											<div style="padding-top: 15px;"
												class="box-footer box-comments">
												<div class="box-comment"
													ng-repeat="(key_comment, com) in collab.details">
													<img class="img-circle img-sm"
														src="${pageContext.request.contextPath}/resources/images/av.png"
														alt="user image">
													<div class="comment-text">
														<span class="username"> <span>
																{{com.username}} <span class="text-muted"> on
																	{{com.formatCreateDate}}</span>
														</span> <span ng-if="com.username == username"
															ng-click="btnDeleteCollabCom(key_post, key_comment,com.commentId)"
															class="pull-right btn-box-tool cusor_pointer"><button
																	class="btn btn-default btn-sm">
																	<i class="fa fa-trash trask-btn"></i>
																</button></span>
														</span> {{com.comment}}
													</div>
												</div>
											</div>
	
	
											<form id="" ng-submit="postCommand(key_post, collab.colId)">
												<div class="form-group">
													<input ng-model="newcomment[key_post].comment"
														id="txtComment" class="form-control input-sm" type="text"
														placeholder="Type a comment">
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
											<li
												ng-repeat="note in notes | filter:{createDate: notePerDate.createDate}">
												<i class="fa  fa-edit bg-blue"></i>
												<div class="timeline-item">
													<span class="time"><i class="fa fa-clock-o"></i>
														&nbsp;{{notePerDate.createTime}}</span>
													<h3 class="timeline-header">
														{{note.noteSubject}} <a>by {{note.noteCreateBy}}</a>
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
											<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
												<form id="frmLeadDetail">
													<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
														<ul class="list-group list-group-unbordered">
															<li class="list-group-item"><b>Overview</b> <!-- <a
																class="pull-right cusor_pointer"
																ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																	Edit</a> --></li>
	
															<li class="list-group-item item_border">Case ID <a
																class="pull-right show-text-detail">{{cases.caseId}}</a>
																<div class="form-group show-edit"
																	style="display: none;">
																	<!-- <input type="text" name="lea_firstName"
																		id="lea_firstName" class="form-control"
																		value="{{lead.firstName}}"> -->
																	<div class="clearfix"></div>
																</div>
															</li>
															<li class="list-group-item item_border">Status<a
																class="pull-right show-text-detail">{{cases.statusName}}</a>
																<div class="form-group show-edit"
																	style="display: none;">
																	<!-- <input type="text" name="lea_firstName"
																		id="lea_firstName" class="form-control"
																		value="{{lead.firstName}}"> -->
																	<div class="clearfix"></div>
																</div>
															</li>
															<li class="list-group-item item_border">Type<a
																class="pull-right show-text-detail">{{cases.caseTypeName}}</a>
																<div class="form-group show-edit"
																	style="display: none;">
																	<!-- <input type="text" name="lea_lastName"
																		id="lea_lastName" class="form-control"
																		value="{{lead.lastName}}"> -->
																</div>
															</li>
															<li class="list-group-item item_border">Priority<a
																class="pull-right show-text-detail">{{cases.priorityName}}</a>
																<div class="form-group show-edit"
																	style="display: none;">
																	<!-- <input type="text" name="lea_title" id="lea_title"
																		class="form-control" value="{{lead.title}}"> -->
																</div>
															</li>
															<li class="list-group-item item_border">Origin<a
																class="pull-right show-text-detail">{{cases.caseOriginTitle}}</a>
																<div class="form-group show-edit"
																	style="display: none;">
																	<!-- <input type="text" name="lea_title" id="lea_title"
																		class="form-control" value="{{lead.title}}"> -->
																</div>
															</li>
															<li class="list-group-item item_border">Subject <a
																class="pull-right show-text-detail">{{cases.subject}}</a>
																<div class="form-group show-edit"
																	style="display: none;">
																	<!-- <input type="text" name="lea_title" id="lea_title"
																		class="form-control" value="{{lead.title}}"> -->
																</div>
															</li>
	
														</ul>
													</div>
													<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
														<ul class="list-group list-group-unbordered">
															<li class="list-group-item"><b>Related To</b> <!-- <a
																class="pull-right cusor_pointer"
																ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																	Edit</a> --></li>
															<li class="list-group-item item_border">Product<a
																class="pull-right show-text-detail">[{{cases.caseItemId}}]
																	{{cases.caseItemName.trunc(20)}}</a>
																<div class="form-group show-edit"
																	style="display: none;">
																	<!-- <input type="text" name="lea_no" id="lea_no"
																		class="form-control" value="{{lead.no}}"> -->
																</div>
															</li>
															<li class="list-group-item item_border">Customer<a
																class="pull-right show-text-detail">[{{cases.custID}}]
																	{{cases.custName.trunc(20)}}</a>
																<div class="form-group show-edit"
																	style="display: none;">
																	<!-- <input type="text" name="lea_no" id="lea_no"
																		class="form-control" value="{{lead.no}}"> -->
																</div>
															</li>
															<li class="list-group-item item_border">Contact <a
																class="pull-right show-text-detail">[{{cases.conID}}]
																	{{cases.conSalutation}}{{cases.conFirstname}}
																	{{cases.conLastname}}</a>
																<div class="form-group show-edit"
																	style="display: none;">
																	<!-- <input type="text" name="lea_street" id="lea_street"
																		class="form-control" value="{{lead.street}}"> -->
																</div>
															</li>
	
														</ul>
													</div>
													<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
														<ul class="list-group list-group-unbordered">
															<li class="list-group-item"><b>Other</b> <!-- <a
																class="pull-right cusor_pointer"
																ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																	Edit</a> --></li>
															<li class="list-group-item item_border">Assigned to
																<a class="pull-right show-text-detail">{{cases.username}}</a>
																<div class="form-group show-edit"
																	style="display: none;">
																	<!-- <input type="text" name="lea_firstName"
																		id="lea_firstName" class="form-control"
																		value="{{lead.firstName}}"> -->
																	<div class="clearfix"></div>
																</div>
															</li>
														</ul>
													</div>
	
	
													<div class="clearfix"></div>
													<div class="col-sm-12">
														<ul class="list-group list-group-unbordered">
															<li class="list-group-item"><b>Description</b> <!-- <a
																class="pull-right cusor_pointer"
																ng-click="editDetailLead()"><i class="fa fa-pencil"></i>
																	Edit</a> --></li>
															<li class="list-group-item item_border"
																ng-if="cases.des != null"><a
																class="show-text-detail">{{cases.des}}</a>
																<div class="form-group show-edit"
																	style="display: none;">
																	<!-- <input type="text" name="lea_firstName"
																		id="lea_firstName" class="form-control"
																		value="{{lead.firstName}}"> -->
																	<div class="clearfix"></div>
																</div></li>
														</ul>
													</div>
	
	
	
													<br>
													<div class="col-sm-12 text-center" id="showBtnEditLead"
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
	
									<div class="tab-pane " id="resolution_tap">
										<div class="row">
											<div class="col-md-12">
												<a style="margin-left: 0px;" class="btn btn-app"
													ng-click="resolve_click()"> <i
													class="fa  fa-check-square-o"></i> Resolve
												</a>
											</div>
											<div class="col-sm-4">
												<ul class="list-group list-group-unbordered">
													<li class="list-group-item item_border">Resolve by<a
														class="pull-right show-text-detail">{{cases.resolveByName}}</a>
														<div class="form-group show-edit" style="display: none;">
															<!-- <input type="text" name="lea_firstName"
																id="lea_firstName" class="form-control"
																value="{{lead.firstName}}"> -->
															<div class="clearfix"></div>
														</div>
													</li>
												</ul>
											</div>
											<div class="col-sm-4">
												<ul class="list-group list-group-unbordered">
													<li class="list-group-item item_border">Resolve Date<a
														class="pull-right show-text-detail">{{cases.resolveDate}}</a>
														<div class="form-group show-edit" style="display: none;">
															<!-- <input type="text" name="lea_firstName"
																id="lea_firstName" class="form-control"
																value="{{lead.firstName}}"> -->
															<div class="clearfix"></div>
														</div></li>
												</ul>
											</div>
											<div class="col-sm-4">
												<ul class="list-group list-group-unbordered">
													<li class="list-group-item item_border">Article <a
														class="pull-right show-text-detail">[{{cases.articleId}}]{{cases.articleTitle}}</a>
														<div class="form-group show-edit" style="display: none;">
															<!-- <input type="text" name="lea_lastName"
																id="lea_lastName" class="form-control"
																value="{{lead.lastName}}"> -->
														</div>
													</li>
												</ul>
											</div>
											<div class="clearfix"></div>
											<div class="col-sm-12" style="margin-top: -20px;">
												<ul class="list-group list-group-unbordered">
													<li class="list-group-item item_border"
														style="border-top: 0px !important">Solution</li>
													<li class="list-group-item item_border" style="border: 1px solid #d4d4d4;">
														<p id="display_solution" style="padding:10px;"></p>
														<div class="form-group show-edit" style="display: none;">
															<!-- <input type="text" name="lea_firstName"
																id="lea_firstName" class="form-control"
																value="{{lead.firstName}}"> -->
															<div class="clearfix"></div>
														</div></li>
												</ul>
											</div>
	
										</div>
	
									</div>
									
									<div class="tab-pane " id="escalate_tap">
										<div class="row">
											<form method="post" id="frmEscalateTo">
												<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
													<div class="row">
														<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
															<div class="form-group">
																<label>Escalate To<span class="requrie">(Required)</span></label>
																<div class="form-group">
																	<select class="form-control select2" name="ca_escalateTo"
																		id="ca_escalateTo" style="width: 100%">
																		<option value="">-- SELECT Escalate To --</option>
																		<option ng-repeat="u in users" value="{{u.userID}}">{{u.username}}</option>
																	</select>
																</div>
															</div>
														</div>
														<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
															<div class="form-group">
																<label>Escalate Status<span class="requrie">(Required)</span></label>
																<div class="form-group">
																	<select class="form-control select2" name="ca_escalateStatus"
																		id="ca_escalateStatus" style="width: 100%">
																		<option value="Escalated">Escalated</option>
																		
																	</select>
																</div>
															</div>
														</div>
														<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
															<button type="button" id="btnEscalateCancel"
																ng-click="cancelEscalateClick()" name="btnEscalateCancel"
																class="btn btn-danger pull-right" style="margin-left:5px;" data-dismiss="modal">Cancel</button>
															&nbsp;&nbsp;
															<button ng-click="escalateClick()" type="button" class="btn btn-primary pull-right"
																id="btnEscalateSave" name="btnEscalateSave">Escalate</button>
														</div>
													</div>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<input type="hidden" id="btn_show_escalate" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmEscalate" />
	<div ng-controller="callController" class="modal fade modal-default"
		id="frmEscalate" role="dialog">
		<div class="modal-dialog" data-ng-init="startupCallForm()">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelCallClick()" class="close"
						data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<b id="tCall">Escalate Case</b>
					</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="btnEscalateCancel"
						ng-click="cancelEscalateClick()" name="btnEscalateCancel"
						class="btn btn-danger" data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" class="btn btn-primary pull-right"
						id="btnEscalateSave" name="btnEscalateSave">Save</button>

				</div>
			</div>
		</div>
	</div>

	<input type="hidden" id="btn_show_resolve" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmResolve" />
	<div ng-controller="callController" class="modal fade modal-default"
		id="frmResolve" role="dialog">
		<div class="modal-dialog  modal-lg" data-ng-init="startupCallForm()">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelCallClick()" class="close"
						data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<b id="tCall">Resolve Case</b>
					</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form method="post" id="frmResolution">
							<div class="col-sm-12">
								<div class="col-sm-6">
									<label class="font-label">Resolved by <span
										class="requrie">(Required)</span></label>
									<div class="form-group">
										<select class="form-control select2" name="ca_resolvedBy"
											id="ca_resolvedBy" style="width: 100%">
											<option value="">-- SELECT Resolved by --</option>
											<option ng-repeat="u in users" value="{{u.userID}}">{{u.username}}</option>
										</select>
									</div>
								</div>
								<div class="col-sm-6">
									<div class="form-group">
										<label>Resolved Date<span class="requrie">(Required)</span></label>
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input value="" name="ca_resolvedDate" id="ca_resolvedDate" type="text" class="form-control pull-right active">
										</div>
									</div>
								</div>


								<div class="col-sm-12">
									<div class="checkbox">
										<label> <input ng-click="createNewArticleClick()"
											id="inp_newArticle" type="checkbox"> Create a draft
											knowledge base article from solution notes and link it to
											this case
										</label>
									</div>
								</div>
								<div class="col-sm-12">
									<div class="checkbox">
										<label> <input ng-click="createExistArticleClick()"
											id="inp_existArticle" type="checkbox"> Solution
											involves information from an existing knowledge base article
										</label>
									</div>
								</div>
								<div class="col-sm-6">
									<label class="font-label">Article </label>
									<div class="form-group">
										<select class="form-control select2" name="ca_article"
											id="ca_article" style="width: 100%">
											<option value="">-- SELECT An Article --</option>
											<option ng-repeat="u in articles" value="{{u.articleId}}">[{{u.articleId}}]
												{{u.articleTitle}}</option>
										</select>
									</div>
								</div>
								<div class="col-sm-12 ">
									<label class="font-label">Solution </label>
									<div class="form-group">
										<textarea rows="5" cols="" name="ca_resolution"id="ca_resolution" class="form-control">
										
										</textarea>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="btnResolveCancel"
						ng-click="cancelResolveClick()" name="btnResolveCancel"
						class="btn btn-danger" data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" class="btn btn-primary pull-right"
						id="btnResolveSave" ng-click="resolveClick()" name="btnResolveSave">Resolve</button>

				</div>
			</div>
		</div>
	</div>

	<input type="hidden" id="btn_show_call" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmCall" />
	<div ng-controller="callController" class="modal fade modal-default"
		id="frmCall" role="dialog">
		<div class="modal-dialog  modal-lg" data-ng-init="">
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
												type="text" class="form-control call-date-time pull-right active">
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
													name="callDuration" id="callDuration" readonly="readonly"
													placeholder="hours:minutes">
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
	<div ng-controller="meetController" class="modal fade modal-default"
		id="frmMeet" role="dialog">
		<div class="modal-dialog  modal-lg" data-ng-init="startupMeetForm()">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelMeetClick()" class="close"
						data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<b id="tMeet">Create Meeting</b>
					</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form id="frmAddMeet">
							<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
								<div class="col-xs-12 col-sm-12 col-md-6">
									<div class="form-group">
										<label>Subject <span class="requrie">(Required)</span></label>
										<input id="meetSubject" name="meetSubject"
											class="form-control" type="text" placeholder="">
									</div>
								</div>

								<div class="clearfix hidden-md hidden-lg"></div>
								<div class="col-xs-12 col-sm-12 col-md-6">
									<div class="form-group">
										<label>Start Date<span class="requrie">(Required)</span></label>
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input value="" name="meetStartDate" id="meetStartDate" readonly="readonly"
												type="text"
												class="form-control meet-data-time pull-right active"  onchange="calculateMeetingDuration('meetStartDate','meetEndDate','meetDuration','frmAddMeet')">
										</div>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-xs-12 col-sm-12 col-md-6">
									<div class="form-group">
										<label>End Date<span class="requrie">(Required)</span></label>
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input name="meetEndDate" id="meetEndDate" type="text" readonly="readonly"
												class="form-control meet-data-time pull-right active" onchange="calculateMeetingDuration('meetStartDate','meetEndDate','meetDuration','frmAddMeet')">
										</div>
									</div>
								</div>
								<div class="col-xs-12 col-sm-12 col-md-6">
									<div class="form-group">
										<label>Duration <span class="requrie">(Required)</span></label>
										<input type="text" class="form-control" name="meetDuration" id="meetDuration"/>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="clearfix hidden-md"></div>
								<div class="col-xs-12 col-sm-12 col-md-6">
									<div class="form-group">
										<label>Assign To </label> <select class="form-control select2"
											name="meetAssignTo" id="meetAssignTo" style="width: 100%;">
											<option value="">-- SELECT A Assign To --</option>
										</select>
									</div>
								</div>

								<div class="col-xs-12 col-sm-12 col-md-6">
									<div class="form-group">
										<label>Status</label> <select class="form-control select2"
											name="meetStatus" id="meetStatus" style="width: 100%;">
											<option value="">-- SELECT A Status --</option>
											<option ng-repeat="st in meetStatusStartup"
												value="{{st.statusId}}">{{st.statusName}}</option>
										</select>
									</div>
								</div>

								<div class="clearfix"></div>
								<div class="col-md-12">
									<div class="form-group">
										<label>Location </label> <input id="meetLocation"
											name="meetLocation" class="form-control" type="text"
											placeholder="">
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-12">
									<div class="form-group">
										<label>Description </label>
										<textarea rows="4" cols="" name="meetDescription"
											id="meetDescription" class="form-control"></textarea>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="btnMeetCancel"
						ng-click="cancelMeetClick()" name="btnMeetCancel"
						class="btn btn-danger" data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" id="btnMeetSave" name="btnMeetSave"
						class="btn btn-primary pull-right">Save</button>
				</div>
			</div>
		</div>
	</div>

	<input type="hidden" id="btn_show_task" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmTask" />
	<div ng-controller="taskController" class="modal fade modal-default"
		id="frmTask" role="dialog">
		<div class="modal-dialog  modal-lg" data-ng-init="startupTaskForm()">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelTaskClick()" class="close"
						data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<b id="tTask">Create Task</b>
					</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form id="frmAddTask">
							<div class="col-md-12">
								<div class="col-md-12">
									<div class="form-group">
										<label>Subject <span class="requrie">(Required)</span></label>
										<input id="taskSubject" name="taskSubject"
											class="form-control" type="text" placeholder="">
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
											<input value="" name="taskStartDate" id="taskStartDate"
												type="text" readonly="readonly"
												class="form-control task-data-time pull-right active">
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
											<input name="taskEndDate" id="taskEndDate" type="text" readonly="readonly"
												class="form-control task-data-time pull-right active">
										</div>
									</div>
								</div>

								<div class="clearfix"></div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Priority <span class="requrie">(Required)</span></label>
										<select class="form-control select2" id="taskPriority"
											name="taskPriority" style="width: 100%;">
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
										<select class="form-control select2" name="taskStatus"
											id="taskStatus" style="width: 100%;">
											<option value="">-- SELECT A Status --</option>
											<option ng-repeat="st in taskStatusStartup"
												value="{{st.taskStatusId}}">{{st.taskStatusName}}</option>
										</select>
									</div>
								</div>

								<div class="clearfix"></div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Assign To </label> <select class="form-control select2"
											name="taskAssignTo" id="taskAssignTo" style="width: 100%;">
											<option value="">-- SELECT A Assign To --</option>
										</select>
									</div>
								</div>

								<div class="col-md-6">
									<div class="form-group">
										<label>Contact</label> <select class="form-control select2"
											name="taskContact" id="taskContact" style="width: 100%;">
											<option value="">-- SELECT A Contact --</option>
											<option ng-repeat="st in taskContactStartup"
												value="{{st.conID}}">{{st.conFirstname}}
												{{st.conLastName}}</option>
										</select>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-12">
									<div class="form-group">
										<label>Description </label>
										<textarea rows="4" cols="" name="taskDescription"
											id="taskDescription" class="form-control"></textarea>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="btnTaskCancel"
						ng-click="cancelTaskClick()" name="btnTaskCancel"
						class="btn btn-danger" data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" id="btnTaskSave" name="btnTaskSave"
						class="btn btn-primary pull-right">Save</button>
				</div>
			</div>
		</div>
	</div>

	<input type="hidden" id="btn_show_event" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#frmEvent" />
	<div ng-controller="eventController" class="modal fade modal-default"
		id="frmEvent" role="dialog">
		<div class="modal-dialog  modal-lg" data-ng-init="startupEventForm()">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" ng-click="cancelEventClick()" class="close"
						data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<b id="tEvent">Create Event</b>
					</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form id="frmAddEvent">
							<div class="col-md-12">
								<div class="col-md-12">
									<div class="form-group">
										<label>Subject <span class="requrie">(Required)</span></label>
										<input id="eventSubject" name="eventSubject"
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
											<input name="eventStartDate" id="eventStartDate" type="text" readonly="readonly"
												class="form-control event-date-time pull-right active" onchange="calculateMeetingDuration('eventStartDate','eventEndDate','eventDuration','frmAddEvent')">
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
											<input name="eventEndDate" id="eventEndDate" type="text" readonly="readonly"
												class="form-control event-date-time pull-right active" onchange="calculateMeetingDuration('eventStartDate','eventEndDate','eventDuration','frmAddEvent')">
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
										<label>Assign To </label> <select class="form-control select2"
											name="eventAssignTo" id="eventAssignTo" style="width: 100%;">
											<option value="">-- SELECT A Assign To --</option>
										</select>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Budget</label> <input id="eventBudget"
											name="eventBudget" class="form-control" type="text"
											placeholder="">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Location </label> <select class="form-control select2"
											name="eventLocation" id="eventLocation" style="width: 100%;">
											<option value="">-- SELECT A Location --</option>
											<option ng-repeat="loc in eventLocationStartup"
												value="{{loc.loId}}">{{loc.loName}}</option>
										</select>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-12">
									<div class="form-group">
										<label>Description </label>
										<textarea rows="4" cols="" name="eventDescription"
											id="eventDescription" class="form-control"></textarea>
									</div>
								</div>
							</div>
						</form>
					</div>



				</div>
				<div class="modal-footer">
					<button type="button" id="btnEventCancel"
						ng-click="cancelEventClick()" name="btnEventCancel"
						class="btn btn-danger" data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" id="btnEventSave" name="btnEventSave"
						class="btn btn-primary pull-right">Save</button>

				</div>
			</div>
		</div>
	</div>

	<div id="errors"></div>
</div>

<jsp:include page="${request.contextPath}/footer"></jsp:include>
<script
	src="${pageContext.request.contextPath}/resources/js.mine/case/viewCase.js"></script>
<script src="https://cdn.ckeditor.com/4.4.3/standard/ckeditor.js"></script>

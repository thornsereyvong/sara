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
var server = "${pageContext.request.contextPath}";
var noteIdEdit = "";
app.controller('viewLeadController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	$scope.listLeads = function(){
		$http.get("${pageContext.request.contextPath}/lead/view/"+leadId).success(function(response){
			$scope.lead = response.LEAD;
			setSelect($scope.lead.salutation);
			$scope.listNote(response.NOTES);
		});
	};
	
	
	
    
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	// note
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
	$scope.listNote = function(data){
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
		$http.get("${pageContext.request.contextPath}/lead/view/"+leadId).success(function(response){
			$scope.listNote(response.NOTES);
		});
	};
    
	
	
	// lead
	
	
	$scope.editDetailLead = function(){
		$(".show-edit").show();
		$(".show-text-detail").hide();
		$("#showBtnEditLead").show();
	}
	
	
	
    
	
	$scope.call_click = function(){
		$("#btn_show_call").click();
	}
	$scope.meet_click = function(){
		$("#btn_show_meet").click();
	}
	$scope.task_click = function(){
		$("#btn_show_task").click();
	}
	$scope.event_click = function(){
		$("#btn_show_event").click();
	}
	$scope.email_click = function(){
		$("#btn_show_email").click();
	}
	
	
}]);

function setSelect(option1){
	$("#leadSalutation option[value='"+option1+"']").attr('selected','selected');
}

$(function(){
	$(".timepicker").timepicker({
        showInputs: false,
        defaultTime: false,
        showMeridian : false
      });
	$('#startDate').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY' 
    });
	
	$('#startDateMeeting').daterangepicker({ singleDatePicker: true,timePicker: true, timePickerIncrement: 30, format: 'DD/MM/YYYY h:mm A'});
	$('#endDateMeeting').daterangepicker({ singleDatePicker: true,timePicker: true, timePickerIncrement: 30, format: 'DD/MM/YYYY h:mm A'});	
	
	
	
	$('#frmAddNote').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			note_subject: {
				validators: {
					notEmpty: {
						message: 'The subject is required and can not be empty!'
					},
					stringLength: {
						max: 255,
						message: 'The subject must be less than 255 characters long!'
					}
				}
			},
			note_description: {
				validators: {
					notEmpty: {
						message: 'The description is required and can not be empty!'
					},
					stringLength: {
						max: 1000,
						message: 'The description must be less than 1000 characters long!'
					}
				}
			}
		}
	}).on('success.form.bv', function(e) {
		var frmNoteData = {"noteId":noteIdEdit,"noteSubject":getValueStringById("note_subject"), "noteDes":getValueStringById("note_description"),"noteRelatedToModuleType":"Lead","noteRelatedToModuleId":leadId,"noteCreateBy":"${SESSION}"};		
		
		if($("#btnAddNote").text()=='Note'){
			$.ajax({ 
			    url: server+"/note/add", 
			    type: 'POST',
			    data: JSON.stringify(frmNoteData),
			    beforeSend: function(xhr) {
	                xhr.setRequestHeader("Accept", "application/json");
	                xhr.setRequestHeader("Content-Type", "application/json");
	            },
			    success: function(data) {
			    	
			    	if(data.MESSAGE == "INSERTED"){	
			    		swal({
		            		title:"Success",
		            		text:"User have been created new Note!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
			    		angular.element(document.getElementById('viewLeadController')).scope().resetFrmNote();
			    		angular.element(document.getElementById('viewLeadController')).scope().getListNoteByLead();
			    	}else{
			    		sweetAlert("Insert Unsuccessfully!", "", "error");
			    	}
			    	 
			    },
			    error:function(data,status,er) { 
			        console.log("error: "+data+" status: "+status+" er:"+er);
			        sweetAlert("Insert Unsuccessfully!", "", "error");
			    }
			});
		}else if($("#btnAddNote").text()=="Update"){
			$.ajax({ 
			    url: server+"/note/edit", 
			    type: 'PUT',
			    data: JSON.stringify(frmNoteData),
			    beforeSend: function(xhr) {
	                xhr.setRequestHeader("Accept", "application/json");
	                xhr.setRequestHeader("Content-Type", "application/json");
	            },
			    success: function(data) {
			    	if(data.MESSAGE == "UPDATED"){	
			    		swal({
		            		title:"Successfully",
		            		text:"User have been update Note!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
			    		angular.element(document.getElementById('viewLeadController')).scope().resetFrmNote();
			    		angular.element(document.getElementById('viewLeadController')).scope().getListNoteByLead();
			    	}else{
			    		sweetAlert("Update Unsuccessfully!", "", "error");
			    	}
			    	 
			    },
			    error:function(data,status,er) { 
			        console.log("error: "+data+" status: "+status+" er:"+er);
			        sweetAlert("Update Unsuccessfully!", "", "error");
			    }
			});
		}
	});	
	
	
	$('#frmLeadDetail').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			lea_ca: {
				validators: {
					notEmpty: {
						message: 'The Campaign is required and can not be empty!'
					},
					stringLength: {
						max: 100,
						message: 'The must be less than 100 characters long.'
					}
				}
			},
			lea_firstName: {
				validators: {
					notEmpty: {
						message: 'The first name is required and can not be empty!'
					},
					stringLength: {
						max: 255,
						message: 'The first name must be less than 255 characters long.'
					}
				}
			},
			lea_lastName: {
				validators: {
					notEmpty: {
						message: 'The last name is required and can not be empty!'
					},
					stringLength: {
						max: 255,
						message: 'The last name must be less than 255 characters long.'
					}
				}
			},
			lea_phone: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The phone must be less than 255 characters long.'
					}
				}
			}
			,
			lea_mobilePhone: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The mobile phone must be less than 255 characters long.'
					}
				}
			},
			lea_title: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The title must be less than 255 characters long.'
					}
				}
			}
			,
			lea_website: {
				validators: {
					uri: {
                        message: 'The website address is not valid.'
                    },
                    stringLength: {
						max: 255,
						message: 'The web site must be less than 255 characters long.'
					}
				}
			}
			,
			lea_department: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The department must be less than 255 characters long.'
					}
				}
			}
			,
			lea_email: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The department must be less than 255 characters long.'
					}
				}
			},
			lea_accountName: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The Company must be less than 255 characters long.'
					}
				}
			},
			lea_no: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The no must be less than 255 characters long.'
					}
				}
			},
			lea_street: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The street must be less than 255 characters long.'
					}
				}
			},
			lea_village: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The village must be less than 255 characters long.'
					}
				}
			}
			,
			lea_commune: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The commune must be less than 255 characters long.'
					}
				}
			},
			lea_district: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The district must be less than 255 characters long.'
					}
				}
			},
			lea_state: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The state must be less than 255 characters long.'
					}
				}
			},
			lea_city: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The city must be less than 255 characters long.'
					}
				}
			},
			lea_country: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The country must be less than 255 characters long.'
					}
				}
			},
			lea_description: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The description must be less than 255 characters long.'
					}
				}
			}
		}
	}).on('success.form.bv', function(e) {
		//var frmNoteData = {"noteId":noteIdEdit,"noteSubject":getValueStringById("note_subject"), "noteDes":getValueStringById("note_description"),"noteRelatedToModuleType":"Lead","noteRelatedToModuleId":leadId,"noteCreateBy":"${SESSION}"};		
		//$(".show-text-detail").find("small").css("margin-left", "30%");
	});
	
	
});


</script>
<style>
.icon_color {
	color: #2196F3;
}

.show-edit{
	width: 70% !important;
	margin: -25px 30% -5px !important;
}
.iTable {
	
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
			<li><a href="${pageContext.request.contextPath}"><i
					class="fa fa-home"></i> Home</a></li>
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
						<h3 class="widget-user-username">{{lead.salutation}} {{lead.firstName}} {{lead.lastName}} </h3>
						<h5 class="widget-user-desc">{{lead.title}}</h5>
					</div>
					<div class="widget-user-image">
						<img class="img-circle"
							src="${pageContext.request.contextPath}/resources/images/user1-128x128.jpg"
							alt="User Avatar">
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="col-sm-3">
								<div class="description-block">
									<h5 class="description-header">{{lead.accountName}}</h5>
									<span class="description-text">Company</span>
								</div>
							</div>
							<div class="col-sm-3 border-right">
								<div class="description-block">
									<h5 class="description-header">{{lead.sourceName}}</h5>
									<span class="description-text">Lead Source</span>
								</div>
							</div>
							<div class="col-sm-3 border-right">
								<div class="description-block">
									<h5 class="description-header">{{lead.assignToUsername}}</h5>
									<span class="description-text">Assign To</span>
								</div>
							</div>
							<div class="col-sm-3 border-right">
								<div class="description-block">
									<h5 class="description-header">{{lead.phone}}</h5>
									<span class="description-text">Tel</span>
								</div>
							</div>

							<div class="col-md-12">
								<ul class="breadcrumb1">
									<li class="completed"><a href="#"><i
											class="fa fa-check-circle"></i> New</a></li>
									<li class="completed"><a href="#"> <i
											class="fa fa-check-circle"></i> Assigned
									</a></li>
									<li class="active"><a href="#"> <i class="fa fa-lock"></i>
											In Process
									</a></li>
									<li><a href="#"> <i class="fa fa-lock"></i> Converted
									</a></li>
									<li class="dead"><a href="#"> <i class="fa fa-lock"></i>
											Dead
									</a></li>
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
										<li class=""><a href="#settings" data-toggle="tab"
											aria-expanded="false">DETAILS</a></li>
										<li class=""><a href="#remark_tab" data-toggle="tab"
											aria-expanded="false">REMARK</a></li>
									</ul>
									<div class="tab-content">
										<div class="tab-pane active" id="activity">
											<div class="row">

												<div class="col-md-12">
													<a class="btn btn-app" ng-click="call_click()"> <span
														class="badge bg-yellow">3</span> <i class="fa fa-phone"></i>
														Call
													</a> <a class="btn btn-app" ng-click="meet_click()"> <span class="badge bg-blue">3</span>
														<i class="fa fa-users"></i> Meeting
													</a> 
													<a class="btn btn-app" ng-click="task_click()"> <span class="badge bg-aqua">3</span>
														<i class="fa fa-list-alt "></i> Task
													</a> 
													<a class="btn btn-app" ng-click="event_click()"> <span
														class="badge bg-light-blue">3</span> <i
														class="fa  fa-calendar-check-o"></i> Event
													</a> 
													<a class="btn btn-app" ng-click="email_click()"> <span class="badge bg-green">3</span>
														<i class="fa fa-envelope"></i> Email
													</a>
												</div>

												<div class="col-md-12">
													<div class="col-md-2">
														<div class="form-group">
															<select style="margin-left: -5px;" class="form-control"
																name="show_activity" id="show_activity">
																<option value="All">All</option>
																<option value="Call">Call</option>
																<option value="Meeting">Meeting</option>
																<option value="Task">Task</option>
																<option value="Event">Event</option>
																<option value="Email">Email</option>
															</select>
														</div>
													</div>
												</div>

												<div class="col-md-12">

													<div class="mailbox-messages">
														<table class="table table-hover table-striped">
															<tbody>
																<tr>
																	<td class="mailbox-star "><a href="#"><i
																			class="fa fa-phone text-yellow font-size-icon-30"></i></a></td>
																	<td><b>Call</b></td>
																	<td class="mailbox-name "><a href="read-mail.html">Alexander
																			Pierce</a></td>
																	<td class="mailbox-subject "><b>AdminLTE 2.0
																			Issue</b> - Trying to find a solution to this problem...</td>

																	<td class="mailbox-date"><div class="col-sm-2">
																			<div class="btn-group">
																				<button type="button"
																					class="btn btn-default dropdown-toggle"
																					data-toggle="dropdown" aria-expanded="false">
																					<span class="caret"></span> <span class="sr-only">Toggle
																						Dropdown</span>
																				</button>
																				<ul class="dropdown-menu" role="menu">
																					<li><a
																						href="${pageContext.request.contextPath}/update-lead/{{cc.leadID}}"><i
																							class="fa fa-pencil"></i> Edit</a></li>
																					<li ng-click="deleteLead(cc.leadID)"><a
																						href="#"><i class="fa fa-trash"></i> Delete</a></li>
																					<li><a
																						href="${pageContext.request.contextPath}/view-leads/{{cc.leadID}}"><i
																							class="fa fa-eye"></i> View</a></li>

																				</ul>
																			</div>
																		</div></td>
																</tr>
																<tr>
																	<td class="mailbox-star"><a href="#"><i
																			class="fa fa-users text-blue font-size-icon-30"></i></a></td>
																	<td><b>Meeting</b></td>
																	<td class="mailbox-name"><a href="read-mail.html">Alexander
																			Pierce</a></td>
																	<td class="mailbox-subject"><b>AdminLTE 2.0
																			Issue</b> - Trying to find a solution to this problem...</td>

																	<td class="mailbox-date"><div class="col-sm-2">
																			<div class="btn-group">
																				<button type="button"
																					class="btn btn-default dropdown-toggle"
																					data-toggle="dropdown" aria-expanded="false">
																					<span class="caret"></span> <span class="sr-only">Toggle
																						Dropdown</span>
																				</button>
																				<ul class="dropdown-menu" role="menu">
																					<li><a
																						href="${pageContext.request.contextPath}/update-lead/{{cc.leadID}}"><i
																							class="fa fa-pencil"></i> Edit</a></li>
																					<li ng-click="deleteLead(cc.leadID)"><a
																						href="#"><i class="fa fa-trash"></i> Delete</a></li>
																					<li><a
																						href="${pageContext.request.contextPath}/view-leads/{{cc.leadID}}"><i
																							class="fa fa-eye"></i> View</a></li>

																				</ul>
																			</div>
																		</div></td>
																</tr>
																<tr>
																	<td class="mailbox-star"><a href="#"><i
																			class="fa fa-list-alt text-aqua font-size-icon-30"></i></a></td>
																	<td><b>Task</b></td>
																	<td class="mailbox-name"><a href="read-mail.html">Alexander
																			Pierce</a></td>
																	<td class="mailbox-subject"><b>AdminLTE 2.0
																			Issue</b> - Trying to find a solution to this problem...</td>

																	<td class="mailbox-date"><div class="col-sm-2">
																			<div class="btn-group">
																				<button type="button"
																					class="btn btn-default dropdown-toggle"
																					data-toggle="dropdown" aria-expanded="false">
																					<span class="caret"></span> <span class="sr-only">Toggle
																						Dropdown</span>
																				</button>
																				<ul class="dropdown-menu" role="menu">
																					<li><a
																						href="${pageContext.request.contextPath}/update-lead/{{cc.leadID}}"><i
																							class="fa fa-pencil"></i> Edit</a></li>
																					<li ng-click="deleteLead(cc.leadID)"><a
																						href="#"><i class="fa fa-trash"></i> Delete</a></li>
																					<li><a
																						href="${pageContext.request.contextPath}/view-leads/{{cc.leadID}}"><i
																							class="fa fa-eye"></i> View</a></li>

																				</ul>
																			</div>
																		</div></td>
																</tr>
																<tr>
																	<td class="mailbox-star"><a href="#"><i
																			class="fa fa-envelope text-green font-size-icon-30"></i></a></td>
																	<td><b>Email</b></td>
																	<td class="mailbox-name"><a href="read-mail.html">Alexander
																			Pierce</a></td>
																	<td class="mailbox-subject"><b>AdminLTE 2.0
																			Issue</b> - Trying to find a solution to this problem...</td>

																	<td class="mailbox-date"><div class="col-sm-2">
																			<div class="btn-group">
																				<button type="button"
																					class="btn btn-default dropdown-toggle"
																					data-toggle="dropdown" aria-expanded="false">
																					<span class="caret"></span> <span class="sr-only">Toggle
																						Dropdown</span>
																				</button>
																				<ul class="dropdown-menu" role="menu">
																					<li><a
																						href="${pageContext.request.contextPath}/update-lead/{{cc.leadID}}"><i
																							class="fa fa-pencil"></i> Edit</a></li>
																					<li ng-click="deleteLead(cc.leadID)"><a
																						href="#"><i class="fa fa-trash"></i> Delete</a></li>
																					<li><a
																						href="${pageContext.request.contextPath}/view-leads/{{cc.leadID}}"><i
																							class="fa fa-eye"></i> View</a></li>

																				</ul>
																			</div>
																		</div></td>
																</tr>
																<tr>
																	<td class="mailbox-star"><a href="#"><i
																			class="fa fa-calendar-check-o text-light-blue font-size-icon-30"></i></a></td>
																	<td><b>Event</b></td>
																	<td class="mailbox-name"><a href="read-mail.html">Alexander
																			Pierce</a></td>
																	<td class="mailbox-subject"><b>AdminLTE 2.0
																			Issue</b> - Trying to find a solution to this problem...</td>

																	<td class="mailbox-date"><div class="col-sm-2">
																			<div class="btn-group">
																				<button type="button"
																					class="btn btn-default dropdown-toggle"
																					data-toggle="dropdown" aria-expanded="false">
																					<span class="caret"></span> <span class="sr-only">Toggle
																						Dropdown</span>
																				</button>
																				<ul class="dropdown-menu" role="menu">
																					<li><a
																						href="${pageContext.request.contextPath}/update-lead/{{cc.leadID}}"><i
																							class="fa fa-pencil"></i> Edit</a></li>
																					<li ng-click="deleteLead(cc.leadID)"><a
																						href="#"><i class="fa fa-trash"></i> Delete</a></li>
																					<li><a
																						href="${pageContext.request.contextPath}/view-leads/{{cc.leadID}}"><i
																							class="fa fa-eye"></i> View</a></li>

																				</ul>
																			</div>
																		</div></td>
																</tr>


															</tbody>
														</table>
														<!-- /.table -->
													</div>

												</div>


											</div>

										</div>



										<div class="tab-pane" id="collaborate">

											<div class="col-md-12"></div>

											<div class="post clearfix">
												<textarea rows="3" cols="" name="post_des" id="post_des"
													class="form-control" placeholder="Post"></textarea>
												<button style="margin-top: 10px;"
													class="btn btn-primary pull-right">POST</button>
											</div>
											<div class="post clearfix">
												<div class="user-block">
													<img class="img-circle img-bordered-sm"
														src="${pageContext.request.contextPath}/resources/images/user1-128x128.jpg"
														alt="user image"> <span class="username"> <a
														href="#">Jonathan Burke Jr.</a> <a href="#"
														class="pull-right btn-box-tool"><i class="fa fa-times"></i></a>
													</span> <span class="description">Shared publicly - 7:30 PM
														today</span>
												</div>
												<!-- /.user-block -->
												<p>Lorem ipsum represents a long-held tradition for
													designers, typographers and the like. Some people hate it
													and argue for its demise, but others ignore the hate as
													they create awesome tools to help create filler text for
													everyone from bacon lovers to Charlie Sheen fans.</p>
												<ul class="list-inline">

													<li><a href="#" class="link-black text-sm"><i
															class="fa fa-thumbs-o-up margin-r-5"></i> Like</a></li>
													<li class="pull-right"><a href="#"
														class="link-black text-sm"><i
															class="fa fa-comments-o margin-r-5"></i> Comments (5)</a></li>
												</ul>

												<input class="form-control input-sm" type="text"
													placeholder="Type a comment">
											</div>
											<div class="post clearfix">
												<div class="user-block">
													<img class="img-circle img-bordered-sm"
														src="${pageContext.request.contextPath}/resources/images/user1-128x128.jpg"
														alt="user image"> <span class="username"> <a
														href="#">Jonathan Burke Jr.</a> <a href="#"
														class="pull-right btn-box-tool"><i class="fa fa-times"></i></a>
													</span> <span class="description">Shared publicly - 7:30 PM
														today</span>
												</div>
												<!-- /.user-block -->
												<p>Lorem ipsum represents a long-held tradition for
													designers, typographers and the like. Some people hate it
													and argue for its demise, but others ignore the hate as
													they create awesome tools to help create filler text for
													everyone from bacon lovers to Charlie Sheen fans.</p>
												<ul class="list-inline">

													<li><a href="#" class="link-black text-sm"><i
															class="fa fa-thumbs-o-up margin-r-5"></i> Like</a></li>
													<li class="pull-right"><a href="#"
														class="link-black text-sm"><i
															class="fa fa-comments-o margin-r-5"></i> Comments (2)</a></li>
												</ul>
												<div class="box-footer box-comments">
													<div class="box-comment">
														<!-- User image -->
														<img class="img-circle img-sm"
															src="${pageContext.request.contextPath}/resources/images/user1-128x128.jpg"
															alt="user image">
														<div class="comment-text">
															<span class="username"> Maria Gonzales <span
																class="text-muted pull-right">8:03 PM Today</span>
															</span>
															<!-- /.username -->
															It is a long established fact that a reader will be
															distracted by the readable content of a page when looking
															at its layout.
														</div>
														<!-- /.comment-text -->
													</div>
													<!-- /.box-comment -->
													<div class="box-comment">
														<!-- User image -->
														<img class="img-circle img-sm"
															src="${pageContext.request.contextPath}/resources/images/user1-128x128.jpg"
															alt="user image">
														<div class="comment-text">
															<span class="username"> Luna Stark <span
																class="text-muted pull-right">8:03 PM Today</span>
															</span>
															<!-- /.username -->
															It is a long established fact that a reader will be
															distracted by the readable content of a page when looking
															at its layout.
														</div>
														<!-- /.comment-text -->
													</div>
													<!-- /.box-comment -->
												</div>
												<input class="form-control input-sm" type="text"
													placeholder="Type a comment">
											</div>
										</div>

										<div class="tab-pane" id="note_tap" data-ng-init="listNote()">
											<div class="post clearfix">
											<form id="frmAddNote">
												<div class="form-group">
													<input ng-model="note_subject" data-ng-init="note_subject" style="margin-top: 10px;" type="text" class="form-control"  name="note_subject" id="note_subject"
																placeholder="Subject">
												</div>
												<div class="form-group">
													<textarea ng-model="note_description" data-ng-init="note_description" style="margin-top: 10px;" rows="3" cols="" name="note_description" id="note_description" class="form-control" placeholder="Description"></textarea>
												</div>
												<button style="margin-top: 10px; margin-left:10px;" ng-click="resetFrmNote()" type="button" ng-click="resetNote()" class="btn btn-danger pull-right">Reset</button>
												<button style="margin-top: 10px;" type="button" id="btnAddNote" ng-click="addNote()" class="btn btn-primary pull-right">Note</button>
											</form>
											</div>
											<div class="clearfix"></div>
											<ul class="timeline timeline-inverse"  ng-repeat="notePerDate in noteToFilter() | filter:filterNote">
												
												<!-- START DATE -->
												<li class="time-label">
													<span class="bg-red">{{notePerDate.noteCreateDate}}</span>
												</li>
												<li ng-repeat="note in notes | filter:{noteCreateDate: notePerDate.noteCreateDate}">
													<i class="fa  fa-edit bg-blue"></i>
													<div class="timeline-item">
														<span class="time"><i class="fa fa-clock-o"></i> &nbsp;{{notePerDate.noteTime}}</span>
														<h3 class="timeline-header">{{note.noteSubject}} <a>by {{note.noteCreateBy}}</a></h3>
														<div class="timeline-body">{{note.noteDes}}</div>
														<div class="timeline-footer">
															<a class="btn btn-primary btn-xs" ng-click="editNoteById(note.noteId)">Edit</a> 
															<a class="btn btn-danger btn-xs" ng-click="deleteNoteById(note.noteId)">Delete</a>
														</div>
													</div>
												</li>
												
												
											</ul>
										</div>


										<div class="tab-pane " id="settings">
											<div class="row">
												<form id="frmLeadDetail">
												<div class="col-md-4">
													<ul class="list-group list-group-unbordered">
														<li class="list-group-item"><b>Overview</b> <a
															class="pull-right cusor_pointer" ng-click="editDetailLead()"><i
																class="fa fa-pencil"></i> Edit</a></li>
														<li class="list-group-item item_border">
																Salutation
															<a class="pull-right show-text-detail">{{lead.salutation}}</a>
															<div class="form-group show-edit" style="display:none;" >																							
																<select class="form-control" name="leadSalutation" id="leadSalutation">		                                      
							                                       <option value="Mr.">Mr.</option>
							                                       <option value="Ms.">Ms.</option>
							                                       <option value="Mrs.">Mrs.</option>
							                                       <option value="Dr.">Dr.</option>
							                                       <option value="Prof.">Prof.</option>
							                                    </select>
															</div>
														</li>
														
														<li class="list-group-item item_border">First Name 
															<a class="pull-right show-text-detail">{{lead.firstName}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_firstName" id="lea_firstName" class="form-control" value="{{lead.firstName}}">																						
																<div class="clearfix"></div>
															</div>
														</li>
														<li class="list-group-item item_border">Last Name 
															<a class="pull-right show-text-detail">{{lead.lastName}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_lastName" id="lea_lastName" class="form-control" value="{{lead.lastName}}">	
															</div>
														</li>
														<li class="list-group-item item_border">Title 
															<a class="pull-right show-text-detail">{{lead.title}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_title" id="lea_title" class="form-control" value="{{lead.title}}">	
															</div>
														</li>
														<li class="list-group-item item_border">Department 
															<a class="pull-right show-text-detail">{{lead.department}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_department" id="lea_department" class="form-control" value="{{lead.department}}">	
															</div>
														</li>
														<li class="list-group-item item_border">Company
															<a class="pull-right show-text-detail">{{lead.accountName}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_accountName" id="lea_accountName" class="form-control" value="{{lead.accountName}}">		
															</div>
														</li>
														<li class="list-group-item item_border">Phone
															<a class="pull-right show-text-detail">{{lead.phone}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_phone" id="lea_phone" class="form-control" value="{{lead.phone}}">		
															</div>
														</li>
														<li class="list-group-item item_border">Mobile
															<a class="pull-right show-text-detail">{{lead.mobile}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_mobilePhone" id="lea_mobilePhone" class="form-control" value="{{lead.mobile}}">		
															</div>
														</li>
														<li class="list-group-item item_border">Web Site
															<a class="pull-right show-text-detail">{{lead.website}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_website" id="lea_website" class="form-control" value="{{lead.website}}">		
															</div>
														</li>
														<li class="list-group-item item_border">Email
															<a class="pull-right show-text-detail">{{lead.email}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_email" id="lea_email"class="form-control" value="{{lead.email}}">		
															</div>
														</li>
													</ul>
												</div>
												<div class="col-md-4">
													<ul class="list-group list-group-unbordered">
														<li class="list-group-item"><b>Address</b> <a
															class="pull-right cusor_pointer"><i
																class="fa fa-pencil"></i> Edit</a></li>
														<li class="list-group-item item_border">No 
															<a class="pull-right show-text-detail">{{lead.no}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_no" id="lea_no" class="form-control" value="{{lead.no}}">	
															</div>
														</li>
														<li class="list-group-item item_border">Street 
															<a class="pull-right show-text-detail">{{lead.street}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_street" id="lea_street" class="form-control" value="{{lead.street}}">	
															</div>	
														</li>
														<li class="list-group-item item_border">Village
															<a class="pull-right show-text-detail">{{lead.village}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_village" id="lea_village" class="form-control" value="{{lead.village}}">	
															</div>		
														</li>
														<li class="list-group-item item_border">Commune
															<a class="pull-right show-text-detail">{{lead.commune}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_commune" id="lea_commune" class="form-control" value="{{lead.commune}}">	
															</div>
														</li>
														<li class="list-group-item item_border">District
															<a class="pull-right show-text-detail">{{lead.district}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_district" id="lea_district" class="form-control" value="{{lead.district}}">	
															</div>	
														</li>
														<li class="list-group-item item_border">City
															<a class="pull-right show-text-detail">{{lead.city}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_city" id="lea_city" class="form-control" value="{{lead.city}}">	
															</div>	
														</li>
														<li class="list-group-item item_border">State
															<a class="pull-right show-text-detail">{{lead.state}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_state" id="lea_state" class="form-control" value="{{lead.state}}">	
															</div>	
														</li>
														<li class="list-group-item item_border">Country
															<a class="pull-right show-text-detail">{{lead.country}}</a>
															<div class="form-group show-edit" style="display:none;" >
																<input type="text" name="lea_country" id="lea_country" class="form-control" value="{{lead.country}}">	
															</div>	
														</li>
													</ul>
												</div>
												<div class="col-md-4">
													<ul class="list-group list-group-unbordered">
														<li class="list-group-item"><b>More Information &
																Others</b> <a class="pull-right cusor_pointer"><i
																class="fa fa-pencil"></i> Edit</a></li>
														<li class="list-group-item item_border">Status <a
															class="pull-right ">{{lead.statusName}}</a></li>
														<li class="list-group-item item_border">Industry <a
															class="pull-right">{{lead.industName}}</a></li>
														<li class="list-group-item item_border">Source <a
															class="pull-right">{{lead.sourceName}}</a></li>
														<li class="list-group-item item_border">Campaign <a
															class="pull-right">{{lead.campName}}</a></li>
														<li class="list-group-item item_border">Assign To <a
															class="pull-right">{{lead.assignToUsername}}</a></li>
													</ul>
												</div>
												<div class="col-md-12 text-center" id="showBtnEditLead" style="display:none;">
													<button class="btn btn-primary">Save</button>
													<button class="btn btn-danger">Cancel</button>
												</div>
												</form>

											</div>
										</div>

										<div class="tab-pane" id="remark_tab">
											<div class="row">

												<div class="col-md-12">
													<ul class="list-group list-group-unbordered">
														<li style="border-top: 0px;" class="list-group-item"><b>Description</b>
															<a class="pull-right cusor_pointer"><i
																class="fa fa-pencil"></i> Edit</a></li>

													</ul>
												</div>
												<div class="col-md-12">{{lead.description}}</div>
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


	<input type="hidden" id="btn_show_call" data-toggle="modal"
		data-target="#frmCall" />
	<div class="modal fade modal-default" id="frmCall" role="dialog">
		<div class="modal-dialog  modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Create Call</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div class="col-md-6">
								<div class="form-group">
									<label>Subject <span class="requrie">(Required)</span></label>
									<input id="txtDisInv" class="form-control" type="text"
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
										<input data-date-format="dd-M-yyyy" data-default-date=""
											value="" name="startDate" id="startDate" type="text"
											class="form-control pull-right active">
									</div>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="bootstrap-timepicker">
									<div class="form-group">
										<label>Duration <span class="requrie">(Required)</span></label>
										<div class="input-group">
											<input type="text" class="form-control timepicker"
												name="duration" id="duration">
											<div class="input-group-addon">
												<i class="fa fa-clock-o"></i>
											</div>

										</div>
										<!-- /.input group -->
									</div>
									<!-- /.form group -->
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Assign To </label>
									<select class="form-control select2"  name="assignTo" id="assignTo" style="width: 100%;">
				                      <option value=""></option>           
				                    </select>
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
									<label>Status <span class="requrie">(Required)</span></label>
									<select class="form-control select2" name="status" id="status" style="width: 100%;">
										<option value="">--SELECT Status</option>
										<option ng-repeat="st in status" value="{{st.callStatusId}}">{{st.callStatusName}}</option>
									</select>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Description </label>
									<textarea  rows="4" cols="" name="description" id="description"	class="form-control"></textarea>
								</div>
							</div>
						</div>
					</div>



				</div>
				<div class="modal-footer">
					<button type="button" id="btnSaveCallCancel" class="btn btn-danger"
						data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" id="btnSaveCall"
						class="btn btn-primary pull-right" data-dismiss="modal">Save</button>

				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="btn_show_meet" data-toggle="modal"
		data-target="#frmMeet" />
	<div class="modal fade modal-default" id="frmMeet" role="dialog">
		<div class="modal-dialog  modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Create Meeting</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div class="col-md-6">
								<div class="form-group">
									<label>Subject <span class="requrie">(Required)</span></label>
									<input id="txtDisInv" class="form-control" type="text"
										placeholder="">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Duration <span class="requrie">(Required)</span></label>
									<select class="form-control select2"  name="me_duration" id="me_duration" style="width: 100%;">
				                      <option value="">--Select Duration--</option>   
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
										<input data-date-format="dd-M-yyyy HH:mm:ss" data-default-date=""
											value="" name="startDateMeeting" id="startDateMeeting" type="text"
											class="form-control pull-right active">
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
										<input data-date-format="dd-M-yyyy HH:mm:ss" data-default-date=""
											value="" name="endDateMeeting" id="endDateMeeting" type="text"
											class="form-control pull-right active">
									</div>
								</div>
							</div>
							
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Assign To </label>
									<select class="form-control select2"  name="assignTo" id="assignTo" style="width: 100%;">
				                      <option value=""></option>           
				                    </select>
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
									<label>Status</label>
									<select class="form-control select2" name="status" id="status" style="width: 100%;">
										<option value="">--SELECT Status</option>
										<option ng-repeat="st in status" value="{{st.callStatusId}}">{{st.callStatusName}}</option>
									</select>
								</div>
							</div>
							
							<div class="clearfix"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Location </label>
									<input id="txtDisInv" class="form-control" type="text"
										placeholder="">
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Description </label>
									<textarea  rows="4" cols="" name="description" id="description"	class="form-control"></textarea>
								</div>
							</div>
						</div>
					</div>



				</div>
				<div class="modal-footer">
					<button type="button" id="btnSaveCallCancel" class="btn btn-danger"
						data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" id="btnSaveCall"
						class="btn btn-primary pull-right" data-dismiss="modal">Save</button>

				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="btn_show_task" data-toggle="modal"
		data-target="#frmTask" />
	<div class="modal fade modal-default" id="frmTask" role="dialog">
		<div class="modal-dialog  modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Create Task</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div class="col-md-6">
								<div class="form-group">
									<label>Subject <span class="requrie">(Required)</span></label>
									<input id="txtDisInv" class="form-control" type="text"
										placeholder="">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Priority <span class="requrie">(Required)</span></label>
									<select class="form-control select2"  name="ts_priority" id="ts_priority" style="width: 100%;">
				                      <option value="">--Select Priority--</option>   
				                      <option value="High">High</option>
				                      <option value="Medium">Medium</option>
				                      <option value="Low">Low</option> 
				                            
				                    </select>
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
										<input data-date-format="dd-M-yyyy HH:mm:ss" data-default-date=""
											value="" name="startDateMeeting" id="startDateMeeting" type="text"
											class="form-control pull-right active">
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
										<input data-date-format="dd-M-yyyy HH:mm:ss" data-default-date=""
											value="" name="endDateMeeting" id="endDateMeeting" type="text"
											class="form-control pull-right active">
									</div>
								</div>
							</div>
							
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Assign To </label>
									<select class="form-control select2"  name="assignTo" id="assignTo" style="width: 100%;">
				                      <option value=""></option>           
				                    </select>
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
									<label>Status</label>
									<select class="form-control select2" name="status" id="status" style="width: 100%;">
										<option value="">--SELECT Status</option>
										<option ng-repeat="st in status" value="{{st.callStatusId}}">{{st.callStatusName}}</option>
									</select>
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
									<label>Contact</label>
									<select class="form-control select2" name="status" id="status" style="width: 100%;">
										<option value="">--SELECT Contact</option>
										<option ng-repeat="st in status" value="{{st.callStatusId}}">{{st.callStatusName}}</option>
									</select>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Description </label>
									<textarea  rows="4" cols="" name="description" id="description"	class="form-control"></textarea>
								</div>
							</div>
						</div>
					</div>



				</div>
				<div class="modal-footer">
					<button type="button" id="btnSaveCallCancel" class="btn btn-danger"
						data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" id="btnSaveCall"
						class="btn btn-primary pull-right" data-dismiss="modal">Save</button>

				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="btn_show_event" data-toggle="modal"
		data-target="#frmEvent" />
	<div class="modal fade modal-default" id="frmEvent" role="dialog">
		<div class="modal-dialog  modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Create Event</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div class="col-md-6">
								<div class="form-group">
									<label>Subject <span class="requrie">(Required)</span></label>
									<input id="txtDisInv" class="form-control" type="text"
										placeholder="">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Duration <span class="requrie">(Required)</span></label>
									<select class="form-control select2"  name="me_duration" id="me_duration" style="width: 100%;">
				                      <option value="">--Select Duration--</option>   
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
										<input data-date-format="dd-M-yyyy HH:mm:ss" data-default-date=""
											value="" name="startDateMeeting" id="startDateMeeting" type="text"
											class="form-control pull-right active">
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
										<input data-date-format="dd-M-yyyy HH:mm:ss" data-default-date=""
											value="" name="endDateMeeting" id="endDateMeeting" type="text"
											class="form-control pull-right active">
									</div>
								</div>
							</div>
							
							<div class="clearfix"></div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Assign To </label>
									<select class="form-control select2"  name="assignTo" id="assignTo" style="width: 100%;">
				                      <option value=""></option>           
				                    </select>
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
									<label>Budget</label>
									<input id="txtDisInv" class="form-control" type="text"
										placeholder="">
								</div>
							</div>
							
							<div class="clearfix"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Location </label>
									<select class="form-control select2"  name="assignTo" id="assignTo" style="width: 100%;">
				                      <option value=""></option>           
				                    </select>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label>Description </label>
									<textarea  rows="4" cols="" name="description" id="description"	class="form-control"></textarea>
								</div>
							</div>
						</div>
					</div>



				</div>
				<div class="modal-footer">
					<button type="button" id="btnSaveCallCancel" class="btn btn-danger"
						data-dismiss="modal">Cancel</button>
					&nbsp;&nbsp;
					<button type="button" id="btnSaveCall"
						class="btn btn-primary pull-right" data-dismiss="modal">Save</button>

				</div>
			</div>
		</div>
	</div>
	<div id="errors"></div>
</div>

<jsp:include page="${request.contextPath}/footer"></jsp:include>
<script src="${pageContext.request.contextPath}/resources/js.mine/function.mine.js"></script>


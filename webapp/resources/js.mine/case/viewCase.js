
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
		    url: '${pageContext.request.contextPath}/case/view/'+username+"/"+oppId,
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

function displayStatusLead(Status){	
	var obj = "";	
	for(var i=1; i<=leadStatusData.length; i++){		
		if(i<Status){		
			obj += "<li onClick='clickStatus("+i+")' class='completed'><a href='#'><i class='fa fa-check-circle'></i> "+leadStatusData[i-1].statusName+"</a></li>";	
		}else if(i==Status){			
			/* if(Status == 5){
				obj += "<li onClick='clickStatus("+i+")' class='dead'><a href='#'><i class='fa fa-check-circle'></i> "+leadStatusData[i-1].statusName+"</a></li>";
			}else{ */
				obj += "<li onClick='clickStatus("+i+")' class='active'><a href='#'><i class='fa fa-check-circle'></i> "+leadStatusData[i-1].statusName+"</a></li>";
			//}
		}else{
			obj += "<li onClick='clickStatus("+i+")' class=''>         <a href='#'><i class='fa fa-lock'></i> "+leadStatusData[i-1].statusName+"</a></li>";
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




var callStartDateOld = "";
var ckTextarea = "";
$(function(){
	ckTextarea = CKEDITOR.replace('ca_resolution');	
	
	$("#ca_article").prop("disabled", true);
	$("#collabTags").select2();
	
	
	$("#callDuration").timepicker({
		format: 'h:mm',
        showInputs: false,
        minuteStep: 5,
        defaultTime: false,
        showMeridian : false
    }).on('change', function(e) {
     	$('#frmAddCall').bootstrapValidator('revalidateField', 'callDuration');
 	});
	
	$('#oppCloseDate').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY'
    }).on('change', function(e) {
     	$('#frmOpportDetail').bootstrapValidator('revalidateField', 'oppCloseDate');
 	});
	
	$('#').daterangepicker({
        format: 'DD/MM/YYYY h:mm A',
        singleDatePicker: true,
        showDropdowns: true,
        timePicker: true, 
        timePickerIncrement: 5,
    }).on('change', function(e) {
    	var date = getValueStringById("callStartDate");
    	if(date === ""){
    		setValueById("callStartDate",callStartDateOld);    	
    		$('#frmAddCall').data('bootstrapValidator').resetField($('#callStartDate'));
    	}else{
    		callStartDateOld = date;
    	}
     	$('#frmAddCall').bootstrapValidator('revalidateField', 'callStartDate');
 	});
	
	$('#ca_resolvedDate').daterangepicker({
        format: 'DD/MM/YYYY h:mm A',
        singleDatePicker: true,
        showDropdowns: true,
        timePicker: true, 
        timePickerIncrement: 5,
    }).on('change', function(e) {
     	$('#frmResolution').bootstrapValidator('revalidateField', 'ca_resolvedDate');
 	});
	
	//$("#ca_resolvedBy").select2("val", var_ResolvedBy);
	
	$('.meet-data-time').daterangepicker({
        format: 'DD/MM/YYYY h:mm A',
        singleDatePicker: true,
        showDropdowns: true,
        timePicker: true, 
        timePickerIncrement: 5,
    }).on('change', function(e) {
     	$('#frmAddMeet').bootstrapValidator('revalidateField', 'meetStartDate');
     	$('#frmAddMeet').bootstrapValidator('revalidateField', 'meetEndDate');
 	});
	
	$('.task-data-time').daterangepicker({
        format: 'DD/MM/YYYY h:mm A',
        singleDatePicker: true,
        showDropdowns: true,
        timePicker: true, 
        timePickerIncrement: 5,
    }).on('change', function(e) {
     	$('#frmAddTask').bootstrapValidator('revalidateField', 'taskStartDate');
     	$('#frmAddTask').bootstrapValidator('revalidateField', 'taskEndDate');
 	});
	
	$('.event-date-time').daterangepicker({
        format: 'DD/MM/YYYY h:mm A',
        singleDatePicker: true,
        showDropdowns: true,
        timePicker: true, 
        timePickerIncrement: 5,
    }).on('change', function(e) {
     	$('#frmAddEvent').bootstrapValidator('revalidateField', 'eventStartDate');
     	$('#frmAddEvent').bootstrapValidator('revalidateField', 'eventEndDate');
 	});
	
	
	$('.task-date').daterangepicker({
        format: 'DD/MM/YYYY',
        singleDatePicker: true,
        showDropdowns: true
    }).on('change', function(e) {
     	$('#frmAddTask').bootstrapValidator('revalidateField', 'taskStartDate');
     	$('#frmAddTask').bootstrapValidator('revalidateField', 'taskEndDate');
 	});
	
	
	$('#frmResolution').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			ca_resolvedBy: {
				validators: {
					notEmpty: {
						message: 'The resolved by is required and can not be empty!'
					}
				}
			},
			ca_resolvedDate: {
				validators: {
					notEmpty: {
						message: 'The resolved date is required and can not be empty!'
					},
					date: {
                        format: 'DD/MM/YYYY h:mm A',
                        message: 'The value is not a valid date'
                    }
				}
			}
		}
	});
	
	$('#frmEscalateTo').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			ca_escalateTo: {
				validators: {
					notEmpty: {
						message: 'The escalate to is required and can not be empty!'
					}
				}
			},
			ca_escalateStatus: {
				validators: {
					notEmpty: {
						message: 'The escalate status is required and can not be empty!'
					}
				}
			}
		}
	});
	
	
	
	
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
		
		if($("#btnAddNote").text() == 'Note'){		
			if(getPermissionByModule("AC_NO","create") == "YES" || checkAssignTo() || checkOwner()){
				swal({   
					title: "<span style='font-size: 25px;'>You are about to create note.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url: server+"/note/add", 
						    type: 'POST',
						    data: JSON.stringify({			    	
						    	"noteId":noteIdEdit,"noteSubject":getValueStringById("note_subject"), 
						    	"noteDes":getValueStringById("note_description"),"noteRelatedToModuleType":typeModule,
						    	"noteRelatedToModuleId":oppId,"noteCreateBy":username			    	
						    }),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){					    						    
								if(result.MESSAGE == "INSERTED"){						
									angular.element(document.getElementById('viewOpportunityController')).scope().resetFrmNote();
						    		angular.element(document.getElementById('viewOpportunityController')).scope().getListNoteByLead();
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
						
		}else if($("#btnAddNote").text()=="Update"){
			
			if(getPermissionByModule("AC_NO","edit") == "YES" || checkAssignTo() || checkOwner()){
				swal({   
					title: "<span style='font-size: 25px;'>You are about to update note.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url: server+"/note/edit", 
						    type: 'PUT',
						    data: JSON.stringify({"noteId":noteIdEdit,"noteSubject":getValueStringById("note_subject"), 
						    	"noteDes":getValueStringById("note_description"),"noteRelatedToModuleType":typeModule,
						    	"noteRelatedToModuleId":oppId,"noteModifyBy":username
						    }),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){					    						    
								if(result.MESSAGE == "UPDATED"){						
									angular.element(document.getElementById('viewOpportunityController')).scope().resetFrmNote();
						    		angular.element(document.getElementById('viewOpportunityController')).scope().getListNoteByLead();		
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
		
	});	
	
	$("#btnCallSave").click(function(){
		$('#frmAddCall').submit();
	});
	
	$('#frmAddCall').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			callSubject: {
				validators: {
					notEmpty: {
						message: 'The subject is required and can not be empty!'
					},
					stringLength: {
						max: 255,
						message: 'The subject must be less than 255 characters long.'
					}
				}
			},
			callStartDate: {
				validators: {
					notEmpty: {
						message: 'The start date is required and can not be empty!'
					},
					date: {
                        format: 'DD/MM/YYYY h:mm A',
                        message: 'The value is not a valid date'
                    }
				}
			},
			callDuration : {
				validators: {
					notEmpty: {
						message: 'The duration is required and can not be empty!'
					},
					stringLength: {
						max: 5,
						message: 'The dubject must be less than 5 characters long.'
					}
				}
			},
			callStatus : {
				validators: {
					notEmpty: {
						message: 'The status is required and can not be empty!'
					}
				}
			},
			callDescription : {
				validators: {
					stringLength: {
						max: 255,
						message: 'The description must be less than 255 characters long.'
					}
				}
			}
			
		}
	}).on('success.form.bv', function(e) {
		if($("#btnCallSave").text() == 'Save'){			
			if(getPermissionByModule("AC_CL","create") == "YES" || checkAssignTo() || checkOwner()){
				
				swal({   
					title: "<span style='font-size: 25px;'>You are about to create call.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url : server+"/call/add",
							type : "POST",
							data : JSON.stringify({ 
							      "startDate": getValueStringById("callStartDate"),
							      "callDuration": getValueStringById("callDuration"),
							      "callCreateBy": username,
							      "callStatus": getJsonById("callStatusId","callStatus","int"),
							      "callDes": getValueStringById("callDescription"),
							      "callSubject": getValueStringById("callSubject"),
							      "callAssignTo": getJsonById("userID","callAssignTo","str"),
							      "callRelatedToFieldId": oppId,
							      "callRelatedToModuleType": typeModule
							      
							}),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){					    						    
								if(result.MESSAGE == "INSERTED"){						
									angular.element(document.getElementById('viewOpportunityController')).scope().listDataCallByRalateType();
									$("#callStatus").select2('val',"");
									$("#callAssignTo").select2('val',"");
									$('#frmAddCall').bootstrapValidator('resetForm', true);
									swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
			    					});			    											
				    				setTimeout(function(){		
				    					$('#frmCall').modal('toggle');		    					
				    				},2000);
																																
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
						
		}else{
			if(getPermissionByModule("AC_CL","edit") == "YES" || checkAssignTo() || checkOwner()){
				swal({   
					title: "<span style='font-size: 25px;'>You are about to update call.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url : server+"/call/edit",
							type : "PUT",
							data : JSON.stringify({ 
								  "callId": callIdForEdit,
								  "startDate": getValueStringById("callStartDate"),
							      "callDuration": getValueStringById("callDuration"),
							      "callDes": getValueStringById("callDescription"),
							      "callSubject": getValueStringById("callSubject"),
							      "callAssignTo": getJsonById("userID","callAssignTo","str"),
							      "callStatus": getJsonById("callStatusId","callStatus","int"),
							      "callRelatedToFieldId": oppId,
							      "callRelatedToModuleType": typeModule,
							      "callModifiedBy" : username
							}),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){					    						    
								if(result.MESSAGE == "UPDATED"){						
									angular.element(document.getElementById('viewOpportunityController')).scope().listDataCallByRalateType();
									$("#callStatus").select2('val',"");
									$("#callAssignTo").select2('val',"");
									$('#frmAddCall').bootstrapValidator('resetForm', true);						
									swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
			    					});
									setTimeout(function(){ $('#frmCall').modal('toggle');}, 2000);
																																
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
	});	
	
	
	
	
	
	
	$("#btnMeetSave").click(function(){
		$('#frmAddMeet').submit();
	});
	
	$('#frmAddMeet').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			meetSubject: {
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
			meetLocation: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The location must be less than 255 characters long!'
					}
				}
			},
			meetStartDate: {
				validators: {
					notEmpty: {
						message: 'The start date is required and can not be empty!'
					},
					date: {
                        format: 'DD/MM/YYYY h:mm A',
                        message: 'The value is not a valid date!'
                    }
				}
			},
			meetEndDate: {
				validators: {
					notEmpty: {
						message: 'The end date is required and can not be empty!'
					},
					date: {
                        format: 'DD/MM/YYYY h:mm A',
                        message: 'The value is not a valid date!'
                    }
				}
			},
			meetDuration : {
				validators: {
					notEmpty: {
						message: 'The duration is required and can not be empty!'
					}
				}
			},
			meetStatus : {
				validators: {
					
				}
			},
			meetDescription : {
				validators: {
					stringLength: {
						max: 1000,
						message: 'The description must be less than 1000 characters long!'
					}
				}
			}
			
		}
	}).on('success.form.bv', function(e) {		
		
		if($("#btnMeetSave").text() == 'Save'){			
			if(getPermissionByModule("AC_ME","create") == "YES" || checkAssignTo() || checkOwner()){
				swal({   
					title: "<span style='font-size: 25px;'>You are about to create meeting.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url : server+"/meeting/add",
							type : "POST",
							data : JSON.stringify({
								  "meetingSubject": getValueStringById("meetSubject"),
							      "meetingAssignTo": getJsonById("userID","meetAssignTo","str"),
							      "meetingDes": getValueStringById("meetDescription"),
							      "startDate": getValueStringById("meetStartDate"),
							      "meetingDuration": getValueStringById("meetDuration"),
							      "endDate":  getValueStringById("meetEndDate"),
							      "meetingStatus": getJsonById("statusId","meetStatus","int"),
							      "meetingLocation":  getValueStringById("meetLocation"),
							      "meetingRelatedToModuleType": typeModule,
							      "meetingRelatedToModuleId": oppId,
							      "meetingCreateBy": username
							}),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){					    						    
								if(result.MESSAGE == "INSERTED"){						
									angular.element(document.getElementById('viewOpportunityController')).scope().listDataMeetByRalateType();
									$("#meetStatus").select2('val',"");
									$("#meetAssignTo").select2('val',"");	
									$("#meetDuration").select2('val',"");
									$('#frmAddMeet').bootstrapValidator('resetForm', true);
									swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
			    					});			    											
				    				setTimeout(function(){	 $('#frmMeet').modal('toggle');	},2000);
																																
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
						
		}else{
			if(getPermissionByModule("AC_ME","edit") == "YES" || checkAssignTo() || checkOwner()){
				swal({   
					title: "<span style='font-size: 25px;'>You are about to update meeting.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url : server+"/meeting/edit",
							type : "PUT",
							data : JSON.stringify({
								  "meetingId": meetIdForEdit,
								  "meetingSubject": getValueStringById("meetSubject"),				     
							      "meetingDes": getValueStringById("meetDescription"),
							      "startDate": getValueStringById("meetStartDate"),
							      "meetingDuration": getValueStringById("meetDuration"),
							      "endDate":  getValueStringById("meetEndDate"),
							      "meetingStatus": getJsonById("statusId","meetStatus","int"),
							      "meetingAssignTo": getJsonById("userID","meetAssignTo","str"),
							      "meetingLocation":  getValueStringById("meetLocation"),
							      "meetingRelatedToModuleType": typeModule,
							      "meetingRelatedToModuleId": oppId,
							      "meetingModifiedBy" : username
							}),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){					    						    
								if(result.MESSAGE == "UPDATED"){						
									angular.element(document.getElementById('viewOpportunityController')).scope().listDataMeetByRalateType();
									$("#meetStatus").select2('val',"");
									$("#meetAssignTo").select2('val',"");	
									$("#meetDuration").select2('val',"");
									$('#frmAddMeet').bootstrapValidator('resetForm', true);					
									swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
			    					});
									setTimeout(function(){ $('#frmMeet').modal('toggle');}, 2000);
																																
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
		
	});	
	
	
	$("#btnTaskSave").click(function(){
		$('#frmAddTask').submit();
	});
	
	$('#frmAddTask').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			taskSubject: {
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
			taskStartDate: {
				validators: {
					date: {
                        format: 'DD/MM/YYYY h:mm A',
                        message: 'The value is not a valid date!'
                    }
				}
			},
			taskEndDate: {
				validators: {
					date: {
                        format: 'DD/MM/YYYY h:mm A',
                        message: 'The value is not a valid date!'
                    }
				}
			},
			taskPriority : {
				validators: {
					notEmpty: {
						message: 'The priority is required and can not be empty!'
					}
				}
			},
			taskStatus : {
				validators: {
					notEmpty: {
						message: 'The status is required and can not be empty!'
					}
				}
			},
			taskDescription : {
				validators: {
					stringLength: {
						max: 1000,
						message: 'The description must be less than 1000 characters long!'
					}
				}
			}
			
		}
	}).on('success.form.bv', function(e) {
		
		
		if($("#btnTaskSave").text() == 'Save'){			
			if(getPermissionByModule("AC_TA","create") == "YES" || checkAssignTo() || checkOwner()){
				swal({   
					title: "<span style='font-size: 25px;'>You are about to create task.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url : server+"/task/add",
							type : "POST",
							data : JSON.stringify({
							      "taskStatus": getJsonById("taskStatusId","taskStatus","int"),
							      "taskPriority": getValueStringById("taskPriority"),
							      "taskAssignTo": getJsonById("userID","taskAssignTo","str"),
							      "taskRelatedToId": oppId,
							      "taskRelatedToModule": typeModule,
							      "taskDes": getValueStringById("taskDescription"),
							      "dueDate": getValueStringById("taskEndDate"),
							      "taskSubject":  getValueStringById("taskSubject"),
							      "startDate":  getValueStringById("taskStartDate"),
							      "taskContact": getJsonById("conID","taskContact","str"),
							      "taskCreateBy": username					      
							}),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){					    						    
								if(result.MESSAGE == "INSERTED"){						
									angular.element(document.getElementById('viewOpportunityController')).scope().listDataTaskByRalateType();
									$("#taskStatus").select2('val',"");
									$("#taskAssignTo").select2('val',"");	
									$("#taskPriority").select2('val',"");
									$("#taskContact").select2('val',"");
									$('#frmAddTask').bootstrapValidator('resetForm', true);	
									swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
			    					});			    											
				    				setTimeout(function(){	 $('#frmTask').modal('toggle');	},2000);
																																
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
						
		}else{
			if(getPermissionByModule("AC_TA","edit") == "YES" || checkAssignTo() || checkOwner()){
				swal({   
					title: "<span style='font-size: 25px;'>You are about to update task.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url : server+"/task/edit",
							type : "PUT",
							data : JSON.stringify({
								  "taskId" : taskIdForEdit,					 
							      "taskPriority": getValueStringById("taskPriority"),				      
							      "taskRelatedToId": oppId,
							      "taskRelatedToModule": typeModule,
							      "taskDes": getValueStringById("taskDescription"),
							      "dueDate": getValueStringById("taskEndDate"),
							      "taskSubject":  getValueStringById("taskSubject"),
							      "startDate":  getValueStringById("taskStartDate"),
							      "taskContact": getJsonById("conID","taskContact","str"),
							      "taskStatus": getJsonById("taskStatusId","taskStatus","int"),
							      "taskAssignTo": getJsonById("userID","taskAssignTo","str"),
							      "taskModifiedBy": username
							}),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){					    						    
								if(result.MESSAGE == "UPDATED"){						
									angular.element(document.getElementById('viewOpportunityController')).scope().listDataTaskByRalateType();
									$("#taskStatus").select2('val',"");
									$("#taskAssignTo").select2('val',"");	
									$("#taskPriority").select2('val',"");
									$("#taskContact").select2('val',"");
									$('#frmAddTask').bootstrapValidator('resetForm', true);					
									swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
			    					});
									setTimeout(function(){ $('#frmTask').modal('toggle');}, 2000);
																																
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
		
		
	});	
	
	
	$("#btnEventSave").click(function(){
		$('#frmAddEvent').submit();
	});
	
	$('#frmAddEvent').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			eventSubject: {
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
			eventLocation: {
				
			},
			eventStartDate: {
				validators: {
					notEmpty: {
						message: 'The start date is required and can not be empty!'
					},
					date: {
                        format: 'DD/MM/YYYY h:mm A',
                        message: 'The value is not a valid date!'
                    }
				}
			},
			eventEndDate: {
				validators: {
					notEmpty: {
						message: 'The end date is required and can not be empty!'
					},
					date: {
                        format: 'DD/MM/YYYY h:mm A',
                        message: 'The value is not a valid date!'
                    }
				}
			},
			eventDuration : {
				validators: {
					notEmpty: {
						message: 'The duration is required and can not be empty!'
					}
				}
			},
			eventDescription : {
				validators: {
					stringLength: {
						max: 1000,
						message: 'The description must be less than 1000 characters long!'
					}
				}
			},			
			eventBudget : {
				validators: {
					numeric: {
                        message: 'The value is not a number',
                        thousandsSeparator: '',
                        decimalSeparator: '.'
                    }
				}
			}
			
		}
	}).on('success.form.bv', function(e) {
		
		if($("#btnEventSave").text() == 'Save'){			
			if(getPermissionByModule("AC_EV","create") == "YES" || checkAssignTo() || checkOwner()){
				swal({   
					title: "<span style='font-size: 25px;'>You are about to create event.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url : server+"/event/add",
							type : "POST",
							data : JSON.stringify({
							      "evName": getValueStringById("eventSubject"),				     
							      "evBudget": getValueStringById("eventBudget"),
							      "evDes": getValueStringById("eventDescription"),
							      "evCreateBy":  username,
							      "evDuration": getValueStringById("eventDuration"),
							      "startDate": getValueStringById("eventStartDate"),
							      "endDate": getValueStringById("eventEndDate"),
							      "assignTo": getJsonById("userID","eventAssignTo","str"),
							      "evlocation": getJsonById("loId","eventLocation","str"),
							      "evRelatedToModuleId" : oppId,
							      "evRelatedToModuleType" : typeModule
							}),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){					    						    
								if(result.MESSAGE == "INSERTED"){						
									angular.element(document.getElementById('viewOpportunityController')).scope().listDataEventByRalateType();						
									
									$("#eventDuration").select2('val',"");
									$("#eventAssignTo").select2('val',"");	
									$("#eventLocation").select2('val',"");
									
									$('#frmAddEvent').bootstrapValidator('resetForm', true);
									swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
			    					});			    											
				    				setTimeout(function(){	 $('#frmEvent').modal('toggle');	},2000);
																																
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
						
		}else{
			if(getPermissionByModule("AC_EV","edit") == "YES" || checkAssignTo() || checkOwner()){
				swal({   
					title: "<span style='font-size: 25px;'>You are about to update event.</span>",
					text: "Click OK to continue or CANCEL to abort.",
					type: "info",
					html: true,
					showCancelButton: true,
					closeOnConfirm: false,
					showLoaderOnConfirm: true,		
				}, function(){ 
					setTimeout(function(){
						$.ajax({ 
							url : server+"/event/edit",
							type : "PUT",
							data : JSON.stringify({
								  "evId": eventIdForEdit,
								  "evName": getValueStringById("eventSubject"),
							      "evBudget": getValueStringById("eventBudget"),
							      "evDes": getValueStringById("eventDescription"),
							      "evModifiedBy":  username,
							      "evDuration": getValueStringById("eventDuration"),
							      "startDate": getValueStringById("eventStartDate"),
							      "endDate": getValueStringById("eventEndDate"),
							      "assignTo": getJsonById("userID","eventAssignTo","str"),
							      "evlocation": getJsonById("loId","eventLocation","str"),
						    	  "evRelatedToModuleId" : oppId,
							      "evRelatedToModuleType" : typeModule
							}),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){					    						    
								if(result.MESSAGE == "UPDATED"){						
									angular.element(document.getElementById('viewOpportunityController')).scope().listDataEventByRalateType();						
									
									$("#eventDuration").select2('val',"");
									$("#eventAssignTo").select2('val',"");	
									$("#eventLocation").select2('val',"");
									
									$('#frmAddEvent').bootstrapValidator('resetForm', true);				
									swal({
			    						title: "SUCCESSFUL",
			    					  	text: result.MSG,
			    					  	html: true,
			    					  	timer: 2000,
			    					  	type: "success"
			    					});
									setTimeout(function(){ $('#frmEvent').modal('toggle');}, 2000);
																																
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
		
	});
	
	
	
	$('#frmCollabComment').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			collabCommetText: {
				validators: {
					notEmpty: {
						message: 'The comment is required and can not be empty!'
					},
					stringLength: {
						max: 255,
						message: 'The comment must be less than 255 characters long!'
					}
				}
			}
			
		}
	}).on('success.form.bv', function(e) {
		
	});
	

	$('#frmCollab').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			collabPostDescription: {
				validators: {
					notEmpty: {
						message: 'The post description is required and can not be empty!'
					},
					stringLength: {
						max: 1000,
						message: 'The post description must be less than 1000 characters long!'
					}
				}
			}
			
		}
	}).on('success.form.bv', function(e) {		
		var addPost = { "tags" : getTags("collabTags","username"), "colDes" : getValueStringById("collabPostDescription"), "colUser": username, "colRelatedToModuleName":typeModule, "colRelatedToModuleId":oppId};
		swal({   
			title: "<span style='font-size: 25px;'>You are about to post collaboration.</span>",
			text: "Click OK to continue or CANCEL to abort.",
			type: "info",
			html: true,
			showCancelButton: true,
			closeOnConfirm: false,
			showLoaderOnConfirm: true,		
		}, function(){ 
			setTimeout(function(){
				$.ajax({ 
					url : server+"/collaborate/add",
					method : "POST",
					data : JSON.stringify(addPost),
					beforeSend: function(xhr) {
					    xhr.setRequestHeader("Accept", "application/json");
					    xhr.setRequestHeader("Content-Type", "application/json");
				    }, 
				    success: function(result){					    						    
						if(result.MESSAGE == "INSERTED"){						
							angular.element(document.getElementById('viewOpportunityController')).scope().listCollabByLeadByUser();					
							
							$("#collabTags").select2("val","");
							$('#frmCollab').bootstrapValidator('resetForm', true);
							
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
		
				
	});
	
	
});



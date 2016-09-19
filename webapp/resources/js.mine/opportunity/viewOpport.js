
var callStartDateOld = "";
$(function(){
	
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
	
	
	$('#callStartDate').daterangepicker({
        format: 'DD/MM/YYYY h:mm A',
        singleDatePicker: true,
        showDropdowns: true,
        timePicker: true, 
        timePickerIncrement: 5,
    }).on('change', function(e) {
    	var date = getValueStringById("callStartDate");
    	if(date === ""){
    		setValueById("callStartDate",callStartDateOld);    		
    	}else{
    		callStartDateOld = date;
    	}
     	$('#frmAddCall').bootstrapValidator('revalidateField', 'callStartDate');
 	});
	
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
		var frmNoteData = {"noteId":noteIdEdit,"noteSubject":getValueStringById("note_subject"), "noteDes":getValueStringById("note_description"),"noteRelatedToModuleType":"Campaign","noteRelatedToModuleId":oppId,"noteCreateBy":username};		
		
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
			    		angular.element(document.getElementById('viewOpportunityController')).scope().resetFrmNote();
			    		angular.element(document.getElementById('viewOpportunityController')).scope().getListNoteByLead();
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
			    		angular.element(document.getElementById('viewOpportunityController')).scope().resetFrmNote();
			    		angular.element(document.getElementById('viewOpportunityController')).scope().getListNoteByLead();
			    	}else{
			    		alertMsgErrorSweet();
			    	}
			    	 
			    },
			    error:function(data,status,er) { 
			        console.log("error: "+data+" status: "+status+" er:"+er);
			        alertMsgErrorSweet();
			    }
			});
		}
	});	
	
	
	$('#frmOpportDetail').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			oppName: {
				validators: {
					notEmpty: {
						message: 'The  name is required and can not be empty!'
					},
					stringLength: {
						max: 255,
						message: 'The name must be less than 255 characters long!'
					}
				}
			},
			oppAmount: {
				validators: {
					notEmpty: {
						message: 'The  amount is required and can not be empty!'
					},
					numeric: {
		                message: 'The value is not a number',
		                // The default separators
		                thousandsSeparator: '',
		                decimalSeparator: '.'
		            }
				}
			},
			oppCustomer: {
				validators: {
					notEmpty: {
						message: 'The  customer is required and can not be empty!'
					}
				}
			},
			oppCloseDate: {
				validators: {
					notEmpty: {
						message: 'The  close date is required and can not be empty!'
					},
					date: {
                        format: 'DD/MM/YYYY',
                        message: 'The value is not a valid date'
                    }
				}
			},
			oppProbability: {
				validators: {
					between: {
                        min: 0,
                        max: 100,
                        message: 'The probability must be between 1 and 100'
                    }
				}
			},
			oppStage: {
				validators: {
					notEmpty: {
						message: 'The  stage is required and can not be empty!'
					}
				}
			}
			,
			oppNextStep: {
				validators: {
					stringLength: {
						max: 255,
						message: 'The step must be less than 255 characters long.'
					}
				}
			}
			,
			oppDescription: {
				validators: {
					stringLength: {
						max: 1000,
						message: 'The description must be less than 1000 characters long.'
					}
				}
			}
		}
	}).on('success.form.bv', function(e) {
		
		//alert(getJsonById("custID","oppCustomer","str"));
		
		var frmLeadDetailData = {
			  "opId": oppId,
			  "opName": getValueStringById("oppName"),
			  "opAmount": getInt("oppAmount"),
			  "customer":getJsonById("custID","oppCustomer","str"),
			  "opCloseDate": getDateByFormat("oppCloseDate"),
			  "opTypeID": getJsonById("otId","oppType","int"),
			  "opStageId": getJsonById("osId","oppStage","int"),
			  "opProbability": getValueStringById("oppProbability"),
			  "opLeadSourceID": getJsonById("sourceID","oppLeadSource","int"),
			  "opNextStep": getValueStringById("oppNextStep"),
			  "opCampId": getJsonById("campID","oppCampaign","str"),
			  "opDes": getValueStringById("oppDescription"),
			  "opAssignedTo": getJsonById("userID","oppAssignTo","str"),
			  "opModifyBy": username		
	  	};	
		
		$.ajax({
			url : server+"/opportunity/edit",
			type : "PUT",
			data : JSON.stringify(frmLeadDetailData),
			beforeSend: function(xhr) {
			    xhr.setRequestHeader("Accept", "application/json");
			    xhr.setRequestHeader("Content-Type", "application/json");
			},
			success:function(data){	
				
				if(data.MESSAGE == "UPDATED"){					
					swal({
		        		title:"Successfully",
		        		text:"User have been update opportunity!",
		        		type:"success",  
		        		timer: 2000,   
		        		showConfirmButton: false
					});
					setTimeout(function(){
						location.reload();
					}, 2000);
				}else{
					swal({
		        		title:"Unsuccessfully",
		        		text:"Please try again!",
		        		type:"error",  
		        		timer: 2000,   
		        		showConfirmButton: false
					});
					setTimeout(function(){
					}, 2000);
				}										
			},
			error:function(error){
				swal({
	        		title:"Unsuccessfully",
	        		text:"Please try again!",
	        		type:"error",  
	        		timer: 2000,   
	        		showConfirmButton: false
				});
				setTimeout(function(){
				}, 2000);
			}
		});			
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
				      "callRelatedToModuleType": 'Campaign'
				      
				}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
			    },
				success:function(data){						
					if(data.MESSAGE == 'INSERTED'){
						angular.element(document.getElementById('viewOpportunityController')).scope().listDataCallByRalateType();							
						$("#callStatus").select2('val',"");
						$("#callAssignTo").select2('val',"");
						$('#frmAddCall').bootstrapValidator('resetForm', true);
						swal({
		            		title:"Successfully",
		            		text:"User have been created new call!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
						setTimeout(function(){
							$('#frmCall').modal('toggle');
						}, 2000);
					}else{
						alertMsgErrorSweet();
					}									
				},
				error:function(){
					alertMsgErrorSweet();
				}
			});
			
		}else{
			
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
				      "callRelatedToModuleType": 'Campaign',
				      "callModifiedBy" : username
				}),
				beforeSend: function(xhr) {
					xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
			    },
				success:function(data){
					if(data.MESSAGE == 'UPDATED'){
						angular.element(document.getElementById('viewOpportunityController')).scope().listDataCallByRalateType();
						$("#callStatus").select2('val',"");
						$("#callAssignTo").select2('val',"");
						$('#frmAddCall').bootstrapValidator('resetForm', true);						
						swal({
		            		title:"Successfully",
		            		text:"User have been updated new call!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
						setTimeout(function(){
							$('#frmCall').modal('toggle');
						}, 2000);
					}else{
						alertMsgErrorSweet();
					}
										
				},
				error:function(){
					alertMsgErrorSweet();
				}
			});
			
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
				      "meetingRelatedToModuleType": 'Campaign',
				      "meetingRelatedToModuleId": oppId,
				      "meetingCreateBy": username
				}),
				beforeSend: function(xhr) {
				    xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
				},
				success:function(data){						
					if(data.MESSAGE == 'INSERTED'){
						angular.element(document.getElementById('viewOpportunityController')).scope().listDataMeetByRalateType();						
						$("#meetStatus").select2('val',"");
						$("#meetAssignTo").select2('val',"");	
						$("#meetDuration").select2('val',"");
						$('#frmAddMeet').bootstrapValidator('resetForm', true);
						
						swal({
		            		title:"Successfully",
		            		text:"User have been created new meeting!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
						setTimeout(function(){
							$('#frmMeet').modal('toggle');
						}, 2000);
					}else{
						alertMsgErrorSweet();
					}
					
				},
				error:function(){
					alertMsgErrorSweet();
				}
			}); 
			
		}else{
			
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
				      "meetingRelatedToModuleType": 'Campaign',
				      "meetingRelatedToModuleId": oppId,
				      "meetingModifiedBy" : username
				}),
				beforeSend: function(xhr) {
				    xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
				},
				success:function(data){					
					if(data.MESSAGE == 'UPDATED'){
						angular.element(document.getElementById('viewOpportunityController')).scope().listDataMeetByRalateType();
						
						$("#meetStatus").select2('val',"");
						$("#meetAssignTo").select2('val',"");	
						$("#meetDuration").select2('val',"");
						$('#frmAddMeet').bootstrapValidator('resetForm', true);
						
						swal({
		            		title:"Successfully",
		            		text:"User have been updated this meeting!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
						setTimeout(function(){
							$('#frmMeet').modal('toggle');
						}, 2000);
					}else{
						alertMsgErrorSweet();
					}
				},
				error:function(){
					alertMsgErrorSweet();
				}
			}); 
					
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
			
			$.ajax({
				url : server+"/task/add",
				type : "POST",
				data : JSON.stringify({
				      "taskStatus": getJsonById("taskStatusId","taskStatus","int"),
				      "taskPriority": getValueStringById("taskPriority"),
				      "taskAssignTo": getJsonById("userID","taskAssignTo","str"),
				      "taskRelatedToId": oppId,
				      "taskRelatedToModule": 'Campaign',
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
				success:function(data){					
					if(data.MESSAGE == 'INSERTED'){
						angular.element(document.getElementById('viewOpportunityController')).scope().listDataTaskByRalateType();						
						
						$("#taskStatus").select2('val',"");
						$("#taskAssignTo").select2('val',"");	
						$("#taskPriority").select2('val',"");
						$("#taskContact").select2('val',"");
						
						
						$('#frmAddTask').bootstrapValidator('resetForm', true);		
						
						swal({
		            		title:"Successfully",
		            		text:"User have been created a new task!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
						setTimeout(function(){
							$('#frmTask').modal('toggle');
						}, 2000);
					}else{
						alertMsgErrorSweet();
					}
				},
				error:function(){
					alertMsgErrorSweet();
				}
			});
			
		}else{
			
			$.ajax({
				url : server+"/task/edit",
				type : "PUT",
				data : JSON.stringify({
					  "taskId" : taskIdForEdit,					 
				      "taskPriority": getValueStringById("taskPriority"),				      
				      "taskRelatedToId": oppId,
				      "taskRelatedToModule": 'Campaign',
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
				success:function(data){					
					if(data.MESSAGE == 'UPDATED'){
						angular.element(document.getElementById('viewOpportunityController')).scope().listDataTaskByRalateType();
						
						
						$("#taskStatus").select2('val',"");
						$("#taskAssignTo").select2('val',"");	
						$("#taskPriority").select2('val',"");
						$("#taskContact").select2('val',"");
						
						$('#frmAddTask').bootstrapValidator('resetForm', true);	
						
						swal({
		            		title:"Successfully",
		            		text:"User have been updated this task!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
						setTimeout(function(){
							$('#frmTask').modal('toggle');
						}, 2000);
					}else{
						alertMsgErrorSweet();
					}
				},
				error:function(){
					alertMsgErrorSweet();
				}
			}); 
					
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
				      "evRelatedToModuleType" : "Campaign"
				}),
				beforeSend: function(xhr) {
				    xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
				},
				success:function(data){					
					if(data.MESSAGE == 'INSERTED'){
						angular.element(document.getElementById('viewOpportunityController')).scope().listDataEventByRalateType();						
						
						$("#eventDuration").select2('val',"");
						$("#eventAssignTo").select2('val',"");	
						$("#eventLocation").select2('val',"");
						
						$('#frmAddEvent').bootstrapValidator('resetForm', true);
						
						swal({
		            		title:"Successfully",
		            		text:"User have been created a new event!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
						setTimeout(function(){
							$('#frmEvent').modal('toggle');
						}, 2000);
					}else{
						alertMsgErrorSweet();
					}
				},
				error:function(){
					alertMsgErrorSweet();
				}
			}); 
			
		}else{
			
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
				      "evRelatedToModuleType" : "Campaign"
				}),
				beforeSend: function(xhr) {
				    xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
				},
				success:function(data){					
					if(data.MESSAGE == 'UPDATED'){
						angular.element(document.getElementById('viewOpportunityController')).scope().listDataEventByRalateType();
						
						$("#eventDuration").select2('val',"");
						$("#eventAssignTo").select2('val',"");	
						$("#eventLocation").select2('val',"");
						
						$('#frmAddEvent').bootstrapValidator('resetForm', true);						
						
						swal({
		            		title:"Successfully",
		            		text:"User have been updated this event!",
		            		type:"success",  
		            		timer: 2000,   
		            		showConfirmButton: false
	        			});
						setTimeout(function(){
							$('#frmEvent').modal('toggle');
						}, 2000);
					}else{
						alertMsgErrorSweet();
					}
				},
				error:function(){
					alertMsgErrorSweet();
				}
			}); 
					
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
			
		var addPost = { "tags" : getTags("collabTags","username"), "colDes" : getValueStringById("collabPostDescription"), "colUser": username, "colRelatedToModuleName":"Campaign", "colRelatedToModuleId":oppId};		
		$.ajax({
			url : server+"/collaborate/add",
			method : "POST",			
			headers: {
		    	'Accept': 'application/json',
		        'Content-Type': 'application/json'
		    },
			data : JSON.stringify(addPost),
			success:function(data){
				if(data.MESSAGE == 'INSERTED'){
					angular.element(document.getElementById('viewOpportunityController')).scope().listCollabByLeadByUser();
					$("#collabTags").select2("val","");
					$('#frmCollab').bootstrapValidator('resetForm', true);						
					swal({
	            		title:"Successfully",
	            		text:"User have been created a new post!",
	            		type:"success",  
	            		timer: 2000,   
	            		showConfirmButton: false
	    			});					
				}else{
					alertMsgErrorSweet();
				}	
			},
			error:function(){
				alertMsgErrorSweet();
			}
		});				
	});
	
	
});



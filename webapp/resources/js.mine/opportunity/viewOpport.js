$(function(){
	
	$(".timepicker").timepicker({
        showInputs: false,
        minuteStep: 5,
        defaultTime: false,
        showMeridian : false
    });
	
	$('#oppCloseDate').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        format: 'DD/MM/YYYY'
    }).on('change', function(e) {
     	$('#frmOpportDetail').bootstrapValidator('revalidateField', 'callStartDate');
 	});
	
	
	$("#collapTags").select2();
	//$(".tags").select2({tags: true});
	$('#callStartDate').daterangepicker({
        format: 'DD/MM/YYYY h:mm A',
        singleDatePicker: true,
        showDropdowns: true,
        timePicker: true, 
        timePickerIncrement: 5,
    }).on('change', function(e) {
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
		var frmNoteData = {"noteId":noteIdEdit,"noteSubject":getValueStringById("note_subject"), "noteDes":getValueStringById("note_description"),"noteRelatedToModuleType":"Opportunity","noteRelatedToModuleId":oppId,"noteCreateBy":username};		
		
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
                        min: 1,
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
						max: 255,
						message: 'The dubject must be less than 255 characters long.'
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
				      "callStartDate": getValueStringById("callStartDate"),
				      "callDuration": getValueStringById("callDuration"),
				      "callCreateBy": username,
				      "callDes": getValueStringById("callDescription"),
				      "callSubject": getValueStringById("callSubject"),
				      "callAssignTo": getJsonById("userID","callAssignTo","str"),
				      "callStatus": getJsonById("callStatusId","callStatus","int"),
				      "callRelatedToFieldId": oppId,
				      "callRelatedToModuleType": 'Opportunity'
				      
				}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
			    },
				success:function(data){	
						if(data.MESSAGE == 'INSERTED'){
							angular.element(document.getElementById('viewOpportunityController')).scope().listDataCallByRalateType();
							
							$('#frmAddCall').bootstrapValidator('resetForm', true);
							$('#frmCall').modal('toggle');
							swal({
			            		title:"Successfully",
			            		text:"User have been created new call!",
			            		type:"success",  
			            		timer: 2000,   
			            		showConfirmButton: false
		        			});
						}else{
							swal({
			            		title:"Unsuccessfully",
			            		text:"Please try agian!",
			            		type:"error",  
			            		timer: 2000,   
			            		showConfirmButton: false
		        			});
						}										
				},
				error:function(){
					errorMessage();
				}
			});
			
		}else{
			
			$.ajax({
				url : server+"/call/edit",
				type : "PUT",
				data : JSON.stringify({ 
					  "callId": callIdForEdit,
					  "callStartDate": getValueStringById("callStartDate"),
				      "callDuration": getValueStringById("callDuration"),
				      "callDes": getValueStringById("callDescription"),
				      "callSubject": getValueStringById("callSubject"),
				      "callAssignTo": getJsonById("userID","callAssignTo","str"),
				      "callStatus": getJsonById("callStatusId","callStatus","int"),
				      "callRelatedToFieldId": oppId,
				      "callRelatedToModuleType": 'Opportunity',
				      "callModifiedBy" : username
				}),
				beforeSend: function(xhr) {
					xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
			    },
				success:function(data){					
					dis(data)
					if(data.MESSAGE == 'UPDATED'){
						angular.element(document.getElementById('viewOpportunityController')).scope().listDataCallByRalateType();
					}else{
						
					}
										
				},
				error:function(){
					errorMessage();
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
				      "meetingDes": getValueStringById("meetDescription"),
				      "meetingStartDate": getValueStringById("meetStartDate"),
				      "meetingDuration": getValueStringById("meetDuration"),
				      "meetingEndDate":  getValueStringById("meetEndDate"),
				      "meetingStatus": getJsonById("statusId","meetStatus","int"),
				      "meetingAssignTo": getJsonById("userID","meetAssignTo","str"),
				      "meetingLocation":  getValueStringById("meetLocation"),
				      "meetingRelatedToModuleType": 'Opportunity',
				      "meetingRelatedToModuleId": oppId,
				      "meetingCreateBy": username
				}),
				beforeSend: function(xhr) {
				    xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
				},
				success:function(data){					
					dis(data)
				},
				error:function(){
					
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
				      "meetingStartDate": getValueStringById("meetStartDate"),
				      "meetingDuration": getValueStringById("meetDuration"),
				      "meetingEndDate":  getValueStringById("meetEndDate"),
				      "meetingStatus": getJsonById("statusId","meetStatus","int"),
				      "meetingAssignTo": getJsonById("userID","meetAssignTo","str"),
				      "meetingLocation":  getValueStringById("meetLocation"),
				      "meetingRelatedToModuleType": 'Opportunity',
				      "meetingRelatedToModuleId": oppId,
				      "meetingModifiedBy" : username
				}),
				beforeSend: function(xhr) {
				    xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
				},
				success:function(data){					
					dis(data)
				},
				error:function(){
					
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
                        format: 'DD/MM/YYYY',
                        message: 'The value is not a valid date!'
                    }
				}
			},
			taskEndDate: {
				validators: {
					date: {
                        format: 'DD/MM/YYYY',
                        message: 'The value is not a valid date!'
                    }
				}
			},
			meetPriority : {
				validators: {
					notEmpty: {
						message: 'The priority is required and can not be empty!'
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
				      "taskPriority": getValueStringById("taskPriority"),
				      "taskRelatedToId": oppId,
				      "taskRelatedToModule": 'Opportunity',
				      "taskDes": getValueStringById("taskDescription"),
				      "taskDueDate": getValueStringById("taskEndDate"),
				      "taskSubject":  getValueStringById("taskSubject"),
				      "taskStartDate":  getValueStringById("taskStartDate"),
				      "taskContact": getJsonById("conID","taskContact","str"),
				      "taskStatus": getJsonById("taskStatusId","taskStatus","int"),
				      "taskAssignTo": getJsonById("userID","taskAssignTo","str"),
				      "taskCreateBy": username					      
				}),
				beforeSend: function(xhr) {
				    xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
				},
				success:function(data){					
					dis(data)
				},
				error:function(){
					
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
				      "taskRelatedToModule": 'Opportunity',
				      "taskDes": getValueStringById("taskDescription"),
				      "taskDueDate": getValueStringById("taskEndDate"),
				      "taskSubject":  getValueStringById("taskSubject"),
				      "taskStartDate":  getValueStringById("taskStartDate"),
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
					dis(data)
				},
				error:function(){
					
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
		
		alert()
		
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
				      "evStartDate": getValueStringById("eventStartDate"),
				      "evEndDate": getValueStringById("eventEndDate"),
				      "assignTo": getJsonById("userID","eventAssignTo","str"),
				      "evlocation": getJsonById("loId","eventLocation","str"),
				      "evRelatedToID" : oppId,
				      "evRelatedToType" : "Opportunity"
				}),
				beforeSend: function(xhr) {
				    xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
				},
				success:function(data){					
					dis(data)
				},
				error:function(){
					
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
				      "evStartDate": getValueStringById("eventStartDate"),
				      "evEndDate": getValueStringById("eventEndDate"),
				      "assignTo": getJsonById("userID","eventAssignTo","str"),
				      "evlocation": getJsonById("loId","eventLocation","str"),
				      "evRelatedToID" : oppId,
				      "evRelatedToType" : "Opportunity"
				}),
				beforeSend: function(xhr) {
				    xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
				},
				success:function(data){					
					dis(data)
				},
				error:function(){
					
				}
			}); 
					
		}
		
	});
	
	
	$("#collapBtnPost").click(function(){
		$('#frmCollap').submit();
	});
	
	$('#frmCollap').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			collapPostDescription: {
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
		
		alert()
		
		/*$.ajax({
			url : server+"/event/add",
			type : "POST",
			data : JSON.stringify({
			      "evName": getValueStringById("eventSubject"),
			      "evlocation": {"loId": getStringToNull("eventLocation")},
			      "evBudget": getValueStringById("eventBudget"),
			      "evDes": getValueStringById("eventDescription"),
			      "evCreateBy":  username,
			      "evDuration": getValueStringById("eventDuration"),
			      "evStartDate": getValueStringById("eventStartDate"),
			      "evEndDate": getValueStringById("eventEndDate"),
			      "assignTo": {"userID": getStringToNull("eventAssignTo")},
			      "evRelatedToID" : leadId,
			      "evRelatedToType" : "Lead"
			}),
			beforeSend: function(xhr) {
			    xhr.setRequestHeader("Accept", "application/json");
			    xhr.setRequestHeader("Content-Type", "application/json");
			},
			success:function(data){					
				dis(data)
			},
			error:function(){
				
			}
		}); */
	});
});


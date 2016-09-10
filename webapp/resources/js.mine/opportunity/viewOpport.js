$(function(){
	
	$(".timepicker").timepicker({
        showInputs: false,
        minuteStep: 5,
        defaultTime: false,
        showMeridian : false
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
		var frmNoteData = {"noteId":noteIdEdit,"noteSubject":getValueStringById("note_subject"), "noteDes":getValueStringById("note_description"),"noteRelatedToModuleType":"Lead","noteRelatedToModuleId":leadId,"noteCreateBy":username};		
		
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
			lea_salutation:{
				validators: {
					stringLength: {
						max: 100,
						message: 'The salutation must be less than 100 characters long.'
					}
				}
			},
			
			lea_status: {
				validators: {
					
				}
			},
			lea_industry: {
				validators: {
					
				}
			},
			lea_source: {
				validators: {
					
				}
			},
			lea_campaign: {
				validators: {
					notEmpty: {
						message: 'The campaign is required and can not be empty!'
					},
					stringLength: {
						max: 100,
						message: 'The campaign must be less than 100 characters long.'
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
					regexp: {
                        regexp: '^[^@\\s]+@([^@\\s]+\\.)+[^@\\s]+$',
                        message: 'The value is not a valid email address'
                    },
					stringLength: {
						max: 255,
						message: 'The department must be less than 255 characters long.'
					}
				}
			},
			lea_accountName: {
				validators: {
					notEmpty: {
						message: 'The company is required and can not be empty!'
					},
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
		var frmLeadDetailData = {
			"leadID": leadId,
			"salutation": $.trim($("#lea_salutation").val()),
		    "firstName": $.trim($("#lea_firstName").val()),
		    "lastName": $.trim($("#lea_lastName").val()),
		    "title": $.trim($("#lea_title").val()),
		    "department": $.trim($("#lea_department").val()),
		    "phone": $.trim($("#lea_phone").val()),
		    "mobile": $.trim($("#lea_mobilePhone").val()),
		    "website": $.trim($("#lea_website").val()),
		    "accountName": $.trim($("#lea_accountName").val()),
		    "no":  $.trim($("#lea_no").val()),
		    "street": $.trim($("#lea_street").val()),
		    "village": $.trim($("#lea_village").val()),
		    "commune": $.trim($("#lea_commune").val()),
		    "district": $.trim($("#lea_district").val()),
		    "city": $.trim($("#lea_city").val()),
		    "state": $.trim($("#lea_state").val()),
		    "country": $.trim($("#lea_country").val()),
		    "description": $.trim($("#lea_description").val()),
		    "status": {"statusID":getIntToNull("lea_status")},
		    "industry": {"industID":getIntToNull("lea_industry")},
		    "source": {"sourceID":getIntToNull("lea_source")},
		    "campaign": {"campID":getStringToNull("lea_campaign")},
		    "assignTo": {"userID":getStringToNull("lea_assignto")},
		    "modifyBy": username,
		    "email": $.trim($("#lea_email").val())
	  	};	
		
		$.ajax({
			url : "${pageContext.request.contextPath}/lead/edit",
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
		        		text:"User have been Update Lead!",
		        		type:"success",  
		        		timer: 2000,   
		        		showConfirmButton: false
					});
					setTimeout(function(){
						location.reload();
					}, 2000);
				}else{
					
				}												
			},
			error:function(){
				
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
				      "callStatus": {"callStatusId":getIntToNull("callStatus")},
				      "callDes": getValueStringById("callDescription"),
				      "callSubject": getValueStringById("callSubject"),
				      "callAssignTo": {"userID": getStringToNull("callAssignTo")},
				      "callRelatedToFieldId": leadId,
				      "callRelatedToModuleType": 'Lead'
				      
				}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
			    },
				success:function(data){	
						if(data.MESSAGE == 'INSERTED'){
							angular.element(document.getElementById('viewLeadController')).scope().listDataCallByRalateType();
							
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
				      "callStatus": {"callStatusId":getIntToNull("callStatus")},
				      "callDes": getValueStringById("callDescription"),
				      "callSubject": getValueStringById("callSubject"),
				      "callAssignTo": {"userID": getStringToNull("callAssignTo")},
				      "callRelatedToFieldId": leadId,
				      "callRelatedToModuleType": 'Lead',
				      "callModifiedBy" : username
				}),
				beforeSend: function(xhr) {
					xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
			    },
				success:function(data){					
					dis(data)
					if(data.MESSAGE == 'UPDATED'){
						angular.element(document.getElementById('viewLeadController')).scope().listDataCallByRalateType();
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
				url : "${pageContext.request.contextPath}/meeting/add",
				type : "POST",
				data : JSON.stringify({

					  "meetingSubject": getValueStringById("meetSubject"),
				      "meetingAssignTo": {"userID": getStringToNull("meetAssignTo")},
				      "meetingDes": getValueStringById("meetDescription"),
				      "meetingStartDate": getValueStringById("meetStartDate"),
				      "meetingDuration": getValueStringById("meetDuration"),
				      "meetingEndDate":  getValueStringById("meetEndDate"),
				      "meetingStatus": {"statusId":getIntToNull("meetStatus")},
				      "meetingLocation":  getValueStringById("meetLocation"),
				      "meetingRelatedToModuleType": 'Lead',
				      "meetingRelatedToModuleId": leadId,
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
				url : "${pageContext.request.contextPath}/meeting/edit",
				type : "PUT",
				data : JSON.stringify({
					  "meetingId": meetIdForEdit,
					  "meetingSubject": getValueStringById("meetSubject"),
				      "meetingAssignTo": {"userID": getStringToNull("meetAssignTo")},
				      "meetingDes": getValueStringById("meetDescription"),
				      "meetingStartDate": getValueStringById("meetStartDate"),
				      "meetingDuration": getValueStringById("meetDuration"),
				      "meetingEndDate":  getValueStringById("meetEndDate"),
				      "meetingStatus": {"statusId":getIntToNull("meetStatus")},
				      "meetingLocation":  getValueStringById("meetLocation"),
				      "meetingRelatedToModuleType": 'Lead',
				      "meetingRelatedToModuleId": leadId,
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
				url : "${pageContext.request.contextPath}/task/add",
				type : "POST",
				data : JSON.stringify({
				      "taskStatus": {"taskStatusId":getIntToNull("taskStatus")},
				      "taskPriority": getValueStringById("taskPriority"),
				      "taskAssignTo": {"userID": getStringToNull("taskAssignTo")},
				      "taskRelatedToId": leadId,
				      "taskRelatedToModule": 'Lead',
				      "taskDes": getValueStringById("taskDescription"),
				      "taskDueDate": getValueStringById("taskEndDate"),
				      "taskSubject":  getValueStringById("taskSubject"),
				      "taskStartDate":  getValueStringById("taskStartDate"),
				      "taskContact": {"conID":getIntToNull("taskContact")},
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
				url : "${pageContext.request.contextPath}/task/edit",
				type : "PUT",
				data : JSON.stringify({
					  "taskId" : taskIdForEdit,
					  "taskStatus": {"taskStatusId":getIntToNull("taskStatus")},
				      "taskPriority": getValueStringById("taskPriority"),
				      "taskAssignTo": {"userID": getStringToNull("taskAssignTo")},
				      "taskRelatedToId": leadId,
				      "taskRelatedToModule": 'Lead',
				      "taskDes": getValueStringById("taskDescription"),
				      "taskDueDate": getValueStringById("taskEndDate"),
				      "taskSubject":  getValueStringById("taskSubject"),
				      "taskStartDate":  getValueStringById("taskStartDate"),
				      "taskContact": {"conID":getIntToNull("taskContact")},
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
				url : "${pageContext.request.contextPath}/event/add",
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
			}); 
			
		}else{
			
			$.ajax({
				url : "${pageContext.request.contextPath}/event/edit",
				type : "PUT",
				data : JSON.stringify({
					  "evId": eventIdForEdit,
					  "evName": getValueStringById("eventSubject"),
				      "evlocation": {"loId": getStringToNull("eventLocation")},
				      "evBudget": getValueStringById("eventBudget"),
				      "evDes": getValueStringById("eventDescription"),
				      "evModifiedBy":  username,
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
			url : "${pageContext.request.contextPath}/event/add",
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


/*

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
</div>*/
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
		var frmNoteData = {"noteId":noteIdEdit,"noteSubject":getValueStringById("note_subject"), "noteDes":getValueStringById("note_description"),"noteRelatedToModuleType":"Lead","noteRelatedToModuleId":leadId,"noteCreateBy":username};		
		
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
						    data: JSON.stringify(frmNoteData),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){					    						    
								if(result.MESSAGE == "INSERTED"){						
									angular.element(document.getElementById('viewLeadController')).scope().resetFrmNote();
						    		angular.element(document.getElementById('viewLeadController')).scope().getListNoteByLead();
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
						    data: JSON.stringify(frmNoteData),
							beforeSend: function(xhr) {
							    xhr.setRequestHeader("Accept", "application/json");
							    xhr.setRequestHeader("Content-Type", "application/json");
						    }, 
						    success: function(result){					    						    
								if(result.MESSAGE == "UPDATED"){						
									angular.element(document.getElementById('viewLeadController')).scope().resetFrmNote();
						    		angular.element(document.getElementById('viewLeadController')).scope().getListNoteByLead();	
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
		    "status": getJsonById("statusID","lea_status","int"),
		    "industry": getJsonById("industID","lea_industry","int"),
		    "source": getJsonById("sourceID","lea_source","int"),
		    "campaign": getJsonById("campID","lea_campaign","str"),
		    "assignTo": getJsonById("userID","lea_assignto","str"),
		    "modifyBy": username,
		    "email": $.trim($("#lea_email").val())
	  	};	
		
		$.ajax({
			url : server+"/lead/edit",
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
		        		text:"You have been Update Lead!",
		        		type:"success",  
		        		timer: 2000,   
		        		showConfirmButton: false
					});
					setTimeout(function(){
						location.reload();
					}, 2000);
				}else{
					alertMsgErrorSweet();
				}												
			},
			error:function(){
				alertMsgErrorSweet();
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
						$("#callStatus").select2('val',"");
						$("#callAssignTo").select2('val',"");
						$('#frmAddCall').bootstrapValidator('resetForm', true);
						swal({
		            		title:"Successfully",
		            		text:"You have been created new call!",
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
				      "callRelatedToFieldId": leadId,
				      "callRelatedToModuleType": 'Lead',
				      "callModifiedBy" : username
				}),
				beforeSend: function(xhr) {
					xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
			    },
				success:function(data){
					if(data.MESSAGE == 'UPDATED'){
						angular.element(document.getElementById('viewLeadController')).scope().listDataCallByRalateType();
						$("#callStatus").select2('val',"");
						$("#callAssignTo").select2('val',"");
						$('#frmAddCall').bootstrapValidator('resetForm', true);						
						swal({
		            		title:"Successfully",
		            		text:"You have been updated new call!",
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
				      "meetingRelatedToModuleType": 'Lead',
				      "meetingRelatedToModuleId": leadId,
				      "meetingCreateBy": username
				}),
				beforeSend: function(xhr) {
				    xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
				},
				success:function(data){						
					if(data.MESSAGE == 'INSERTED'){
						angular.element(document.getElementById('viewLeadController')).scope().listDataMeetByRalateType();						
						$("#meetStatus").select2('val',"");
						$("#meetAssignTo").select2('val',"");	
						$("#meetDuration").select2('val',"");
						$('#frmAddMeet').bootstrapValidator('resetForm', true);
						
						swal({
		            		title:"Successfully",
		            		text:"You have been created new meeting!",
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
				      "meetingRelatedToModuleType": 'Lead',
				      "meetingRelatedToModuleId": leadId,
				      "meetingModifiedBy" : username
				}),
				beforeSend: function(xhr) {
				    xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
				},
				success:function(data){					
					if(data.MESSAGE == 'UPDATED'){
						angular.element(document.getElementById('viewLeadController')).scope().listDataMeetByRalateType();
						
						$("#meetStatus").select2('val',"");
						$("#meetAssignTo").select2('val',"");	
						$("#meetDuration").select2('val',"");
						$('#frmAddMeet').bootstrapValidator('resetForm', true);
						
						swal({
		            		title:"Successfully",
		            		text:"You have been updated this meeting!",
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
				      "taskRelatedToId": leadId,
				      "taskRelatedToModule": 'Lead',
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
						angular.element(document.getElementById('viewLeadController')).scope().listDataTaskByRalateType();						
						
						$("#taskStatus").select2('val',"");
						$("#taskAssignTo").select2('val',"");	
						$("#taskPriority").select2('val',"");
						$("#taskContact").select2('val',"");
						
						
						$('#frmAddTask').bootstrapValidator('resetForm', true);		
						
						swal({
		            		title:"Successfully",
		            		text:"You have been created a new task!",
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
				      "taskRelatedToId": leadId,
				      "taskRelatedToModule": 'Lead',
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
						angular.element(document.getElementById('viewLeadController')).scope().listDataTaskByRalateType();
						
						
						$("#taskStatus").select2('val',"");
						$("#taskAssignTo").select2('val',"");	
						$("#taskPriority").select2('val',"");
						$("#taskContact").select2('val',"");
						
						$('#frmAddTask').bootstrapValidator('resetForm', true);	
						
						swal({
		            		title:"Successfully",
		            		text:"You have been updated this task!",
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
				      "evRelatedToModuleId" : leadId,
				      "evRelatedToModuleType" : "Lead"
				}),
				beforeSend: function(xhr) {
				    xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
				},
				success:function(data){					
					if(data.MESSAGE == 'INSERTED'){
						angular.element(document.getElementById('viewLeadController')).scope().listDataEventByRalateType();						
						
						$("#eventDuration").select2('val',"");
						$("#eventAssignTo").select2('val',"");	
						$("#eventLocation").select2('val',"");
						
						$('#frmAddEvent').bootstrapValidator('resetForm', true);
						
						swal({
		            		title:"Successfully",
		            		text:"You have been created a new event!",
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
				      "evRelatedToModuleId" : leadId,
				      "evRelatedToModuleType" : "Lead"
				}),
				beforeSend: function(xhr) {
				    xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
				},
				success:function(data){					
					if(data.MESSAGE == 'UPDATED'){
						angular.element(document.getElementById('viewLeadController')).scope().listDataEventByRalateType();
						
						$("#eventDuration").select2('val',"");
						$("#eventAssignTo").select2('val',"");	
						$("#eventLocation").select2('val',"");
						
						$('#frmAddEvent').bootstrapValidator('resetForm', true);						
						
						swal({
		            		title:"Successfully",
		            		text:"You have been updated this event!",
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
	
	/*$("#collabBtnPost").click(function(){
		$('#frmCollab').submit();
	});*/
	
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
			
		var addPost = { "tags" : getTags("collabTags","username"), "colDes" : getValueStringById("collabPostDescription"), "colUser": username, "colRelatedToModuleName":"Lead", "colRelatedToModuleId":leadId};		
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
					angular.element(document.getElementById('viewLeadController')).scope().listCollabByLeadByUser();
					$("#collabTags").select2("val","");
					$('#frmCollab').bootstrapValidator('resetForm', true);						
					swal({
	            		title:"Successfully",
	            		text:"You have been created a new post!",
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


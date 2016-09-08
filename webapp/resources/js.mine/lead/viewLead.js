$(function(){
	
	$(".timepicker").timepicker({
        showInputs: false,
        minuteStep: 5,
        defaultTime: false,
        showMeridian : false
    });

	$('.date').daterangepicker({
        format: 'DD/MM/YYYY',
        singleDatePicker: true,
        showDropdowns: true,
    });
	
	
	$('#startDateMeeting').daterangepicker({ singleDatePicker: true,timePicker: true, timePickerIncrement: 30, format: 'DD/MM/YYYY h:mm A'});
	$('#endDateMeeting').daterangepicker({ singleDatePicker: true,timePicker: true, timePickerIncrement: 30, format: 'DD/MM/YYYY h:mm A'});	
	
	
	$("#btnCallSave").click(function(){
		$('#frmAddCall').submit();
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
		    "modifyBy": "${SESSION}",
		    "email": $.trim($("#lea_email").val())
	  	};	
		
		/* alert(getStringToNull("lea_assignto"))
		
		dis(frmLeadDetailData); */
		
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
                        format: 'DD/MM/YYYY',
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
		//$("#btnCallSave").text("Update");
		if($("#btnCallSave").text() == 'Save'){
			
			$.ajax({
				url : server+"/call/add",
				type : "POST",
				data : JSON.stringify({ 
				      "callStartDate": getDateByFormat("callStartDate"),
				      "callDuration": getValueStringById("callDuration"),
				      "callCreateBy": username,
				      "callStatus": {"callStatusId":getIntToNull("callStatus")},
				      "callDes": getValueStringById("callDescription"),
				      "callSubject": getValueStringById("callSubject"),
				      "callAssignTo": {"userID": getStringToNull("callAssignTo")},
				      "callRelatedToFieldId": leadId,
				      "callRelatedToModuleType": 'Lead',
				      "callCreateDate": moment().format('YYYY-MM-DD')
				      
				}),
				beforeSend: function(xhr) {
						    xhr.setRequestHeader("Accept", "application/json");
						    xhr.setRequestHeader("Content-Type", "application/json");
			    },
				success:function(data){	
						if(data.MESSAGE == 'INSERTED'){
							
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
					  "callStartDate": getDateByFormat("callStartDate"),
				      "callDuration": getValueStringById("callDuration"),
				      "callCreateBy": username,
				      "callStatus": {"callStatusId":getIntToNull("callStatus")},
				      "callDes": getValueStringById("callDescription"),
				      "callSubject": getValueStringById("callSubject"),
				      "callAssignTo": {"userID": getStringToNull("callAssignTo")},
				      "callRelatedToFieldId": leadId,
				      "callRelatedToModuleType": 'Lead',
				      "callCreateDate": moment().format('YYYY-MM-DD')
				}),
				beforeSend: function(xhr) {
					xhr.setRequestHeader("Accept", "application/json");
				    xhr.setRequestHeader("Content-Type", "application/json");
			    },
				success:function(data){					
					dis(data)
				},
				error:function(){
					errorMessage();
				}
			});
			
		}
		
	});	
	
	
});
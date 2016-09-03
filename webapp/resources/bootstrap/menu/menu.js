function errorMessage(){
	sweetAlert("Warning", "Something went wrong!", "error");
}




function funcSelectCustomer(link, action, id, name_select, val){
	
	$.ajax({
		url: "${pageContext.request.contextPath}/customer/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			$(id).empty().append('<option value="">-- SELECT '+name_select+' --</option>');
			 $.each(dataObject, function(key, value){
				var div = "<option value='"+value.custID+"' >"+value.custName+"</option>";
				 $(id).append(div);
			});  
			if(val != "")
				$(id).select2("val",val);
			} 
		});
	
}

function funcSelectContact(id, name_select, val){
	
	$.ajax({
		url: "${pageContext.request.contextPath}/contact/list",
		method: "GET",
		header: "application/json",
		success: function(data){
			var dataObject = data.DATA;
			$(id).empty().append('<option value="">-- SELECT '+name_select+' --</option>');
			 $.each(dataObject, function(key, value){
				var div = "<option value='"+value.conID+"' >"+value.conFirstname+" "+value.conLastname+"</option>";
				 $(id).append(div);
			});  
			if(val != "")
				$(id).select2("val",val);
			} 
		});
	
}





function selectMenu(menu_slide){
	
	
	
	switch (menu_slide) {
	
    case "listCampaigns":
       	removeCla("#marketing","#ul_marketing","#ul_li_campaign","#marketing_icon_campaign");
        document.title = 'Campaigns | CRM';
        break;
    case "createCampaigns":
    	removeCla("#marketing","#ul_marketing","#ul_li_campaign","#marketing_icon_campaign");
    	document.title = 'Create Campaign | CRM';
        break;
    case "updateCampaigns":
    	removeCla("#marketing","#ul_marketing","#ul_li_campaign","#marketing_icon_campaign");
    	document.title = 'Update Campaign | CRM';
        break;
    case "viewCampaigns":
    	removeCla("#marketing","#ul_marketing","#ul_li_campaign","#marketing_icon_campaign");
    	document.title = 'View Campaigns | CRM';
        break;

        
    case "listLeads":
    	removeCla("#marketing","#ul_marketing","#ul_li_lead","#marketing_icon_lead");
    	document.title = 'Leads | CRM';
        break;
    case "viewLeads":
    	removeCla("#marketing","#ul_marketing","#ul_li_lead","#marketing_icon_lead");
    	document.title = 'View Leads | CRM';
        break;
    case "createLeads":
    	removeCla("#marketing","#ul_marketing","#ul_li_lead","#marketing_icon_lead");
    	document.title = 'Create Lead | CRM';
        break;
    case "updateLeads":
    	removeCla("#marketing","#ul_marketing","#ul_li_lead","#marketing_icon_lead");
    	document.title = 'Update Lead | CRM';
        break;
    case "convertLead":
    	removeCla("#marketing","#ul_marketing","#ul_li_lead","#marketing_icon_lead");
    	document.title = 'Convert Lead | CRM';
        break;
        
        
      
    case "listCustomer":
    	removeCla("#sale","#ul_sale","#ul_li_customer","#sale_icon_customer");
    	document.title = 'Customers | CRM';
        break;
    case "viewCustomer":
    	removeCla("#sale","#ul_sale","#ul_li_customer","#sale_icon_customer");
    	document.title = 'View Customers | CRM';
        break;
    case "createCustomer":
    	removeCla("#sale","#ul_sale","#ul_li_customer","#sale_icon_customer");
    	document.title = 'Create Customer | CRM';
        break;
    case "updateCustomer":
    	removeCla("#sale","#ul_sale","#ul_li_customer","#sale_icon_customer");
    	document.title = 'Update Customer | CRM';
        break;

    case "listContacts":
    	removeCla("#sale","#ul_sale","#ul_li_contact","#sale_icon_contact");
    	document.title = 'Contacts | CRM';
        break;
    case "viewContacts":
    	removeCla("#sale","#ul_sale","#ul_li_contact","#sale_icon_contact");
    	document.title = 'View Contacts | CRM';
        break;
    case "createContacts":
    	removeCla("#sale","#ul_sale","#ul_li_contact","#sale_icon_contact");
    	document.title = 'Create Contact | CRM';
        break;
    case "updateContacts":
    	removeCla("#sale","#ul_sale","#ul_li_contact","#sale_icon_contact");
    	document.title = 'Update Contact | CRM';
        break;

    case "viewOpportunity":
    	removeCla("#sale","#ul_sale","#ul_li_opportunity","#sale_icon_opportunity");
    	document.title = 'View Opportunitys | CRM';
        break;
    case "createOpportunity":
    	removeCla("#sale","#ul_sale","#ul_li_opportunity","#sale_icon_opportunity");
    	document.title = 'Create Opportunity | CRM';
        break;
    case "updateOpportunity":
    	removeCla("#sale","#ul_sale","#ul_li_opportunity","#sale_icon_opportunity");
    	document.title = 'Update Opportunity | CRM';
        break;
    case "listOpportunity":
    	removeCla("#sale","#ul_sale","#ul_li_opportunity","#sale_icon_opportunity");
    	document.title = 'Opportunitys | CRM';
        break;

    case "viewCases":
    	removeCla("#support","#ul_support","#ul_li_case","#support_icon_case");
    	document.title = 'View Cases | CRM';
        break;
    case "createCase":
    	removeCla("#support","#ul_support","#ul_li_case","#support_icon_case");
    	document.title = 'Create Case | CRM';
        break;
    case "updateCase":
    	removeCla("#support","#ul_support","#ul_li_case","#support_icon_case");
    	document.title = 'Update Case | CRM';
        break;
    case "listCases":
    	removeCla("#support","#ul_support","#ul_li_case","#support_icon_case");
    	document.title = 'Cases | CRM';
        break;

    case "userManagement":
    	removeCla("#admin","#ul_admin","#ul_li_userMa","#admin_icon_userMa");
    	document.title = 'User Management | CRM';
        break;
    case "categoryType":
    	removeCla("#admin","#ul_admin","#ul_li_add","#admin_icon_add");
    	document.title = 'Category | CRM';
        break;
    case "campaignStatus":
    	removeCla("#admin","#ul_admin","#ul_li_add","#admin_icon_add");
    	document.title = 'Campaign Status | CRM';
        break;
    case "campaignType":
    	removeCla("#admin","#ul_admin","#ul_li_add","#admin_icon_add");
    	document.title = 'Campaign Types | CRM';
        break;
    case "leadStatus":
    	removeCla("#admin","#ul_admin","#ul_li_add","#admin_icon_add");
    	document.title = 'Lead Status | CRM';
        break; 
    case "industries":
    	removeCla("#admin","#ul_admin","#ul_li_add","#admin_icon_add");
    	document.title = 'Industries | CRM';
        break; 
        
    case "accountType":
    	removeCla("#admin","#ul_admin","#ul_li_add","#admin_icon_add");
    	document.title = 'Account Type | CRM';
        break; 
    case "callStatus":
    	removeCla("#admin","#ul_admin","#ul_li_add","#admin_icon_add");
    	document.title = 'Call Status | CRM';
        break; 
    case "meetingStatus":
    	removeCla("#admin","#ul_admin","#ul_li_add","#admin_icon_add");
    	document.title = 'Meeting Status | CRM';
        break; 
    case "taskStatus":
    	removeCla("#admin","#ul_admin","#ul_li_add","#admin_icon_add");
    	document.title = 'Task Status | CRM';
        break; 
    case "opportunityType":
    	removeCla("#admin","#ul_admin","#ul_li_add","#admin_icon_add");
    	document.title = 'Opportunity Type | CRM';
        break; 
    case "opportunityStage":
    	removeCla("#admin","#ul_admin","#ul_li_add","#admin_icon_add");
    	document.title = 'Opportunity Stage | CRM';
        break; 
    case "caseStatus":
    	removeCla("#admin","#ul_admin","#ul_li_add","#admin_icon_add");
    	document.title = 'Case Status | CRM';
        break; 
    case "caseType":
    	removeCla("#admin","#ul_admin","#ul_li_add","#admin_icon_add");
    	document.title = 'Case Type | CRM';
        break; 
    case "casePriority":
    	removeCla("#admin","#ul_admin","#ul_li_add","#admin_icon_add");
    	document.title = 'Case Priority | CRM';
        break; 
      //Activities 
    case "listCalls":
    	removeCla("#activ","#ul_activ","#ul_li_call","#activ_icon_call");
    	document.title = 'Calls | CRM';
        break;
    case "createCall":
    	removeCla("#activ","#ul_activ","#ul_li_call","#activ_icon_call");
    	document.title = 'Create Call | CRM';
        break;
    case "viewCalls":
    	removeCla("#activ","#ul_activ","#ul_li_call","#activ_icon_call");
    	document.title = 'View Calls | CRM';
        break;
    case "updateCall":
    	removeCla("#activ","#ul_activ","#ul_li_call","#activ_icon_call");
    	document.title = 'Update Call | CRM';
        break;

    case "listMeetings":
    	removeCla("#activ","#ul_activ","#ul_li_meeting","#activ_icon_meeting");
    	document.title = 'Meetings | CRM';
        break;
    case "create-Meeting":
    	removeCla("#activ","#ul_activ","#ul_li_meeting","#activ_icon_meeting");
    	document.title = 'Create Meeting | CRM';
        break;
    case "viewMeeting":
    	removeCla("#activ","#ul_activ","#ul_li_meeting","#activ_icon_meeting");
    	document.title = 'View Meetings | CRM';
        break;
    case "updateMeeting":
    	removeCla("#activ","#ul_activ","#ul_li_meeting","#activ_icon_meeting");
    	document.title = 'Update Meeting | CRM';
        break;

    case "listTasks":
    	removeCla("#activ","#ul_activ","#ul_li_task","#activ_icon_task");
    	document.title = 'Tasks | CRM';
        break;
    case "createTask":
    	removeCla("#activ","#ul_activ","#ul_li_task","#activ_icon_task");
    	document.title = 'Create Tasks | CRM';
        break;
    case "viewTasks":
    	removeCla("#activ","#ul_activ","#ul_li_task","#activ_icon_task");
    	document.title = 'View Tasks | CRM';
        break;
    case "updateTask":
    	removeCla("#activ","#ul_activ","#ul_li_task","#activ_icon_task");
    	document.title = 'Update Task | CRM';
        break;

    case "listEvents":
    	removeCla("#activ","#ul_activ","#ul_li_event","#activ_icon_event");
    	document.title = 'Events | CRM';
        break;
    case "createEvent":
    	removeCla("#activ","#ul_activ","#ul_li_event","#activ_icon_event");
    	document.title = 'Create Event | CRM';
        break;
    case "viewEvents":
    	removeCla("#activ","#ul_activ","#ul_li_event","#activ_icon_event");
    	document.title = 'View Events | CRM';
        break;
    case "updateEvent":
    	removeCla("#activ","#ul_activ","#ul_li_event","#activ_icon_event");
    	document.title = 'Update Event | CRM';
        break;

    case "listNotes":
    	removeCla("#activ","#ul_activ","#ul_li_note","#activ_icon_note");
    	document.title = 'Notes | CRM';
        break;
    case "createNote":
    	removeCla("#activ","#ul_activ","#ul_li_note","#activ_icon_note");
    	document.title = 'Create Note | CRM';
        break;
    case "viewNotes":
    	removeCla("#activ","#ul_activ","#ul_li_note","#activ_icon_note");
    	document.title = 'View Notes | CRM';
        break;
    case "updateNote":
    	removeCla("#activ","#ul_activ","#ul_li_note","#activ_icon_note");
    	document.title = 'Update Note | CRM';
        break;
        
    case "listLocations":
    	removeCla("#activ","#ul_activ","#ul_li_loca","#activ_icon_loca");
    	document.title = 'Locations | CRM';
        break;
    case "createLocation":
    	removeCla("#activ","#ul_activ","#ul_li_loca","#activ_icon_loca");
    	document.title = 'Create Location | CRM';
        break;
    case "viewLocations":
    	removeCla("#activ","#ul_activ","#ul_li_loca","#activ_icon_loca");
    	document.title = 'View Location | CRM';
        break;
    case "updateLocation":
    	removeCla("#activ","#ul_activ","#ul_li_loca","#activ_icon_loca");
    	document.title = 'Update Location | CRM';
        break;
   
    case "roleManagement":
    	removeCla("#admin","#ul_admin","#ul_li_role","#admin_icon_role");
    	document.title = 'Role Managememt | CRM';
        break;
    case "updateRole":
    	removeCla("#admin","#ul_admin","#ul_li_role","#admin_icon_role");
    	document.title = 'Update Role Managememt | CRM';
        break;
    case "createRole":
    	removeCla("#admin","#ul_admin","#ul_li_role","#admin_icon_role");
    	document.title = 'Create Role Managememt | CRM';
        break;
    case "viewRoleManagement":
    	removeCla("#admin","#ul_admin","#ul_li_role","#admin_icon_role");
    	document.title = 'Role Managememt | CRM';
        break;
        
    case "quote":
    	removeCla("#quote","#ul_quote","#ul_li_quote","#quote_icon_quote");
    	document.title = 'Quote | CRM';
        break;
        
        
        
        
        
        
    default:
    	$("#dashboard").removeAttr("class").attr('class', 'treeview active');
    	document.title = 'Dashbord';
	}
}

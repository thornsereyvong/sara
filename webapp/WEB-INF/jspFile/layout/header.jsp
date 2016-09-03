


<script type="text/javascript">

var session = "${SESSION}";
if(session == "" || session == "anonymousUser"){
	window.location = "${pageContext.request.contextPath}/login";
	
}else{
	 $.session.set("parentID", session);
}


function funcSelectCustomer(part, get, id, cust, vals){
	 $(id).empty().append('<option value="">-- SELECT '+cust+' --</option>');
	 
	$.ajax({
			url: "${pageContext.request.contextPath}/customer/list",
			method: "GET",
			header: "application/json",
			success: function(dataString){
				var dataObject = dataString.DATA;
								
				$.each(dataObject, function(key, value){
					var div = "<option value='"+value.custID+"' >"+value.custName+"</option>";
					$(id).append(div);
				}); 

				if(vals != ""){
					$(id).select2("val",vals);	
				} 
				
				} 
			}); 
		
}

function funcSelectContact(id, cust, vals){
	 $(id).empty().append('<option value="">-- SELECT '+cust+' --</option>');
	$.ajax({
			url: "${pageContext.request.contextPath}/contact/list",
			method: "GET",
			header: "application/json",
			success: function(dataString){
				var dataObject = dataString.DATA;
								
				$.each(dataObject, function(key, value){
					var div = "<option value='"+value.conID+"' >"+value.conFirstName+"  "+value.conLastName+"</option>";
					$(id).append(div);
				}); 

				if(vals != ""){
					$(id).select2("val",vals);	
				} 
				
				} 
			}); 
		
}

function funcRelateTo(id, cust, vals){
	
	if(cust != ""){
		$(id).empty().append('<option value="">-- SELECT '+cust+' --</option>');
		$(id).select2("val","");
		$.ajax({
				url: "${pageContext.request.contextPath}/"+cust+"/list",
				method: "GET",
				header: "application/json",
				success: function(dataString){
					var dataObject = dataString.DATA;
					
					switch (cust) {
						 case "customer":
							 	
								$.each(dataObject, function(key, value){
									var div = "<option value='"+value.custID+"' >"+value.custName+"</option>";
									$(id).append(div);
								});
								
								if(vals != ""){
									$(id).select2("val",vals);	
								} 
								
						        break;
						 case "lead":
								$.each(dataObject, function(key, value){
									var div = "<option value='"+value.leadID+"' >"+value.salutation+" "+value.firstName+"  "+value.lastName+"</option>";
									$(id).append(div);
								});
								if(vals != ""){
									$(id).select2("val",vals);	
								} 
								
						        break;
						 case "campaign":
								$.each(dataObject, function(key, value){
									var div = "<option value='"+value.campID+"' >"+value.campName+" </option>";
									$(id).append(div);
								});
								
								if(vals != ""){
									$(id).select2("val",vals);	
								} 
								
						        break;
						 case "contact":
							 
								$.each(dataObject, function(key, value){
									var div = "<option value='"+value.conID+"' >"+value.conFirstName+"  "+value.conLastName+"</option>";
									
									$(id).append(div);
								});
								
								if(vals != ""){
									$(id).select2("val",vals);	
								} 	
											
								break;
						 case "opportunity":
								$.each(dataObject, function(key, value){
									var div = "<option value='"+value.opId+"' >"+value.opName+"</option>";
									$(id).append(div);	
								});
								if(vals != ""){
									$(id).select2("val",vals);	
								} 
								
						        break;
						 case "case":
								$.each(dataObject, function(key, value){
									var div = "<option value='"+value.caseId+"' >"+value.subject+"</option>";
									$(id).append(div);
								});
								if(vals != ""){
									$(id).select2("val",vals);	
								} 
								
						        break;
						 case "task":
								 $.each(dataObject, function(key, value){
									var div = "<option value='"+value.taskId+"' >"+value.taskSubject+"</option>";
									$(id).append(div);
								});
								if(vals != ""){
									$(id).select2("val",vals);	
								} 
						        break;
					

					
					}		
					 

					
					
					} 
				}); 
			
	}else{
		$(id).empty().append('<option value="">-- SELECT --</option>');
	}
}



function userAllList(fil, id, val){
	$.each(fil, function(i, value){
		var div = "<option value='"+value.userID+"'>"+value.username+"</option>";
		$(id).append(div); 
	});	
	if(val != ""){
		$(id).select2("val",val);	
	}
}

function testJson(data){
	$.each(data, function(i, value){
		$("#test_div").append('"'+i+'" :'+'"'+value+'",');
		console.log(i+": "+value);
	});	
}


function userReportList(id,vals){
	var data = ${users};
	
	$.each(data, function(i, value){
		$.ajax({
			url: "${pageContext.request.contextPath}/user/list/id/"+value.parentID,
			method: "GET",
			header: "application/json",
			success: function(dataString){
				var dataObject = dataString.DATA;			
				var div = "<option value='"+dataObject.userID+"'>"+dataObject.username+"</option>";
				$(id).append(div); 
				if(vals != ""){
					$(id).select2("val",vals);	
				} 
				
				} 
			}); 
		
	});	
}



</script>
<style>
.has-error .select2-selection {
    border: 1px solid #a94442;
    border-radius: 2px;
}
.has-success .select2-selection{
	border: 1px solid #00a65a;
    border-radius: 2px;
}
</style>
  <body class="sidebar-mini wysihtml5-supported skin-red-light">
    <div class="wrapper">
      <header class="main-header">
        <!-- Logo -->
        <a href="#" class="logo">
          <!-- mini logo for sidebar mini 50x50 pixels -->
          <span class="logo-mini" ><b>CRM</b></span>
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg" id="ffa"><b>App</b> Balancika</span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
          </a>
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
            
              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <img src="${pageContext.request.contextPath}/resources/images/user-icon-512.png" class="user-image" alt="User Image">
                  <span class="hidden-xs">Hi ${SESSION}!</span>
                  
                </a>
                <ul class="dropdown-menu">
                  <!-- User image -->
                  <li class="user-header">
                    <img src="${pageContext.request.contextPath}/resources/images/user-icon-512.png" class="img-circle" alt="User Image">
                    <p>
                   
                  </li>
                  <li class="user-footer">
                   
                    <div class="pull-right">
                      <a href="${pageContext.request.contextPath}/logout" class="btn btn-default btn-flat">Sign out</a>
                    </div>
                  </li>
                </ul>
              </li>
            </ul>
          </div>
        </nav>
      </header>
     
     

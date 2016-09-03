<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <% String menu = (String)request.getAttribute("menu"); %>       
            <li <% if(menu == "index"){
            		out.print("class='active'");
           		 }
            %>>
              <a href="${pageContext.request.contextPath}/">
                <i class="fa fa-tachometer" aria-hidden="true"></i>
                <span>Home</span>
              </a>
            </li>
  	
            
            <li <% if(menu == "listCampaigns" || menu == "createCampaigns" || menu == "viewCampaigns" || menu == "createLeads" || menu == "listLeads" || menu == "updateCampaigns" || menu == "updateLeads"){ out.print("class='treeview active'"); } else{ out.print("class='treeview '"); }%>>
              <a href="#"><i class="fa fa-shopping-cart" aria-hidden="true"></i> <span>Marketing</span> <i class="fa fa-angle-left pull-right"></i></a>
              <ul class="treeview-menu" <% if(menu == "listCampaigns" || menu == "createCampaigns" || menu == "createLeads" || menu == "updateLeads" || menu == "listLeads"){ out.print("style='display:block;'"); } %>>
              
                <li <% if(menu == "listCampaigns" || menu == "viewCampaigns" || menu == "createCampaigns" || menu == "updateCampaigns"){out.print("class='active'"); }%>>
	              <a href="${pageContext.request.contextPath}/listCampaigns"> 
	              
	              	<% if(menu == "listCampaigns" || menu == "viewCampaigns" || menu == "createCampaigns" || menu == "updateCampaigns"){
	              			out.print("<i class='fa fa-check-circle' aria-hidden='true'></i>"); 
	              		}else{
	              			out.print("<i class='fa fa-circle-o' aria-hidden='true'></i>"); 
	              		}
	              	%>	
	              	<span>Campaigns</span></a>
	            </li>
	            
                 <li <% if(menu == "listLeads" || menu == "createLeads" || menu == "viewLeads" || menu == "updateLeads" ){ out.print("class='active'"); } %>>
		              <a href="${pageContext.request.contextPath}/listLeads">
		              
		              <% if(menu == "listLeads" || menu == "createLeads" || menu == "viewLeads" || menu == "updateLeads" ){
	              			out.print("<i class='fa fa-check-circle' aria-hidden='true'></i>"); 
	              		}else{
	              			out.print("<i class='fa fa-circle-o' aria-hidden='true'></i>"); 
	              		}
	              	  %>
	              	  
		             <span>Leads</span> </a>
		         </li>
		         
              </ul>
            </li>
            
            <li <% if(menu == "listCustomer" || menu == "viewCustomer" || menu == "createCustomer" || menu == "updateCustomer" || menu == "listContacts" || menu == "createContacts" || menu == "listOpportunity" || menu == "createOpportunity" || menu == "viewOpportunity" || menu == "updateOpportunity" || menu == "viewContacts" || menu == "updateContacts"){ out.print("class='treeview active'"); } else{ out.print("class='treeview '"); }%>>
              <a href="#"><i class="fa fa-calculator" aria-hidden="true"></i> <span>Sales</span> <i class="fa fa-angle-left pull-right"></i></a>
              <ul class="treeview-menu" <% if(menu == "listCustomer" || menu == "viewCustomer" || menu == "createCustomer" || menu == "updateCustomer" || menu == "listContacts" || menu == "createContacts" || menu == "listOpportunity" || menu == "createOpportunity" || menu == "viewOpportunity" || menu == "updateOpportunity" || menu == "viewContacts" || menu == "updateContacts"){ out.print("style='display:block;'"); } %>>
               
                <li <% if(menu == "listCustomer" || menu == "viewCustomer" || menu == "createCustomer" || menu == "updateCustomer"){ out.print("class='active'"); } %>>
             		 <a href="${pageContext.request.contextPath}/listCustomer">
             		 <% if(menu == "listCustomer" || menu == "viewCustomer" || menu == "createCustomer" || menu == "updateCustomer"){
	              			out.print("<i class='fa fa-check-circle' aria-hidden='true'></i>"); 
	              		}else{
	              			out.print("<i class='fa fa-circle-o' aria-hidden='true'></i>"); 
	              		}
	              	  %>
             		<span>Customer</span> </a>
           		 </li>
           		 
                <li <% if(menu == "listContacts" || menu == "createContacts" || menu == "viewContacts" || menu == "updateContacts"){ out.print("class='active'"); } %>>
              		<a href="${pageContext.request.contextPath}/listContacts">
              		
              		<% if(menu == "listContacts" || menu == "createContacts" || menu == "viewContacts" || menu == "updateContacts"){
	              			out.print("<i class='fa fa-check-circle' aria-hidden='true'></i>"); 
	              		}else{
	              			out.print("<i class='fa fa-circle-o' aria-hidden='true'></i>"); 
	              		}
	              	  %>
	              	  
              		<span>Contacts</span></a>
           		 </li>
	            
                 <li <% if(menu == "listOpportunity" || menu == "createOpportunity" || menu == "viewOpportunity" || menu == "updateOpportunity"){ out.print("class='active'");} %>>
             		 <a href="${pageContext.request.contextPath}/listOpportunity">
             		 
             		 <% if(menu == "listOpportunity" || menu == "createOpportunity" || menu == "viewOpportunity" || menu == "updateOpportunity"){
	              			out.print("<i class='fa fa-check-circle' aria-hidden='true'></i>"); 
	              		}else{
	              			out.print("<i class='fa fa-circle-o' aria-hidden='true'></i>"); 
	              		}
	              	  %>
             		 <span>Opportunity</span> </a>
          		 </li>
            
		         
              </ul>
            </li>
            
            
            <li <% if(menu == "listCalls" || menu == "createCall" || menu == "createMeeting" || menu == "listMeetings" || menu == "createNote" || menu == "listNotes" ){ out.print("class='treeview active'"); } else{ out.print("class='treeview '"); }%>>
              <a href="#"><i class="fa fa-paper-plane-o" aria-hidden="true"></i> <span>Activities</span> <i class="fa fa-angle-left pull-right"></i></a>
              <ul class="treeview-menu" <% if(menu == "listCalls" || menu == "createCall" || menu == "createMeeting" || menu == "listMeetings" || menu == "createNote" || menu == "listNotes" ){ out.print("style='display:block;'"); } %>>
              
                 <li <% if(menu == "listCalls"){ out.print("class='active'"); } %>>
             		 <a href="${pageContext.request.contextPath}/listCalls">
             		 <% if(menu == "listCalls"){
	              			out.print("<i class='fa fa-check-circle' aria-hidden='true'></i>"); 
	              		}else{
	              			out.print("<i class='fa fa-circle-o' aria-hidden='true'></i>"); 
	              		}
	              	  %>
             		<span>Calls</span> </a>
           		 </li>
           		 
           		 <li <% if(menu == "listMeetings"){ out.print("class='active'"); } %>>
             		 <a href="${pageContext.request.contextPath}/listMeetings">
             		 <% if(menu == "listMeetings"){
	              			out.print("<i class='fa fa-check-circle' aria-hidden='true'></i>"); 
	              		}else{
	              			out.print("<i class='fa fa-circle-o' aria-hidden='true'></i>"); 
	              		}
	              	  %>
             		<span>Meetings</span> </a>
           		 </li>
           		 
           		 <li <% if(menu == "listTasks"){ out.print("class='active'"); } %>>
             		 <a href="${pageContext.request.contextPath}/listTasks">
             		 <% if(menu == "listTasks" || menu == "viewTasks"){
	              			out.print("<i class='fa fa-check-circle' aria-hidden='true'></i>"); 
	              		}else{
	              			out.print("<i class='fa fa-circle-o' aria-hidden='true'></i>"); 
	              		}
	              	  %>
             		<span>Tasks</span> </a>
           		 </li>
           		 
           		 <li <% if(menu == "listNotes"){ out.print("class='active'"); } %>>
             		 <a href="${pageContext.request.contextPath}/listNotes">
             		 <% if(menu == "listNotes"){
	              			out.print("<i class='fa fa-check-circle' aria-hidden='true'></i>"); 
	              		}else{
	              			out.print("<i class='fa fa-circle-o' aria-hidden='true'></i>"); 
	              		}
	              	  %>
             		<span>Notes</span> </a>
           		 </li>
           		 
           		  <li <% if(menu == "listEvents"){ out.print("class='active'"); } %>>
             		 <a href="${pageContext.request.contextPath}/listEvents">
             		 <% if(menu == "listEvents" || menu == "viewTasks"){
	              			out.print("<i class='fa fa-check-circle' aria-hidden='true'></i>"); 
	              		}else{
	              			out.print("<i class='fa fa-circle-o' aria-hidden='true'></i>"); 
	              		}
	              	  %>
             		<span>Events</span> </a>
           		 </li>
           		 
              </ul>
            </li>
            
            
             <li <% if(menu == "listCases" || menu == "createCase" ){ out.print("class='treeview active'"); } else{ out.print("class='treeview '"); }%>>
              <a href="#"><i class="fa fa-life-ring" aria-hidden="true"></i> <span>Support</span> <i class="fa fa-angle-left pull-right"></i></a>
              <ul class="treeview-menu" <% if(menu == "listCases" || menu == "createCase" ){ out.print("style='display:block;'"); } %>>
              
                 <li <% if(menu == "listCases"){ out.print("class='active'"); } %>>
             		 <a href="${pageContext.request.contextPath}/listCases">
             		 <% if(menu == "listCases"){
	              			out.print("<i class='fa fa-check-circle' aria-hidden='true'></i>"); 
	              		}else{
	              			out.print("<i class='fa fa-circle-o' aria-hidden='true'></i>"); 
	              		}
	              	  %>
             		<span>Cases</span> </a>
           		 </li>
              </ul>
            </li>
            
         
            <li <% if(menu == "listCustomer" || menu == "createCustomer"  || menu == "updateCustomer" || menu == "viewCustomer"  ){ out.print("class='treeview active'"); } else{ out.print("class='treeview '"); }%>>
              <a href="#"><i class="fa fa-cubes" aria-hidden="true"></i> <span>Other</span> <i class="fa fa-angle-left pull-right"></i></a>
              <ul class="treeview-menu" <% if(menu == "listCustomer" || menu == "createCustomer"  || menu == "updateCustomer" ){ out.print("style='display:block;'"); } %>>
                 
              </ul>
            </li>
             
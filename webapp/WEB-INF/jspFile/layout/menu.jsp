
<%
	String menu = (String) request.getAttribute("menu");
%>
<%
	String role = (String) request.getAttribute("role_CRM_ADMIN");
%>
<style>
.color_menu {
	color: #b9292d;
}
</style>
<script>

function removeCla(id,ul,ul_li,icon){
	$(id).removeAttr("class").attr('class', 'treeview active');
   	$(ul).css('display', '');
   	$(ul).css('display', 'block');
	$(ul_li).removeAttr("class").attr('class', 'active');
   	$(icon).removeAttr("class").attr('class', 'fa fa-check-circle color_menu');
}

$(document).ready(function(){
	selectMenu('${menu}');
});

	//document.getElementById("demo").innerHTML = text;
</script>
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- Sidebar user panel -->
		<%-- <div class="user-panel">
			<div class="pull-left image">
				<img
					src="${pageContext.request.contextPath}/resources/images/user-icon-512.png"
					class="img-circle" alt="User Image">
			</div>
			<div class="pull-left info">
				<p>
					Balancika <strong>CRM</strong>
				</p>

			</div>
		</div> --%>

		<ul class="sidebar-menu">
			<li id="dashboard"><a href="${pageContext.request.contextPath}/"><img
					src="${pageContext.request.contextPath}/resources/images/Dashboard.png"
					style="width: 16px;"> &nbsp;&nbsp;<span>Dashboard</span> </a></li>

			<li class='treeview' id="marketing"><a href="#"><img
					src="${pageContext.request.contextPath}/resources/images/Marketing.png"
					style="width: 16px;">&nbsp;&nbsp;<!-- <i class="fa fa-shopping-cart" aria-hidden="true"></i> -->
					<span>Marketing</span> <i class="fa fa-angle-left pull-right"></i></a>
				<ul class="treeview-menu" id="ul_marketing">

					<li id="ul_li_campaign"><a
						href="${pageContext.request.contextPath}/list-campaigns"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="marketing_icon_campaign"></i> <span>Campaigns</span></a></li>

					<li id="ul_li_lead"><a
						href="${pageContext.request.contextPath}/list-leads"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="marketing_icon_lead"></i> <span>Leads</span>
					</a></li>

				</ul></li>

			<li class='treeview' id="sale"><a href="#"><img
					src="${pageContext.request.contextPath}/resources/images/Sales.png"
					style="width: 16px;">&nbsp;&nbsp;<!-- <i class="fa fa-calculator" aria-hidden="true"></i> -->
					<span>Sales</span> <i class="fa fa-angle-left pull-right"></i></a>
				<ul class="treeview-menu" id="ul_sale">

					<li id="ul_li_customer"><a
						href="${pageContext.request.contextPath}/list-customers"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="sale_icon_customer"></i> <span>Customers</span>
					</a></li>

					<li id="ul_li_contact"><a
						href="${pageContext.request.contextPath}/list-contacts"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="sale_icon_contact"></i> <span>Contacts</span></a></li>

					<li id="ul_li_opportunity"><a
						href="${pageContext.request.contextPath}/list-opportunity"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="sale_icon_opportunity"></i> <span>Opportunities</span>
					</a></li>

				</ul></li>

			<li class='treeview' id="activ"><a href="#"><img
					src="${pageContext.request.contextPath}/resources/images/activity.png"
					style="width: 16px;">&nbsp;&nbsp;<!-- <i class="fa fa-paper-plane-o" aria-hidden="true"></i> -->
					<span>Activities</span> <i class="fa fa-angle-left pull-right"></i></a>
				<ul class="treeview-menu" id="ul_activ">

					<li id="ul_li_call"><a
						href="${pageContext.request.contextPath}/list-calls"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="activ_icon_call"></i> <span>Calls</span>
					</a></li>

					<li id="ul_li_meeting"><a
						href="${pageContext.request.contextPath}/list-meetings"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="activ_icon_meeting"></i> <span>Meetings</span>
					</a></li>

					<li id="ul_li_task"><a
						href="${pageContext.request.contextPath}/list-tasks"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="activ_icon_task"></i> <span>Tasks</span>
					</a></li>

					<li id="ul_li_note"><a
						href="${pageContext.request.contextPath}/list-notes"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="activ_icon_note"></i> <span>Notes</span>
					</a></li>

					<li id="ul_li_event"><a
						href="${pageContext.request.contextPath}/list-events"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="activ_icon_event"></i> <span>Events</span>
					</a></li>

					<li id="ul_li_loca"><a
						href="${pageContext.request.contextPath}/list-locations"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="activ_icon_loca"></i> <span>Locations</span>
					</a></li>

				</ul></li>

			<li class='treeview ' id="support"><a href="#"><img
					src="${pageContext.request.contextPath}/resources/images/Support.png"
					style="width: 16px;">&nbsp;&nbsp;<!-- <i class="fa fa-life-ring" aria-hidden="true"></i> -->
					<span>Support</span> <i class="fa fa-angle-left pull-right"></i></a>
				<ul class="treeview-menu" id="ul_support">

					<li id="ul_li_case"><a
						href="${pageContext.request.contextPath}/list-cases"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="support_icon_case"></i> <span>Cases</span>
					</a></li>
					<li id="ul_li_article"><a
						href="${pageContext.request.contextPath}/list-articles"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="support_icon_article"></i> <span>Knowledge Base Articles</span>
					</a></li>
				</ul>
			</li>


			<li class='' id="quote"><a
				href="${pageContext.request.contextPath}/quote/list"><img
					src="${pageContext.request.contextPath}/resources/images/Quote.png"
					style="width: 16px;">&nbsp;&nbsp;<!-- <i class="fa fa-money" aria-hidden="true"></i> -->
					<span>Quote</span> <!-- <i class="fa fa-angle-left pull-right"></i> --></a>
			</li>
			<li class='treeview ' id="sale_order"><a
				href="${pageContext.request.contextPath}/sale-order/list"><img
					src="${pageContext.request.contextPath}/resources/images/Sale-Order.png"
					style="width: 16px;">&nbsp;&nbsp;<!-- <i class="fa fa-balance-scale" aria-hidden="true"></i> -->
					<span>Sale Order</span> <!-- <i class="fa fa-angle-left pull-right"></i> --></a>
			</li>
			
			<li class='treeview ' id="hbu"><a href="#"><img
					src="${pageContext.request.contextPath}/resources/images/Support.png"
					style="width: 16px;">&nbsp;&nbsp;<!-- <i class="fa fa-life-ring" aria-hidden="true"></i> -->
					<span>HBU</span> <i class="fa fa-angle-left pull-right"></i></a>
				<ul class="treeview-menu" id="ul_hbu">

					<li id="ul_li_competitor"><a
						href="${pageContext.request.contextPath}/list-competitors"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="hbu_icon_competitor"></i> <span>Competitors</span>
					</a></li>
					<li id="ul_li_competitor_list"><a
						href="${pageContext.request.contextPath}/list-competitors-by-product"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="hbu_icon_competitor_list"></i> <span>Competitor List By Product</span>
					</a></li>
					<li id="ul_li_survey"><a
						href="${pageContext.request.contextPath}/list-market-survey"> <i
							class='fa fa-circle-o color_menu' aria-hidden='true'
							id="hbu_icon_survey"></i> <span>Market Survey</span>
					</a>
					</li>
				</ul>
			</li>

			<%-- <li class="treeview" id="report_menu">
				<a href="#"> <img style="width: 16px;" src="${pageContext.request.contextPath}/resources/images/module/Report-32.png" style="">&nbsp;&nbsp;
					<span>Report</span> <i class="fa fa-angle-left pull-right"></i>
				</a>
				<ul class="treeview-menu" id="repMarketingUl">					
					<li class="" id="repMarketingLi">
						<a href="#">
							<i class="fa fa-circle-o color_menu" id="repMarketingIcon"></i> Marketing<i class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu" id="repMarketingAct">
							<li class="" id="repCampaignLi">
								<a href="#">
									<i class="fa fa-circle-o color_menu" id="repCampaignIcon"></i> Campaigns<i class="fa fa-angle-left pull-right"></i>
								</a>
								<ul class="treeview-menu" id="repCampaignUl">
									<li class="" id="repCampaignAct">
										<a href="${pageContext.request.contextPath}/report/marketing/campaign/top-campaign"><i id="repCampaignIcon1" class="fa fa-circle-o color_menu"></i> Top Campaign</a>
									</li>
									<li>
										<a href="#"><i class="fa fa-circle-o color_menu"></i> Lead By Campaign</a>
									</li>
								</ul>
							</li>
							<li class="">
								<a href="#">
									<i class="fa fa-circle-o"></i> Leads<i class="fa fa-angle-left pull-right"></i>
								</a>
								<ul class="treeview-menu">
									<li>
										<a href="#"><i class="fa fa-circle-o"></i>Exec Lead</a>
									</li>
									
								</ul>
							</li>
						</ul>
					</li>					
				</ul>
			</li> --%>


			<%
				if (role.equals("CRM_ADMIN")) {
			%>
			<li class='treeview ' id="admin"><a href="#"><img
					src="${pageContext.request.contextPath}/resources/images/Administrator.png"
					style="width: 16px;">&nbsp;&nbsp;<!-- <i class="fa fa-cogs" aria-hidden="true"></i> -->
					<span>Administrator</span> <i class="fa fa-angle-left pull-right"></i></a>
				<ul class="treeview-menu" id="ul_admin">

					<li id="ul_li_add"><a
						href="${pageContext.request.contextPath}/category-type"> <i
							class='fa fa-circle-o' aria-hidden='true' id="admin_icon_add"></i>
							<span>Category</span>
					</a></li>
					<li id="ul_li_role"><a
						href="${pageContext.request.contextPath}/role-management"> <i
							class='fa fa-circle-o' aria-hidden='true' id="admin_icon_role"></i>
							<span>Role Management</span>
					</a></li>
					<li id="ul_li_userMa"><a
						href="${pageContext.request.contextPath}/user-management"> <i
							class='fa fa-circle-o' aria-hidden='true' id="admin_icon_userMa"></i>
							<span>User Management</span>
					</a></li>
					<%-- <li id="ul_li_empMa"><a
						href="${pageContext.request.contextPath}/list-employee"> <i
							class='fa fa-circle-o' aria-hidden='true' id="admin_icon_empMa"></i>
							<span>Employees</span>
					</a></li> --%>
				</ul></li>
			<%
				}
			%>


		</ul>
	</section>
	<!-- /.sidebar -->
</aside>
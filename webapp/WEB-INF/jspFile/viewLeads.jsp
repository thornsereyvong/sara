<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>
<%
	String roleDelete = (String) request.getAttribute("role_delete");
%>


<script type="text/javascript">

var app = angular.module('campaign', ['angularUtils.directives.dirPagination','oitozero.ngSweetAlert']);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	$scope.listLeads = function(){
		$http.get("${pageContext.request.contextPath}/lead/list").success(function(response){
				$scope.leads = response.DATA;
			});
		} ;
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	
	$scope.deleteLead = function(leadID){
		SweetAlert.swal({
            title: "Are you sure?", //Bold text
            text: "This Lead will not be able to recover!", //light text
            type: "warning", //type -- adds appropiriate icon
            showCancelButton: true, // displays cancel btton
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes, delete!",
            closeOnConfirm: false, //do not close popup after click on confirm, usefull when you want to display a subsequent popup
            closeOnCancel: false
        }, 
        function(isConfirm){ //Function that triggers on user action.
		var str = '<%=roleDelete%>';
        	
            if(isConfirm){

            	if(str == "YES"){
            		 $http.delete("${pageContext.request.contextPath}/lead/remove/"+leadID)
     	            .success(function(){
     	            		SweetAlert.swal({
     			            		title:"Deleted",
     			            		text:"Lead have been deleted!",
     			            		type:"success",  
     			            		timer: 2000,   
     			            		showConfirmButton: false
     	            		});
     	            		$scope.listLeads();
     	            		window.location.href = "${pageContext.request.contextPath}/view-leads";
     		            });
				}else{
					SweetAlert.swal({
		                title:"Cancelled",
		                text:"You don't have permission delete!",
		                type:"error",
		                timer:2000,
		                showConfirmButton: false});
				}
                
            } else {
                SweetAlert.swal({
	                title:"Cancelled",
	                text:"This Lead is safe!",
	                type:"error",
	                timer:2000,
	                showConfirmButton: false});
            }
        });
	};
	
}]);

</script>
<style>
.icon_color {
	color: #2196F3;
}

.pagination {
	display: inline-block;
	padding-left: 0;
	margin: 0px 0px 13px 0px;
	border-radius: 4px;
	margin-buttom: 10px;
}

.breadcrumb1 {
	padding: 0;
	background: #D4D4D4;
	list-style: none;
	overflow: hidden;
	margin: 20px;
}

.breadcrumb1>li+li:before {
	padding: 0;
}

.breadcrumb1 li {
	float: left;
}

.breadcrumb1 li.active a {
	background: brown; /* fallback color */
	background: #ffc107;
}

.breadcrumb1 li.completed a {
	background: brown; /* fallback color */
	background: hsla(153, 57%, 51%, 1);
}

.breadcrumb1 li.active a:after {
	border-left: 30px solid #ffc107;
}

.breadcrumb1 li.completed a:after {
	border-left: 30px solid hsla(153, 57%, 51%, 1);
}

.breadcrumb1 li a {
	color: white;
	text-decoration: none;
	padding: 10px 0 10px 45px;
	position: relative;
	display: block;
	float: left;
}

.breadcrumb1 li a:after {
	content: " ";
	display: block;
	width: 0;
	height: 0;
	border-top: 50px solid transparent;
	/* Go big on the size, and let overflow hide */
	border-bottom: 50px solid transparent;
	border-left: 30px solid hsla(0, 0%, 83%, 1);
	position: absolute;
	top: 50%;
	margin-top: -50px;
	left: 100%;
	z-index: 2;
}

.breadcrumb1 li a:before {
	content: " ";
	display: block;
	width: 0;
	height: 0;
	border-top: 50px solid transparent;
	/* Go big on the size, and let overflow hide */
	border-bottom: 50px solid transparent;
	border-left: 30px solid white;
	position: absolute;
	top: 50%;
	margin-top: -50px;
	margin-left: 1px;
	left: 100%;
	z-index: 1;
}

.breadcrumb1 li:first-child a {
	padding-left: 15px;
}

.breadcrumb1 li a:hover {
	background: #ffc107;
}

.breadcrumb1 li a:hover:after {
	border-left-color: #ffc107 !important;
}
</style>
<div class="content-wrapper" ng-app="campaign"
	ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>View Lead</h1>
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}"><i
					class="fa fa-home"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i>View Lead</a></li>
		</ol>
	</section>

	<section class="content">


		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
					<div class="box-body">
						<div class="col-md-2">
							<img class="profile-user-img img-responsive"
								src="${pageContext.request.contextPath}/resources/images/logo_red.png"
								alt="User profile picture">
							<h3 class="profile-username text-center">Nina Mcintire</h3>
						</div>
						<div class="col-md-10">
							<ul class="breadcrumb1">
								<li class="completed"><a href="#"> <i
										class="fa fa-check-circle"></i> New
								</a></li>
								<li class="active"><a href="#"> <i
										class="fa fa-check-circle"></i> Assigned
								</a></li>
								<li><a href="#"> <i class="fa fa-lock"></i> In Process
								</a></li>
								<li><a href="#"> <i class="fa fa-lock"></i> Converted
								</a></li>

								<li class="dead"><a href="#"> <i class="fa fa-lock"></i>
										Dead
								</a></li>
							</ul>

						</div>
						
						<div class="clearfix"></div><br/><br/>
							<div class="nav-tabs-custom">
								<ul class="nav nav-tabs">
									<li class="active"><a href="#activity" data-toggle="tab"
										aria-expanded="true">Activity</a></li>
									<li class=""><a href="#timeline" data-toggle="tab"
										aria-expanded="false">Notes</a></li>
									<li class=""><a href="#settings" data-toggle="tab"
										aria-expanded="false">Details</a></li>
								</ul>
								<div class="tab-content">
									<div class="tab-pane active" id="activity">
										
										<section id="emp_info">
											<p class="page-header">Log Call</p>
											<div class="row">
											
											</div>
										</section>
										
									
									</div>
									<!-- /.tab-pane -->
									<div class="tab-pane" id="timeline">
										<div class="col-md-5">
											<form class="form-horizontal">
												<div class="form-group">
													<label for="inputName" class="col-sm-2 control-label">Subject</label>
													<div class="col-sm-10">
														<input type="text" class="form-control" id="inputName"
															placeholder="">
													</div>
												</div>
												<div class="form-group">
													<label for="inputEmail" class="col-sm-2 control-label">Description</label>
													<div class="col-sm-10">
														<textarea rows="3" cols="" name="me_description"
															id="me_description" class="form-control"></textarea>
													</div>
												</div>
												<button type="submit" class="btn btn-info pull-right">Note</button>
											</form>
										</div>

										<div class="clearfix"></div>
										<ul class="timeline timeline-inverse">
											<!-- timeline time label -->
											<li class="time-label"><span class="bg-red"> 10
													Feb. 2014 </span></li>
											<!-- /.timeline-label -->
											<!-- timeline item -->
											<li><i class="fa fa-envelope bg-blue"></i>
												<div class="timeline-item">
													<span class="time"><i class="fa fa-clock-o"></i>
														12:05</span>
													<h3 class="timeline-header">
														<a href="#">Support Team</a> sent you an email
													</h3>
													<div class="timeline-body">Etsy doostang zoodles
														disqus groupon greplin oooj voxy zoodles, weebly ning
														heekya handango imeem plugg dopplr jibjab, movity jajah
														plickers sifteo edmodo ifttt zimbra. Babblely odeo
														kaboodle quora plaxo ideeli hulu weebly balihoo...</div>
													<div class="timeline-footer">
														<a class="btn btn-primary btn-xs">Read more</a> <a
															class="btn btn-danger btn-xs">Delete</a>
													</div>
												</div></li>
											<!-- END timeline item -->
											<!-- timeline item -->
											<li><i class="fa fa-user bg-aqua"></i>
												<div class="timeline-item">
													<span class="time"><i class="fa fa-clock-o"></i> 5
														mins ago</span>
													<h3 class="timeline-header no-border">
														<a href="#">Sarah Young</a> accepted your friend request
													</h3>
												</div></li>
											<!-- END timeline item -->
											<!-- timeline item -->
											<li><i class="fa fa-comments bg-yellow"></i>
												<div class="timeline-item">
													<span class="time"><i class="fa fa-clock-o"></i> 27
														mins ago</span>
													<h3 class="timeline-header">
														<a href="#">Jay White</a> commented on your post
													</h3>
													<div class="timeline-body">Take me to your leader!
														Switzerland is small and neutral! We are more like
														Germany, ambitious and misunderstood!</div>
													<div class="timeline-footer">
														<a class="btn btn-warning btn-flat btn-xs">View
															comment</a>
													</div>
												</div></li>
											<!-- END timeline item -->
											<!-- timeline time label -->
											<li class="time-label"><span class="bg-green"> 3
													Jan. 2014 </span></li>
											<!-- /.timeline-label -->
											<!-- timeline item -->
											<li><i class="fa fa-camera bg-purple"></i>
												<div class="timeline-item">
													<span class="time"><i class="fa fa-clock-o"></i> 2
														days ago</span>
													<h3 class="timeline-header">
														<a href="#">Mina Lee</a> uploaded new photos
													</h3>
													<div class="timeline-body">
														<img src="http://placehold.it/150x100" alt="..."
															class="margin"> <img
															src="http://placehold.it/150x100" alt="..."
															class="margin"> <img
															src="http://placehold.it/150x100" alt="..."
															class="margin"> <img
															src="http://placehold.it/150x100" alt="..."
															class="margin">
													</div>
												</div></li>
											<!-- END timeline item -->
											<li><i class="fa fa-clock-o bg-gray"></i></li>
										</ul>
									</div>
									<!-- /.tab-pane -->

									<div class="tab-pane" id="settings">
										<div class="row">
											<div class="col-md-4">
												<strong><i class="fa fa-map-marker margin-r-5"></i>
													Location</strong>
												<ul class="list-group list-group-unbordered">
													<li class="list-group-item"><b>Followers</b> <a
														class="pull-right">1,322</a></li>
													<li class="list-group-item"><b>Following</b> <a
														class="pull-right">543</a></li>
													<li class="list-group-item"><b>Friends</b> <a
														class="pull-right">13,287</a></li>
												</ul>
											</div>
											<div class="col-md-4">
												<ul class="list-group list-group-unbordered">
													<li class="list-group-item"><b>Followers</b> <a
														class="pull-right">1,322</a></li>
													<li class="list-group-item"><b>Following</b> <a
														class="pull-right">543</a></li>
													<li class="list-group-item"><b>Friends</b> <a
														class="pull-right">13,287</a></li>
												</ul>
											</div>
											<div class="col-md-4">
												<ul class="list-group list-group-unbordered">
													<li class="list-group-item"><b>Followers</b> <a
														class="pull-right">1,322</a></li>
													<li class="list-group-item"><b>Following</b> <a
														class="pull-right">543</a></li>
													<li class="list-group-item"><b>Friends</b> <a
														class="pull-right">13,287</a></li>
												</ul>
											</div>

										</div>
									</div>
									<!-- /.tab-pane -->
								</div>
								<!-- /.tab-content -->
							</div>
					


					</div>
				</div>
			</div>



		</div>
	</section>
</div>

<jsp:include page="${request.contextPath}/footer"></jsp:include>


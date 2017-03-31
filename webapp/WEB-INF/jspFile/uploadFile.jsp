<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>
<script type="text/javascript">
		function saveMedia() {
			$.ajax({
				url : '${pageContext.request.contextPath}/upload/temp/',
				enctype : 'multipart/form-data',
				data :  new FormData(document.getElementById("uploadImage")),
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(data) {
					alert(data.fileNames);
				},
				error : function(err) {
					alert("error");
				}
			});
		}

		$(document).ready(function() {
			$("#submit").click(function(){
				saveMedia();
			});
		});
	</script>
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Account Type</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>Account Type</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->

		<div class="box">
			<div class="box-header with-border">
				<h3 class="box-title">&nbsp;</h3>
				<div class="box-tools pull-right">
					<button class="btn btn-box-tool" data-widget="collapse"
						data-toggle="tooltip" title="Collapse">
						<i class="fa fa-minus"></i>
					</button>
					<button class="btn btn-box-tool" data-widget="remove"
						data-toggle="tooltip" title="Remove">
						<i class="fa fa-times"></i>
					</button>
				</div>
				<div class="col-sm-12">
					<hr style="margin-bottom: 5px; margin-top: 8px;" />
				</div>
			</div>

			<div class="box-body"
				style="background: url(${pageContext.request.contextPath}/resources/images/boxed-bg.jpg);padding:30px;">


				<div class="clearfix"></div>

				<div class="panel panel-default">
					<div class="panel-body">

						<div class="col-sm-4">
							<form class="form-inline">
								<div class="form-group" style="padding-top: 10px;">
									<label>Search :</label> <input type="text" ng-model="search"
										class="form-control" placeholder="Search">
								</div>
							</form>
							<br />
							<div style="background: #fff; margin-top: 15px;">
								<form enctype="multipart/form-data" id="uploadImage" method="POST">
									File to upload: <input type="file" name="file" id="file"> 
									<input type="button" value="Upload" id="submit"> Press here to upload the file!
								</form>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
			<!-- /.box-body -->
			<div class="box-footer"></div>
			<!-- /.box-footer-->
		</div>

		<!-- /.box -->


	</section>
	<!-- /.content -->


</div>

<jsp:include page="${request.contextPath}/footer"></jsp:include>
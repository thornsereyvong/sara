<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<style>


div.panel:first-child {
    margin-top:20px;
}

div.treeviews {
    min-width: 100px;
    min-height: 100px;
    
    max-height: 256px;
    overflow:auto;
	
	padding: 4px;
	
	margin-bottom: 20px;
	
	color: #369;
	
	border: solid 1px;
	border-radius: 4px;
}
div.treeviews ul:first-child:before {
    display: none;
}
.treeviews, .treeviews ul {
    margin:0;
    padding:0;
    list-style:none;
    
	color: #369;
}
.treeviews ul {
    margin-left:1em;
    position:relative
}
.treeviews ul ul {
    margin-left:.5em
}
.treeviews ul:before {
    content:"";
    display:block;
    width:0;
    position:absolute;
    top:0;
    left:0;
    border-left:1px solid;
    
    /* creates a more theme-ready standard for the bootstrap themes */
    bottom:15px;
}
.treeviews li {
    margin:0;
    padding:0 1em;
    line-height:2em;
    font-weight:700;
    position:relative
}
.treeviews ul li:before {
    content:"";
    display:block;
    width:10px;
    height:0;
    border-top:1px solid;
    margin-top:-1px;
    position:absolute;
    top:1em;
    left:0
}
.tree-indicator {
    margin-right:5px;
    
    cursor:pointer;
}
.treeviews li a {
    text-decoration: none;
    color:inherit;
    
    cursor:pointer;
}
.treeviews li button, .treeviews li button:active, .treeviews li button:focus {
    text-decoration: none;
    color:inherit;
    border:none;
    background:transparent;
    margin:0px 0px 0px 0px;
    padding:0px 0px 0px 0px;
    outline: 0;
}

.pd{
	padding: 0;
}
</style>

<script>
$.fn.extend({
	treeview:	function() {
		return this.each(function() {
			// Initialize the top levels;
			var tree = $(this);
			
			tree.addClass('treeview-trees');
			tree.find('li').each(function() {
				var stick = $(this);
			});
			tree.find('li').has("ul").each(function () {
				var branch = $(this); //li with children ul
				
				branch.prepend("<i class='tree-indicator glyphicon glyphicon-chevron-right'></i>");
				branch.addClass('tree-branch');
				branch.on('click', function (e) {
					if (this == e.target) {
						var icon = $(this).children('i:first');
						
						icon.toggleClass("glyphicon-chevron-down glyphicon-chevron-right");
						$(this).children().children().toggle();
					}
				})
				//branch.children().children().toggle();
				
				/**
				 *	The following snippet of code enables the treeview to
				 *	function when a button, indicator or anchor is clicked.
				 *
				 *	It also prevents the default function of an anchor and
				 *	a button from firing.
				 */
				 
				branch.children('.tree-indicator, button, a').click(function(e) {
					branch.click();
					
					e.preventDefault();
				});
			});
		});
	}
});

/**
 *	The following snippet of code automatically converst
 *	any '.treeview' DOM elements into a treeview component.
 */
$(window).on('load', function () {
	$('.treeviews').each(function () {
		var tree = $(this);
		tree.treeview();
	})
})
</script>
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Category</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Category</a></li>
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
				

			</div>

			<div class="box-body">
			
			<div class="col-sm-12">
			
			        	<div class="col-sm-2 pd">
			        		<!-- TREEVIEW CODE -->
				            <ul class="treeviews">
				                <li><a href="#">Marketing</a>
				                	<ul>
				            			<li><a href="#">Campaigns</a>
				            				<ul>
				            					<li><a href="${pageContext.request.contextPath}/campaing-status">Campaign Status</a></li>
				            					<li><a href="${pageContext.request.contextPath}/campaing-type">Campaign Type</a></li>
				            				</ul>
				            			</li>
				            			<li><a href="#">Leads</a>
				            				<ul>
				            					<li><a href="${pageContext.request.contextPath}/lead-status">Lead Status</a></li>
				            				</ul>
				            			</li>
				            			
				            		</ul>
				            	</li>
				            </ul>
				            <!-- TREEVIEW CODE -->
			        	</div>
			        	
			        	<div class="col-sm-2 pd">
			        		<!-- TREEVIEW CODE -->
				            <ul class="treeviews">
				                <li><a href="#">Sales</a>
				                	<ul>
				            			<li><a href="#">Customers</a>
				            				<ul>	            					
				            					<li><a href="${pageContext.request.contextPath}/account-type">Customer Type</a></li>
				            				</ul>
				            			</li>
				            			<li><a href="#">Contacts</a></li>
				            			<li><a href="#">Opportunity</a>
				            				<ul>
				            					<li><a href="${pageContext.request.contextPath}/opportunity-type" >Opportunity Type</a></li>
				            					<li><a href="${pageContext.request.contextPath}/opportunity-stage" >Opportunity Stage</a></li>
				            				</ul>
				            			</li>
				            		</ul>
				            	</li>
				            </ul>
				            <!-- TREEVIEW CODE -->
			        	</div>
			        	
			        	<div class="col-sm-2 pd">
			        		<!-- TREEVIEW CODE -->
				            <ul class="treeviews">
				                <li><a href="#">Activities</a>
				                	<ul>
				            			<li><a href="#">Calls</a>
				            				<ul>	            					
				            					<li><a href="${pageContext.request.contextPath}/call-status">Call Status</a></li>
				            				</ul>
				            			</li>
				            			<li><a href="#">Meetings</a>
				            				<ul>	            					
				            					<li><a href="${pageContext.request.contextPath}/meeting-status">Meeting Status</a></li>
				            				</ul>
				            			</li>
				            			
				            			<li><a href="#">Tasks</a>
				            				<ul>
				            					<li><a href="${pageContext.request.contextPath}/task-status">Task Status</a></li>
				            				</ul>
				            			</li>
				            			<li><a href="#">Notes</a></li>
				            			<li><a href="#">Locations</a></li>
				            		</ul>
				            	</li>
				            </ul>
				            <!-- TREEVIEW CODE -->
			        	</div>
			            
			            <div class="col-sm-2 pd">
			        		<!-- TREEVIEW CODE -->
				            <ul class="treeviews">
				                <li><a href="#">Support</a>
				                	<ul>
				            			<li><a href="#">Cases</a>
				            				<ul>
				            					<li><a href="${pageContext.request.contextPath}/case-status">Case Status</a></li>
				            					<li><a href="${pageContext.request.contextPath}/case-type">Case Type</a></li>
				            					<li><a href="${pageContext.request.contextPath}/case-priority">Case Priority</a></li>	            					
				            				</ul>
				            			</li>
				            			
				            		</ul>
				            	</li>
				            </ul>
				            <!-- TREEVIEW CODE -->
			        	</div>
			        	
			        	 <div class="col-sm-2 pd">
			        		<!-- TREEVIEW CODE -->
				            <ul class="treeviews">
				                <li><a href="#">Other</a>
				                	<ul>
				            			<li><a href="${pageContext.request.contextPath}/industries">Industry</a></li>
				            			<li><a href="${pageContext.request.contextPath}/lead-sources">Lead Source</a></li>
				            		</ul>
				            	</li>
				            </ul>
				            <!-- TREEVIEW CODE -->
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

<!-- /.content-wrapper -->



<!-- /.content-wrapper -->





<jsp:include page="${request.contextPath}/footer"></jsp:include>


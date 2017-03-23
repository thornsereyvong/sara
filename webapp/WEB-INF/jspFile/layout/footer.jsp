
   		<footer class="main-footer">
   			<strong>Copyright &copy; 2017-2018 <a href="http://balancikacambodia.com/">Balancika Cambodia</a>.</strong> All rights reserved.
    	</footer>
   	<div class="control-sidebar-bg"></div>
    </div>
	<script src="${pageContext.request.contextPath}/resources/bootstrap/js/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/sparkline/jquery.sparkline.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/knob/jquery.knob.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/daterangepicker/daterangepicker.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/datepicker/bootstrap-datepicker.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/fastclick/fastclick.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/dist/js/app.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/dist/js/demo.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js.mine/function.mine.js"></script>
    <script type="text/javascript">
  
    
    $(document).ready(function() {
      $('.summernote').summernote({
        height: 400,
        tabsize: 2,
        codemirror: {
          theme: 'monokai'
        }
      });
	
	$("#form_post").click(function(){
		$("#form_edit_news").submit();	
	});
	  
    });

	
  </script>
  <script>
       $(function () {
    	 
    	  $(".select2").select2();
    	  $(".select2-small").select2(); //{ minimumResultsForSearch: Infinity}
    	  $(".select2-small").select2({ minimumResultsForSearch: Infinity}); //{ minimumResultsForSearch: Infinity}  
    	 /*  var $eventSelect = $(".select2-small");    	  
    	  $eventSelect.on("select2:open", function (e) {     		
    		 setTimeout(function(){ $("body").find('.select2-search__field').blur(); }, 1);    		  
   		  }); */
    	  $(".date").datepicker();
      }); 
       
       
       
       String.prototype.trunc = String.prototype.trunc ||  function(n){
           return this.length>n ? this.substr(0,n-1)+'...' : this.toString();
       };
       
 
    </script>
   <script>
	$(document).ready(function() {
		$('.table-responsive').on('show.bs.dropdown', function () {
		     $('.table-responsive').css( "overflow", "inherit" );
		});
	
		$('.table-responsive').on('hide.bs.dropdown', function () {
		     $('.table-responsive').css( "overflow", "auto" );
		}); 
	});
</script>
  </body>
</html>



      <footer class="main-footer">
        <strong>Copyright &copy; 2015-2016 <a href="http://balancikacambodia.com/">Balancika Cambodia</a>.</strong> All rights reserved.
      </footer>

      <!-- Control Sidebar -->
      <!-- /.control-sidebar -->
      <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div><!-- ./wrapper -->
	<script src="${pageContext.request.contextPath}/resources/bootstrap/js/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <!-- Morris.js charts -->
    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script> -->
    <!--<script src="<?=$server?>admin/plugins/morris/morris.min.js"></script>
-->    <!-- Sparkline -->
 	
    <script src="${pageContext.request.contextPath}/resources/plugins/sparkline/jquery.sparkline.min.js"></script>
    <!-- jvectormap -->
    <script src="${pageContext.request.contextPath}/resources/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
    <!-- jQuery Knob Chart -->
    <script src="${pageContext.request.contextPath}/resources/plugins/knob/jquery.knob.js"></script>
    <!-- daterangepicker -->
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/daterangepicker/daterangepicker.js"></script>
    <!-- datepicker -->
    <script src="${pageContext.request.contextPath}/resources/plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- Bootstrap WYSIHTML5 -->
    <script src="${pageContext.request.contextPath}/resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
    <!-- Slimscroll -->
    <script src="${pageContext.request.contextPath}/resources/plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="${pageContext.request.contextPath}/resources/plugins/fastclick/fastclick.min.js"></script>
    <!-- AdminLTE App -->
    <script src="${pageContext.request.contextPath}/resources/dist/js/app.min.js"></script>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
   <!-- <script src="<?=$server?>admin/dist/js/pages/dashboard.js"></script>-->
    <!-- AdminLTE for demo purposes -->
    <script src="${pageContext.request.contextPath}/resources/dist/js/demo.js"></script>
    
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
    	$(".date").datepicker();
    	$('#cam_startDate').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            format: 'DD/MM/YYYY'
        });
    	$('#cam_endDate').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            format: 'DD/MM/YYYY'
        });
      }); 
    </script>
   
  </body>
</html>

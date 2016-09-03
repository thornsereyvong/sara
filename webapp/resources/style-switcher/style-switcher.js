jQuery(document).ready(function($) {

		//SIDE PANEL 
		//--------------------------------------------------------
		style_switcher = $('.style-switcher'),
		panelWidth = style_switcher.outerWidth(true);
			
		$('.style-switcher .trigger').on("click", function(){
			var $this = $(this);
			if ($(".style-switcher.closed").length>0) {
				style_switcher.animate({"left" : "0px"});
				$(".style-switcher.closed").removeClass("closed");
				$(".style-switcher").addClass("opened");
				$(".style-switcher .trigger i").removeClass("fa-cog").addClass("fa-times");
			} else {
				$(".style-switcher.opened").removeClass("opened");
				$(".style-switcher").addClass("closed");
				$(".style-switcher .trigger i").removeClass("fa-times").addClass("fa-cog");
				style_switcher.animate({"left" : '-' + panelWidth});
			}
			return false;
		});
		
		// style change 
		var link = $('link[data-style="styles"]');

		// resume last chosen style
		var sk_stylesheet = localStorage.getItem('sk_stylesheet'),
			sk_layout_mode = localStorage.getItem('sk_layout_mode');

		$(".style-switcher .selected").removeClass("selected");
		if (sk_stylesheet == null) {
			sk_stylesheet = "blue";
			$('.style-switcher .styleChange li[data-style="'+sk_stylesheet+'"]').addClass("selected");
		} else {
			link.attr('href','css/skins/' + sk_stylesheet + '.css');
			$('.style-switcher .styleChange li[data-style="'+sk_stylesheet+'"]').addClass("selected");
			document.getElementById("logo").src="images/logo_" + sk_stylesheet + ".png";
			document.getElementById("logo-footer").src="images/logo_" + sk_stylesheet + "_footer.png";
		};
		
		if (sk_layout_mode == null) {
			sk_layout_mode = "wide";
			$(".page-wrapper").addClass(sk_layout_mode);
		} else {
			if (sk_layout_mode=="boxed") {
				$(".page-wrapper").addClass(sk_layout_mode);
				$(".page-wrapper").removeClass("wide");
				$(".style-switcher select").val(sk_layout_mode);
			} else { 
				$(".page-wrapper").addClass(sk_layout_mode);
				$(".page-wrapper").removeClass("boxed");
				$(".style-switcher select").val(sk_layout_mode);
			};
		};
		//localStorage.clear();
		// switch colors
		$('.style-switcher .styleChange li').on('click',function(){
		var $this = $(this),
			sk_stylesheet = $this.data('style');
		$(".style-switcher .selected").removeClass("selected");
		$this.addClass("selected");
		link.attr('href', 'css/skins/' + sk_stylesheet + '.css');
		document.getElementById("logo").src="images/logo_" + sk_stylesheet + ".png";
		document.getElementById("logo-footer").src="images/logo_" + sk_stylesheet + "_footer.png";		
		localStorage.setItem('sk_stylesheet',sk_stylesheet);
		});

		// switch layout
		$('select[name="layout-mode"]').change(
		function(){
			var sk_layout_mode = $(this).val();
			localStorage.setItem('sk_layout_mode',sk_layout_mode);
			if (sk_layout_mode=="boxed") {
				$(".page-wrapper").addClass(sk_layout_mode);
				$(".page-wrapper").removeClass("wide");
			} else { 
				$(".page-wrapper").addClass(sk_layout_mode);
				$(".page-wrapper").removeClass("boxed");
			};
		});

});    	
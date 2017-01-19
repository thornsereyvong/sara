$(function () {
	
	var data = [],
	series = Math.floor(Math.random() * 6) + 3;

	for (var i = 0; i < series; i++) {
		data[i] = {
			label: "Series" + (i + 1),
			data: Math.floor(Math.random() * 100) + 1
		}
	}
	
	var placeholder = $("#placeholder");
	placeholder.unbind();
	$.plot('#placeholder', data, {
	    series: {
	        pie: {
	            show: true,
	            combine: {
	                color: '#999',
	                threshold: 0.1
	            }
	        }
	    },
	    legend: {
	        show: false
	    }
	});
});

function labelFormatter(label, series) {
    return '<div style="font-size:13px; text-align:center; padding:2px; color: #fff; font-weight: 600;">'
            + label
            + "<br>"
            + Math.round(series.percent) + "%</div>";
  }
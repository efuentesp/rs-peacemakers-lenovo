bulletChart();

function bulletChart() {
	
	var sumCongruencia = $('#sumCongruencia').val();
	var sumEmpatia = $('#sumEmpatia').val();
	var sumAPI = $('#sumAPI').val();
	
	var descriptionCongruencia = "(" + $('#sumCongruencia').val() + " puntos) " + $('#descriptionCongruencia').val();
	var descriptionEmpatia = "(" + $('#sumEmpatia').val() + " puntos) " + $('#descriptionEmpatia').val();
	var descriptionAPI = "(" + $('#sumAPI').val() + " puntos) " + $('#descriptionAPI').val();
	
	var data = [{"title": "Congruencia", "subtitle": descriptionCongruencia, "ranges": [39, 80, 120, 160, 200], "measures": [sumCongruencia, sumCongruencia], "markers":[sumCongruencia]},
	            {"title": "Empatia", "subtitle": descriptionEmpatia, "ranges": [35, 70, 105, 140, 180], "measures": [sumEmpatia, sumEmpatia], "markers":[sumEmpatia]},
	            {"title": "Actitud Positiva Incondicional", "subtitle": descriptionAPI, "ranges": [43, 86, 129, 172, 220], "measures": [sumAPI, sumAPI], "markers":[sumAPI]}];
	
	var margin = {top: 40, right: 10, bottom: 40, left: 10},
    	width = 960 - margin.left - margin.right,
    	height = 100 - margin.top - margin.bottom;

	chart = d3.bullet()
		.width(width)
		.height(height);
	
	bulletChart = d3.select("#bulletchart").selectAll("svg")
			.data(data)
		.enter().append("svg")
    		.attr("class", "bullet")
    		.attr("width", width + margin.left + margin.right)
    		.attr("height", height + margin.top + margin.bottom)
    	.append("g")
    		.attr("transform", "translate(" + margin.left + "," + margin.top + ")")
    	.call(chart);			

	var title = bulletChart.append("g")
		//.style("text-anchor", "end")
		.attr("transform", "translate(0, -25)");
		//.attr("transform", "translate(-6," + height / 2 + ")");
	
	title.append("text")
    	.attr("class", "title")
      	.text(function(d) { return d.title; });

	title.append("text")
	  	.attr("class", "subtitle")
	  	.attr("dy", "1.3em")
	  	.text(function(d) { return d.subtitle; });	

}

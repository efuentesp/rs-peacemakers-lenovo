var colorScheme = 'rbow2';

var data, graph, chart, chartcc, bulletChart, bulletChartcc, path, node, circle, text, nodeToggle = false;

var w = 960,
	h = 500,
	nodeSize=6;

var force = d3.layout.force()
	.size([w, h])
	.linkDistance(100)
	.charge(-300)
	.start();

var svg = d3.select("#graph").append("svg:svg")
    	.attr("width", w)
    	.attr("height", h);

// Per-type markers, as they don't inherit styles.

svg.append("svg:defs").selectAll("marker")
    .data(["classmate_want_yes", "classmate_want_no", "classmate_guess_yes", "classmate_guess_no"])
  .enter().append("svg:marker")
    .attr("id", String)
    .attr("viewBox", "0 -5 10 10")
    .attr("refX", 15)
    .attr("refY", -1.5)
    .attr("markerWidth", 6)
    .attr("markerHeight", 6)
    .attr("orient", "auto")
  .append("svg:path")
    .attr("d", "M0,-5L10,0L0,5")
    .style("fill", "Gray");;

/*
svg.append("svg:defs").selectAll("marker.arrow")
		.data( d3.range(1,Math.ceil(Math.sqrt(maxNodeSize))) )
	.enter().append("svg:marker")
		.attr("id", function(d) { return "arrow-" + d})
		.attr("class", "arrow")
		.attr("viewBox", "0 -5 10 10")
		.attr("refX", function(d) { return 13+d })
		.attr("refY", 0)
		.attr("markerWidth", 5)
		.attr("markerHeight", 5)
		.attr("orient", "auto")
	.append("svg:path")
		.attr("d", "M0,-5L10,0L0,5"); */

d3.select("#graph").classed(colorScheme, true);
//d3.json($('#restURI').val(), graph);
bulletChart();
cuentaconmigoChart();

function bulletChart() {
	
	var data = [{"title": "Titulo", "subtitle": "Subtitulo", "ranges": [30, 100], "measures": [0,0], "markers":[0]}];
	
	var margin = {top: 40, right: 10, bottom: 40, left: 10},
    	width = 280 - margin.left - margin.right,
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
		.attr("transform", "translate(0, -15)");
		//.attr("transform", "translate(-6," + height / 2 + ")");
	
	title.append("text")
    	.attr("class", "title")
      	.text(function(d) { return d.title; });

	title.append("text")
	  	.attr("class", "subtitle")
	  	.attr("dy", "1em")
	  	.text(function(d) { return d.subtitle; });	

}

function cuentaconmigoChart() {
	//console.log("Cuenta Conmigo");
	var sumCongruencia = $('#sumCongruencia').val();
	var sumEmpatia = $('#sumEmpatia').val();
	var sumAPI = $('#sumAPI').val();
	var descriptionCongruencia = $('#descriptionCongruencia').val();
	var descriptionEmpatia = $('#descriptionEmpatia').val();
	var descriptionAPI = $('#descriptionAPI').val();
	
	var descriptionCongruencia = "(" + sumCongruencia + " puntos) " + descriptionCongruencia;
	var descriptionEmpatia = "(" + sumEmpatia + " puntos) " + descriptionEmpatia;
	var descriptionAPI = "(" + sumAPI + " puntos) " + descriptionAPI;
	
	var data = [{"title": "Congruencia", "subtitle": descriptionCongruencia, "ranges": [39, 80, 120, 160, 200], "measures": [sumCongruencia, sumCongruencia], "markers":[sumCongruencia]},
	            {"title": "Empatia", "subtitle": descriptionEmpatia, "ranges": [35, 70, 105, 140, 180], "measures": [sumEmpatia, sumEmpatia], "markers":[sumEmpatia]},
	            {"title": "Actitud Positiva Incondicional", "subtitle": descriptionAPI, "ranges": [43, 86, 129, 172, 220], "measures": [sumAPI, sumAPI], "markers":[sumAPI]}];
	
	var margin = {top: 40, right: 10, bottom: 40, left: 10},
    	width = 280 - margin.left - margin.right,
    	height = 100 - margin.top - margin.bottom;

	chartcc = d3.bullet()
		.width(width)
		.height(height);
	
	bulletChartcc = d3.select("#cuentaconmigo").selectAll("svg")
			.data(data)
		.enter().append("svg")
    		.attr("class", "bullet")
    		.attr("width", width + margin.left + margin.right)
    		.attr("height", height + margin.top + margin.bottom)
    	.append("g")
    		.attr("transform", "translate(" + margin.left + "," + margin.top + ")")
    	.call(chartcc);			

	var title = bulletChartcc.append("g")
		//.style("text-anchor", "end")
		.attr("transform", "translate(0, -25)");
		//.attr("transform", "translate(-6," + height / 2 + ")");
	
	title.append("text")
    	.attr("class", "title")
      	.text(function(d) { return d.title; });

	title.append("text")
	  	.attr("class", "subtitle")
	  	.attr("dy", "1.3em")
	  	.attr("id", function(d, i){ var result = "subtitle_cc_"+i; return result; })
	  	.text(function(d) { return d.subtitle; });	

}

$('input[name="type"]').change(function() {					
	
	var type = $(this).val().split(':');
	//console.log($('#restURI').val() + type[0] + "?type=" + type[1]);

	//console.log("Start...");
	$('#searchStudent').removeAttr('disabled');
	$('#searchButton').removeAttr('disabled');
	$('#bullyingSelect').removeAttr('disabled');
	$("#loading").html('<img width="200" height="200" alt="Espera un momento..." src="/rs-peacemakers/static/images/spinner8.gif">');
	d3.json($('#restURI').val() + type[0] + "?type=" + type[1], graph);

});

$('#bullyingSelect').change(function() {
	var restURI = $('#restURI').val();
	var socialGroup = $('#socialGroup').val();
	var sociometricTestChecked = $('input[name="type"]:checked');
	//console.log(sociometricTestChecked);
	if (sociometricTestChecked.size()>0) {
		var sociometricTestSelected = sociometricTestChecked.val().split(':');
		var bullyingSelected = $('#bullyingSelect').val();
		//console.log(socialGroup);
		//console.log(restURI);
		//console.log(bullyingSelected);
		//console.log(sociometricTestSelected[1]);
		
		$("#loading").html('<img width="200" height="200" alt="Espera un momento..." src="/rs-peacemakers/static/images/spinner8.gif">');
		d3.json(restURI + sociometricTestSelected[0] + "?type=" + sociometricTestSelected[1] + '&bullying=' + bullyingSelected, graph);
	}
});

$('#searchButton').click(function(event) {
	var studentName = $('#searchStudent').val();
	//console.log(studentName);
	
	d3.selectAll("circle.node")
	.filter(function(d) {
		//console.log(d.id.toString());
		if (studentName == d.name) {
			//console.log("found: " + d);
			return true;
		}
		return false;
	})
	.transition()
		.duration(250)
	.attr("r", 18)
	.style("stroke-width", 6)
	.style("stroke", "#398FBD");
});

$('#bullying-chart').click(function(event){
	event.preventDefault();
	d3.select("#bulletchart").classed("hidden", false);
	d3.select("#bullying-chart").attr("xlink:href", "");
	d3.select("#navBullying").classed("active", true);	
	d3.select("#radar-chart").classed("hidden", true);
	d3.select("#navCompetency").classed("active", false);
	d3.select("#bullymetric").classed("hidden", true);
	d3.select("#navBullymetric").classed("active", false);
	d3.select("#cuentaconmigo").classed("hidden", true);
	d3.select("#navCuentaConmigo").classed("active", false);	
});

$('#competency-chart').click(function(event){
	event.preventDefault();
	d3.select("#bulletchart").classed("hidden", true);
	d3.select("#navBullying").classed("active", false);
	d3.select("#radar-chart").classed("hidden", false);
	d3.select("#navCompetency").classed("active", true);
	d3.select("#bullymetric").classed("hidden", true);
	d3.select("#navBullymetric").classed("active", false);
	d3.select("#cuentaconmigo").classed("hidden", true);
	d3.select("#navCuentaConmigo").classed("active", false);	
});

$('#bullymetric-chart').click(function(event){
	event.preventDefault();
	d3.select("#bulletchart").classed("hidden", true);
	d3.select("#navBullying").classed("active", false);
	d3.select("#radar-chart").classed("hidden", true);
	d3.select("#navCompetency").classed("active", false);
	d3.select("#bullymetric").classed("hidden", false);
	d3.select("#navBullymetric").classed("active", true);
	d3.select("#cuentaconmigo").classed("hidden", true);
	d3.select("#navCuentaConmigo").classed("active", false);	
});

$('#cuentaconmigo-chart').click(function(event){
	event.preventDefault();
	d3.select("#bulletchart").classed("hidden", true);
	d3.select("#navBullying").classed("active", false);
	d3.select("#radar-chart").classed("hidden", true);
	d3.select("#navCompetency").classed("active", false);
	d3.select("#bullymetric").classed("hidden", true);
	d3.select("#navBullymetric").classed("active", false);
	d3.select("#cuentaconmigo").classed("hidden", false);
	d3.select("#navCuentaConmigo").classed("active", true);	
});


//Main function
function graph(json) {
	data = json
	
	//console.log("Stop..");
	$("#loading").html('');
	
	function degree(vertexId) {
		var c = 0;
		for (var i in data.links) {
			var edge = data.links[i];
			var vertex = edge.target;
			if (vertex.id == vertexId) {
				c++;
			}
		}
		return c;
	}
	
	function inEdges(nodeId) {
		var edges = [];
		
		for (var i in data.links) {
			var edge = data.links[i];
			//var node = data.nodes[edge.target];
			var node = edge.target;
			//console.log(node);
			if (node.id == nodeId) {
				//console.log(data.nodes[edge.source]);
				//console.log(edge.source);
				edges.push(edge);
			}
		}		

		return edges;
	}
	
	function outEdges(nodeId) {
		var edges = [];
		
		for (var i in data.links) {
			var edge = data.links[i];
			//var node = data.nodes[edge.source];
			var node = edge.source;
			//console.log(node);
			if (node.id == nodeId) {
				//console.log(data.nodes[edge.target]);
				//console.log(edge.target);
				edges.push(edge);
			}
		}		

		return edges;
	}	
	
	force
		.nodes(data.nodes)
		.links(data.links)
		.on("tick", tick)
		.start();
	
	drawPaths();
	drawNodes();
	
	
	function drawPaths() {
		svg.selectAll("path.link").remove();
		
		path = svg.selectAll("path.link")
			.data(force.links());
	
		path.enter().append("svg:path")
			.attr("class", function(d) { return "link " + d.type; });
			//.attr("marker-end", function(d) { return "url(#" + d.type + ")"; });
			//.attr("marker-end", function(d) { return "url(#arrow-" + Math.ceil(Math.sqrt(data.nodes[d.target.index].size)) + ")"; }) 
		
		// Exit any old links.
		path.exit().remove();
	}	
	
	function drawNodes() {
		
		var nodeClick = function(d) {
			
			if (!nodeToggle) {
				//console.log("Mouse over");
				
				// Mute all nodes
				svg.selectAll("circle.node").transition()
					.duration(250)
					.style("stroke-width", 1)
					.style("stroke", "Gray")
					.style("fill", "White");
				
				// Emphasize selected node
				d3.select(this).select("circle.node").transition()
	            	.duration(250)
	            	.style("stroke-width", 6)
	            	.attr("r", 22 );
				
				// Emphasize selected node text
				d3.select(this).select("text").transition()
	            	.duration(250)
	            	.attr("x", 28)
	            	.style("font", "bold 20px Arial")
	            	.attr("fill", "#005580");
				
				// Find all incoming edges (arcs) from selected node
				var edgeSelected = d;
				var edges = inEdges(edgeSelected.id.toString());
				//console.log(edges);
				
				// Convert incoming nodes to array
				var vertexFrom = [];
				for (var i in edges) {
					vertexFrom.push(edges[i].source.id);
				}
				//console.log(vertexFrom);
				
				// Find all outcoming edges (arcs) from selected node
				var outcomingEdges = outEdges(edgeSelected.id.toString());
				//console.log(edges);
				
				// Convert outcoming nodes to array
				var vertexTo = [];
				for (var i in outcomingEdges) {
					vertexTo.push(outcomingEdges[i].target.id);
				}
				//console.log(vertexFrom);			
				
				// Emphazise all incoming nodes to selected node
				d3.selectAll("circle.node")
					.filter(function(d) {
						//console.log(d.id.toString());
						if ($.inArray(d.id, vertexFrom) != -1) {
							//console.log("found: " + d);
							return true;
						}
						return false;
					})
					.transition()
						.duration(250)
					.attr("r", 14)
					.style("stroke-width", 4);
				
				// Emphazise all outcoming nodes from selected node
				d3.selectAll("circle.node")
					.filter(function(d) {
						//console.log(d.id.toString());
						if ($.inArray(d.id, vertexTo) != -1) {
							//console.log("found: " + d);
							return true;
						}
						return false;
					})
					.transition()
						.duration(250)
					.attr("r", 14)
					.style("stroke-width", 4);
				
				if ($('#showNodeNames:checked').length > 0) {
					// Emphazise all incoming nodes text to selected node
					d3.selectAll("text")
						.filter(function(d) {
							if ($.inArray(d.id, vertexFrom) != -1) {
								//console.log(d);
								return true;
							}
							return false;					
						})
						.transition()
							.duration(250)
						.attr("x", 18)
		            	.style("font", "bold 12px Arial")
		            	.attr("fill", "#005580");
					
					// Emphazise all outcoming nodes text to selected node
					d3.selectAll("text")
						.filter(function(d) {
							if ($.inArray(d.id, vertexTo) != -1) {
								//console.log(d);
								return true;
							}
							return false;					
						})
						.transition()
							.duration(250)
						.attr("x", 18)
		            	.style("font", "bold 12px Arial")
		            	.attr("fill", "#005580");					
				}
				
				// Mute all edges
				d3.selectAll("path.link")
					.attr("class", function(d) { return "link mute"; })
					//.attr("marker-end", function(d) { return "url(#" + d.type + ")"; });
				
				// Emphasize incoming edges to selected node
				d3.selectAll("path.link")
					.filter(function(d) {
						//console.log(d);
						if ((edgeSelected.id.toString() == d.target.id) && ($.inArray(d.source.id, vertexFrom) != -1)) {
							//console.log(d);
							return true;
						}
						return false;
					})
					.transition()
						.duration(250)
					.attr("class", function(d) { return "link selected"; });

				// Emphasize incoming edges to selected node
				d3.selectAll("path.link")
					.filter(function(d) {
						//console.log(d);
						if ((edgeSelected.id.toString() == d.source.id) && ($.inArray(d.target.id, vertexTo) != -1)) {
							//console.log(d);
							return true;
						}
						return false;
					})
					.transition()
						.duration(250)
					.attr("class", function(d) { return "link outcoming"; });			
				
				// Shows Group Member name
				d3.select("#tooltip")
					.select("#groupmember_name")
					.text(d.name);
				
				var src = $('#photoURL').val() + d.id;
				
				$('#groupmember_photo').attr("src", src);
				
				d3.select("#tooltip")
					.style("left", (50) + "px")
					.style("top", (200) + "px");
		
				var percentage = 0;
				if (edgeSelected.result.percentage) {
					percentage = edgeSelected.result.percentage;
				}
				d3.select(".title")
					.text(percentage.toFixed(1)+"%");
				d3.select(".subtitle")
					.text(edgeSelected.result.criteriaResponse);
				d3.select(".bullet .measure.s1")
					.style("fill", function(d) { return edgeSelected.result.color; });
				var data = [{"ranges": [30, 100], "measures": [percentage, percentage], "markers":[percentage]}];
				bulletChart.data(data).call(chart.duration(1000));

				//console.log(d.surveyCuentaconmigo);
				
				$('#sumCongruencia').val(d.surveyCuentaconmigo.sumCongruencia);
				$('#descriptionCongruencia').val(d.surveyCuentaconmigo.descriptionCongruencia);
				$('#sumEmpatia').val(d.surveyCuentaconmigo.sumEmpatia);
				$('#descriptionEmpatia').val(d.surveyCuentaconmigo.descriptionEmpatia);
				$('#sumAPI').val(d.surveyCuentaconmigo.sumAPI);
				$('#descriptionAPI').val(d.surveyCuentaconmigo.descriptionAPI);
				var datacc = [{"ranges": [39, 80, 120, 160, 200], "measures": [d.surveyCuentaconmigo.sumCongruencia, d.surveyCuentaconmigo.sumCongruencia], "markers":[d.surveyCuentaconmigo.sumCongruencia]},
				            {"ranges": [35, 70, 105, 140, 180], "measures": [d.surveyCuentaconmigo.sumEmpatia, d.surveyCuentaconmigo.sumEmpatia], "markers":[d.surveyCuentaconmigo.sumEmpatia]},
				            {"ranges": [43, 86, 129, 172, 220], "measures": [d.surveyCuentaconmigo.sumAPI, d.surveyCuentaconmigo.sumAPI], "markers":[d.surveyCuentaconmigo.sumAPI]}];
				d3.select("#subtitle_cc_0")
					.text("("+d.surveyCuentaconmigo.sumCongruencia+" pts) "+d.surveyCuentaconmigo.shortDescriptionCongruencia);
				d3.select("#subtitle_cc_1")
					.text("("+d.surveyCuentaconmigo.sumEmpatia+" pts) "+d.surveyCuentaconmigo.shortDescriptionEmpatia);
				d3.select("#subtitle_cc_2")
					.text("("+d.surveyCuentaconmigo.sumAPI+" pts) "+d.surveyCuentaconmigo.shortDescriptionAPI);				
				bulletChartcc.data(datacc).call(chart.duration(1000));
				
				//console.log(d.surveyBullymetric);
				
				$('#f1').html(d.surveyCompetency.f1.toFixed(1)+"%");
				$('#f2').html(d.surveyCompetency.f2.toFixed(1)+"%");
				$('#f3').html(d.surveyCompetency.f3.toFixed(1)+"%");
				$('#f4').html(d.surveyCompetency.f4.toFixed(1)+"%");
				
				var data = [
					         [
					           {axis: "Factor 1", value: d.surveyCompetency.f1}, 
					           {axis: "Factor 2", value: d.surveyCompetency.f2}, 
					           {axis: "Factor 3", value: d.surveyCompetency.f3},  
					           {axis: "Factor 4", value: d.surveyCompetency.f4}
					         ]
					];

				RadarChart.draw("#radar-chart", data);
				
				$('#neap').html(d.surveyBullymetric.neap.toFixed(1));
				$('#igap').html(d.surveyBullymetric.igap.toFixed(1));
				$('#imap').html(d.surveyBullymetric.imap.toFixed(1));
				
				d3.select("#bulletchart").classed("hidden", false);
				d3.select("#bullying-chart").attr("xlink:href", "");
				d3.select("#navBullying").classed("active", true);	
				d3.select("#radar-chart").classed("hidden", true);
				d3.select("#navCompetency").classed("active", false);
				d3.select("#bullymetric").classed("hidden", true);
				d3.select("#navBullymetric").classed("active", false);	
				d3.select("#cuentaconmigo").classed("hidden", true);
				d3.select("#navCuentaConmigo").classed("active", false);				
				
				d3.select("#tooltip").classed("hidden", false);				

				nodeToggle = true;
			}
			else {
				//console.log("Mouse out...");
				
				svg.selectAll("circle.node").transition()
				.duration(250)
				.style("stroke-width", 3)
				.style("stroke", "Black")
				.style("fill", "White")
				
				d3.selectAll("circle.node").transition()
	            	.duration(250)
					//.attr("r", nodeSize)
	            	.attr("r", function(d) { return nodeSize + (degree(d.id.toString()) * 1.5); })
					.style("fill", "White")
					//.style("stroke", "Black")
					.style("stroke", function(d) { if (d.result) return d.result.color; else return "Black"; })
					.style("stroke-width", 3);	
				
				d3.selectAll(".nodeName").transition()
					.duration(250)
		    		.attr("x", 12)
		    		.attr("y", ".31em")
		    		.style("font", "normal 0px Arial")
		    		.attr("fill", "Gray");
				
				d3.selectAll("path.link")
				.attr("class", function(d) { return "link"; })
				//.attr("marker-end", function(d) { return "url(#" + d.type + ")"; });
				
				d3.select("#tooltip").classed("hidden", true);
				var src = $('#photoURL').val() + 0;
				$('#groupmember_photo').attr("src", src);				

				
				nodeToggle = false;
			}
		}
		
		var nodeMouseOver = function() {
		}
		
		var nodeMouseOut = function() {
		}		
		
		
		svg.selectAll(".node").remove();
		
		node = svg.selectAll(".node")
			.data(force.nodes());
		
		node.enter().append("g")
			.attr("class", "node")
	    	//.on("mouseover", nodeMouseOver)
			.on("click", nodeClick)
	    	//.on("mouseout", nodeMouseOut)
	    	.call(force.drag);
		
		node.append("circle")
			.attr("class", "node")
			//.attr("r", nodeSize)
			.attr("r", function(d) { return nodeSize + (degree(d.id.toString()) * 1.5); })
			.style("fill", "White")
			//.style("stroke", "Black")
			.style("stroke", function(d) { if (d.result) return d.result.color; else return "Black"; })
			.style("stroke-width", 3)
			.append("title") // Add a hint with the Student's name
			.text(function(d){ return d.name; })
			.call(force.drag);
		
		node.append("text")
			.attr("class", "nodeName")
    		.attr("x", 12)
    		.attr("y", ".31em")
    		.style("font", "normal 0px Arial")
    		.attr("fill", "Gray")
    		.text(function(d) { return d.lastName; });
		
		// Exit any old nodes.
		node.exit().remove();	
				
	}
	
	
	// Use elliptical arc path segments to doubly-encode directionality.
	function tick() {
	  path.attr("d", function(d) {
	    var dx = d.target.x - d.source.x,
	        dy = d.target.y - d.source.y,
	        dr = Math.sqrt(dx * dx + dy * dy);
	    return "M" + d.source.x + "," + d.source.y + "A" + dr + "," + dr + " 0 0,1 " + d.target.x + "," + d.target.y;
	  });

	  node.attr("transform", function(d) {
	    return "translate(" + d.x + "," + d.y + ")";
	  });

	  /*
	  text.attr("transform", function(d) {
	    return "translate(" + d.x + "," + d.y + ")";
	  });
	  */

	}

}



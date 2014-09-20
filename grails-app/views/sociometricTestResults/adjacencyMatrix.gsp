<!doctype html>
<html>
	<head>
		<shiro:hasRole name="Administrator">
			<meta name="layout" content="main">
		</shiro:hasRole>
		<shiro:hasRole name="SchoolAdmin">
			<meta name="layout" content="schoolAdmin">
		</shiro:hasRole>
		<title><g:message code="sociometricTestResults.adjacencyMatrix.header" default="Adjacency Matrix" /></title>
		
		<style>
			
			.background {
			  fill: #eee;
			}
			
			line {
			  stroke: #fff;
			}
			
			text.active {
			  fill: red;
			}
			
			svg {
				font: 10px sans-serif;
			}
		
		</style>
	
		<script src="${resource(dir: 'd3', file: 'd3.v2.js')}"></script>
		<script src="${resource(dir: 'd3', file: 'd3-plots.js')}"></script>

	</head>
	
	<body>
	
		<g:hiddenField id= "socialGroup" name="socialGroup" value="${socialGroup.id}" />
		<!--<g:hiddenField id= "sociometricTest" name="sociometricTest" value="${socialGroup.id}" />-->
	
		<!-- Left Panel -->
		<g:render template="leftPanel"/>
		
		<div class="span8">		
			
			<g:render template="submenu"/>
			
			<ul class="nav nav-pills">
				<li class="active">
					<a href="#">1ra Votación</a>
				</li>
				<li>
					<a href="#">2da Votación</a>
				</li>				
			</ul>			

			<br>
			<div id="canvas"></div>
			
			<script type="text/javascript">
				var margin = {top: 100, right: 0, bottom: 10, left: 100},
			    width = 620,
			    height = 620;
			
				var x = d3.scale.ordinal().rangeBands([0, width]),
				    z = d3.scale.linear().domain([0, 4]).clamp(true),
				    c = d3.scale.category10().domain(d3.range(10));
			
				var svg = d3.select("#canvas").append("svg")
				    .attr("width", width + margin.left + margin.right)
				    .attr("height", height + margin.top + margin.bottom)
				    .style("margin-left", margin.left + "px")
				  .append("g")
				    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
			
				d3.json("/PeaceMakerProgram/sociometricTestResults/data/" + $('#socialGroup').val(), draw);
			</script>
		</div>		
	
	</body>
</html>
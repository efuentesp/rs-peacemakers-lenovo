<!doctype html>
<html>
	<head>
		<meta name="layout" content="simple">
		<title><g:message code="surveyAssigned.label" default="Survey Assigned" /></title>
		
		<script src="${resource(dir: 'd3', file: 'd3.v3.js')}"></script>
		<script src="${resource(dir: 'd3', file: 'bullet.js')}"></script>
		
		<link rel="stylesheet" href="${resource(dir: 'fileupload/css', file: 'fileupload.css')}">
		
		<style type="text/css">
			.bullet { font: 12px sans-serif; }
			.bullet .marker { stroke: #000; stroke-width: 2px; }
			.bullet .tick line { stroke: #666; stroke-width: .5px; }
			.bullet .range.s0 { fill: #eee; }
			.bullet .range.s1 { fill: #ddd; }
			.bullet .range.s2 { fill: #ccc; }
			.bullet .range.s3 { fill: #bbb; }
			.bullet .range.s4 { fill: #aaa; }
			.bullet .measure.s0 { fill: lightsteelblue; }
			.bullet .measure.s1 { fill: steelblue; }
			//.bullet .measure.s1 { fill: steelblue; }
			.bullet .title { font-size: 14px; font-weight: bold; }
			.bullet .subtitle { fill: #666; }		
		</style>
		
	</head>
	
	<body>
		
		<!--  Content Panel -->
		<g:hiddenField id= "sumCongruencia" name="sumCongruencia" value="${params.sumCongruencia}" />
		<g:hiddenField id= "sumEmpatia" name="sumEmpatia" value="${params.sumEmpatia}" />
		<g:hiddenField id= "sumAPI" name="sumAPI" value="${params.sumAPI}" />
		<g:hiddenField id= "descriptionCongruencia" name="descriptionCongruencia" value="${params.descriptionCongruencia}" />
		<g:hiddenField id= "descriptionEmpatia" name="descriptionEmpatia" value="${params.descriptionEmpatia}" />
		<g:hiddenField id= "descriptionAPI" name="descriptionAPI" value="${params.descriptionAPI}" />		
		
		<div id="bulletchart"></div>
		
		<div>
			<g:link controller="student" action="main" class="btn btn-primary">
	    		<i class="icon-forward icon-white"></i>
	    		<g:message code="default.button.continue.label" default="Continue"/>
	    	</g:link>
	    </div>
	    
	    <script src="${resource(dir: 'd3/js', file: 'd3-surveyAssigned.js')}"></script>
	
	</body>
</html>

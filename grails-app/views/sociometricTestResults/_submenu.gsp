
<ul class="nav nav-tabs">
	<li <g:if test="${action == 'matrixChart'}"> class="active" </g:if> >
		<a href="${createLink(uri: "/sociometricTestResults/matrixChart/${socialGroup.id}")}"><g:message code="sociometricTestResults.adjacencyMatrix.header" default="Adjacency Matrix" /></a>
	</li>
	<li <g:if test="${action == 'barChart'}"> class="active" </g:if> >
		<a href="${createLink(uri: "/sociometricTestResults/barChart/${socialGroup.id}")}"><g:message code="sociometricTestResults.barChart.header" default="Bar Chart" /></a>
	</li>	
	<li <g:if test="${action == 'jqPlotBarChart'}"> class="active" </g:if> >
		<a href="${createLink(uri: "/sociometricTestResults/jqPlotBarChart/${socialGroup.id}")}"><g:message code="sociometricTestResults.pieChart.header" default="Pie Chart" /></a>
	</li>						
</ul>
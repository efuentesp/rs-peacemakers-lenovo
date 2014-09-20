<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="survey.list.header" default="Surveys" /></title>
	</head>
	
	<body>

		<ul class="breadcrumb">
			<li class="active"><g:message code="survey.list.header" default="Surveys" /></li>
		</ul>		
		
		<!-- Page Header -->
		<div>
			<h1>
				<i class="icon-check"></i> <g:message code="survey.list.header" default="Surveys"/>
			</h1>
		</div> <!-- page-header -->	
		
		<!-- Action Bar -->
		<g:render template="action"/>
		    	
		<!-- Table -->
		<g:render template="table"/>
	
		<!-- Pagination --> 
		<g:render template="pagination"/>	
	
	</body>
</html>
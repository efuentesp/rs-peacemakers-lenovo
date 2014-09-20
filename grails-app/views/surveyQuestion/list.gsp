<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="survey.question.list.header" default="Survey Questions" /></title>
	</head>
	
	<body>
	
		<ul class="breadcrumb">
			<li><a href="${createLink(uri: "/survey/list")}"><g:message code="survey.list.header" default="Surveys" /></a> <span class="divider">/</span></li>
			<li class="active"><g:message code="survey.question.list.header" default="Survey Questions" /></li>
		</ul>	
		
		<!-- Page Header -->
		<div>
			<h1>
				<i class="icon-check"></i> <g:message code="survey.question.list.header" default="Survey Questions"/>
				 <small><strong>${survey.name}</strong></small>
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
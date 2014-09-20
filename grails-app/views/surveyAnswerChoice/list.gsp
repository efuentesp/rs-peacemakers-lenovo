<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="survey.question.answerChoice.list.header" default="Survey Question Answers" /></title>
	</head>
	
	<body>
	
		<ul class="breadcrumb">
			<li><a href="${createLink(uri: "/survey/list")}"><g:message code="survey.list.header" default="Surveys" /></a> <span class="divider">/</span></li>
			<li><a href="${createLink(uri: "/surveyQuestion/list")}/${surveyQuestion?.survey.id}"><g:message code="survey.question.list.header" default="Survey Questions" /></a> <span class="divider">/</span></li>
			<li class="active"><g:message code="survey.question.answerChoice.list.header" default="Survey Question Answers" /></li>
		</ul>	
		
		<!-- Page Header -->
		<div>
			<h1>
				<i class="icon-check"></i> <g:message code="survey.question.answerChoice.list.header" default="Survey Question Answers"/>
				 <small><strong>${surveyQuestion.description}</strong></small>
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
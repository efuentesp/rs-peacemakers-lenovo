<!doctype html>
<html>
	<head>
		<meta name="layout" content="simple">
		<title><g:message code="surveyAssigned.label" default="Survey Assigned" /></title>
		<link rel="stylesheet" href="${resource(dir: 'fileupload/css', file: 'fileupload.css')}">
	</head>
	
	<body>
		
		<!--  Content Panel -->
		<div>
			<!-- Page Header -->
			<div class="page-header">
				<h1>
					<i class="icon-check"></i> <g:message code="surveyAssigned.label" default="Survey Assigned"/> <small>${surveyAssigned?.survey.name}</small>
				</h1>
			</div> <!-- page-header -->
			
			<!-- Instructions -->
			<div class="alert alert-info">
				<h4><g:message code="surveyAssigned.instructions.header" default="Instructions"/></h4>
				<br>
				<g:message code="surveyAssigned.${surveyAssigned.survey.getCode()}.instructions" default="${surveyAssigned.survey.getCode()}"/>
    		</div>			
			
			<div class="well row">
				<div class="span1">
					<img class="photo_small" src="${createLink(controller:'student', action:'renderPhoto', id:groupMember.id)}"/>
				</div>
				<div class="span6">
					<h4>${groupMember.getFullName()}</h4>
					<h4 class="muted"><small><strong>
						${groupMember?.socialGroup?.parent.name}, ${groupMember?.socialGroup?.stage.name} (${groupMember?.socialGroup?.period.name} ${groupMember?.socialGroup.name})
					</strong></small></h4>
				</div>
			</div>
			
			<g:if test="${surveyAssigned}">
				<!-- Table -->
				<div class="row-fluid">
					<g:render template="table"/>
				</div>
			</g:if>
			<g:else>
				<div class="alert alert-error">
					<img src="${resource(dir: 'images/skin', file: 'exclamation.png')}" alt="Error"/>
					<g:message code="sociometricTest.error.text" default="Sociometric Test already answered." />
				</div>
		    	<!-- Finish -->
		    	<g:link controller="logout" class="btn btn-inverse">
		    		<i class="icon-off icon-white"></i>
		    		<g:message code="default.button.finish.label" default="F I N I S H"/>
		    	</g:link>								
			</g:else>
			
			<!-- Action Bar -->
			<!-- <g:render template="action"/> -->
		</div>
	
	</body>
</html>

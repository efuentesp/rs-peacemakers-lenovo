<!doctype html>
<html>
	<head>
		<meta name="layout" content="simple">
		<title><g:message code="sociometricTest.list.header" default="Sociometric Test" /></title>
		<link rel="stylesheet" href="${resource(dir: 'fileupload/css', file: 'fileupload.css')}">
	</head>
	
	<body>
	
		<g:hiddenField id="criteria" name="criteria" value="${sociometricTest.sociometricCriteria.code}" />
		
		<!--  Content Panel -->
		<div>
			<!-- Page Header -->
			<div class="page-header">
				<h1>
					<i class="icon-comment-alt"></i> <g:message code="sociometricTest.list.header" default="Sociometric Test"/> 
					<g:if test="${sociometricTest}">
						<small><g:message code="${sociometricTest.sociometricCriteria.code}" default="${sociometricTest.sociometricCriteria.name}"/></small>
					</g:if>
				</h1>
			</div> <!-- page-header -->
			
			<!-- Instructions -->
			<div class="alert alert-info">
				<h4><g:message code="sociometricTest.instructions.header" default="Instructions"/></h4>
				<br>
				<g:message code="${sociometricTest.sociometricCriteria.code}_instructions" default="${sociometricTest.sociometricCriteria.code}"/>
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
			
			<g:if test="${sociometricTest}">
				<!-- Table -->
				<div class="row-fluid">
					<g:render template="tableSociogram"/>
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

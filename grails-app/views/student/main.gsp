<!doctype html>
<html>
	<head>
		<meta name="layout" content="simple">
		<title><g:message code="sociometricTest.list.header" default="Sociometric Test" /></title>
		<link rel="stylesheet" href="${resource(dir: 'fileupload/css', file: 'fileupload.css')}">
	</head>
	
	<body>
		
		<!--  Content Panel -->
		<div>
			
			<g:if test="${sociometricTest}">
				<ul class="nav nav-pills">
			    	<g:each in="${sociometricTestList}" var="sociometricTestBean">
			    		<li <g:if test="${sociometricTest.id==sociometricTestBean.id}">class="active"</g:if>>
			    			<a>${sociometricTestBean?.sociometricCriteria.name}</a>
			    		</li>
			    	</g:each>
			    </ul>
		    </g:if>
			
			<div class="well row">
				<div class="span1">
					<div class="photo_small">
					<img class="photo_small" src="${createLink(controller:'student', action:'renderPhoto', id:groupMember.id)}" style="z-index:0;position:absolute;"/>
					<img class="photo_small" src="${resource(dir: 'fileupload/img', file: 'cover.gif')}" style="z-index:1;position:absolute;" />
					</div>
				</div>
				<div class="span6">
					<h4>${groupMember.getFullName()}</h4>
					<h4 class="muted"><small><strong>
						${groupMember?.socialGroup?.parent.name}, ${groupMember?.socialGroup?.stage.name} (${groupMember?.socialGroup?.period.name} ${groupMember?.socialGroup.name})
					</strong></small></h4>
				</div>
			</div>
			
		</div>
		
		<!-- Table -->
		<h3><i class="icon-comment-alt"></i> <g:message code="sociometricTest.list.label" default="Sociometric Test Assigned" /></h3>
		<g:render template="tableSociometricTest"/>

		<!-- Table -->
		<h3><i class="icon-check"></i> <g:message code="surveyAssigned.list.label" default="Surveys Assigned" /></h3>
		<g:render template="tableSurvey"/>
		
		<!-- Finish -->
    	<g:link controller="auth" action="signOut" class="btn btn-large btn-inverse">
    		<i class="icon-off icon-white"></i>
    		<g:message code="default.button.finish.label" default="F I N I S H"/>
    	</g:link>	
	
	</body>
</html>

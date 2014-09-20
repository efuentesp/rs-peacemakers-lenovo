<!doctype html>
<html>
	<head>
		<shiro:hasRole name="Administrator">
			<meta name="layout" content="main">
		</shiro:hasRole>
		<shiro:hasRole name="SchoolAdmin">
			<meta name="layout" content="schoolAdmin">
		</shiro:hasRole>
		<title><g:message code="surveyResults.header" default="Surveys" /></title>
	</head>
	
	<body>
	
		<ul class="breadcrumb">
			<shiro:hasRole name="Administrator">
				<li><a href="${createLink(uri: "/socialGroup/schoolList?city=${socialGroup?.parent?.geo.id}&country=${socialGroup?.parent?.geo?.parent.id}")}"><g:message code="socialGroup.school.list.header" default="Schools" /></a> <span class="divider">/</span></li>
				<li><a href="${createLink(uri: "/socialGroup/groupList?school=${socialGroup?.parent.id}&stage=${socialGroup?.stage.id}&period=${socialGroup?.period.id}&city=${socialGroup?.parent?.geo.id}&country=${socialGroup?.parent?.geo?.parent.id}")}"><g:message code="socialGroup.group.list.header" default="Groups" /></a> <span class="divider">/</span></li>
			</shiro:hasRole>
			<shiro:hasRole name="SchoolAdmin">
				<li><a href="${createLink(uri: "/schoolAdmin/groupList?school=${socialGroup?.parent.id}&stage=${socialGroup?.stage.id}&period=${socialGroup?.period.id}&city=${socialGroup?.parent?.geo.id}&country=${socialGroup?.parent?.geo?.parent.id}")}"><g:message code="socialGroup.group.list.header" default="Groups" /></a> <span class="divider">/</span></li>
			</shiro:hasRole>
			<li class="active"><g:message code="default.navbar.results" default="Sociometric Test Results" /></li>
		</ul>
		
		<!-- Page Header -->
		<div>
			<h1>
				<i class="icon-check"></i> <g:message code="surveyResults.header" default="Surveys"/> <small><strong>${socialGroup?.parent.name} (${socialGroup?.stage.name}, ${socialGroup?.period.name} ${socialGroup.name})</strong></small>
			</h1>
		</div> <!-- page-header -->
		
		<g:hiddenField id= "socialGroup" name="socialGroup" value="${socialGroup.id}" />
		
		<div>
			<g:each in="${surveys}" var="survey">
				<g:if test="${survey.surveyAssigned.survey.id == 2}">
					<g:render template="competency" model="['survey': survey]"/>
				</g:if>
				<g:elseif test="${survey.surveyAssigned.survey.id.toInteger() in [4, 5, 6, 7]}">
					<g:render template="bullymetric" model="['survey': survey]"/>
				</g:elseif>
				<g:else>
					<g:render template="defaultGroupMember" model="['survey': survey]"/>
				</g:else>
			</g:each>
			<br>
			
		</div>
		
		<div>
		
		<g:each in="${questions}" var="question">
			<g:if test="${question.surveyAssigned.survey.id.toInteger() in [2, 4, 5, 6, 7]}">
				
			</g:if>
			<g:else>
				<g:render template="defaultQuestions" model="['question': question]"/>
			</g:else>
		</g:each>		

		</div>		
	
	</body>
</html>
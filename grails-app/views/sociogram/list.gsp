<!doctype html>
<html>
	<head>
		<shiro:hasRole name="Administrator">
			<meta name="layout" content="main">
		</shiro:hasRole>
		<shiro:hasRole name="SchoolAdmin">
			<meta name="layout" content="schoolAdmin">
		</shiro:hasRole>
		<title><g:message code="sociometricTestResults.directedGraph.header" default="Sociogram" /></title>
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
			<li class="active"><g:message code="sociometricTestResults.directedGraph.header" default="Sociogram" /></li>
		</ul>
		
		<!-- Page Header -->
		<div>
			<h1>
				<i class="icon-retweet"></i> <g:message code="sociometricTestResults.directedGraph.header" default="Sociogram"/> <small><strong>${socialGroup?.parent.name} (${socialGroup?.stage.name}, ${socialGroup?.period.name} ${socialGroup.name})</strong></small>
			</h1>
		</div> <!-- page-header -->
		
		<g:hiddenField id= "socialGroup" name="socialGroup" value="${socialGroup.id}" />
		
		<div>

			<ul class="nav nav-tabs">
				<g:each var="sociometricTest" in="${sociometricTests}">
				<g:each var="sociometricCriteria" in="${sociometricTest.sociometricCriteria}">
				<li <g:if test="${action == 'directedGraph_classmate_want'}"> class="active" </g:if>>
					<a href="${createLink(uri: "/sociometricTestResults/directedGraph/${sociometricTest.id}")}"><g:message code="${sociometricCriteria.code}" default="${sociometricCriteria.name}" /></a>
				</li>							
				</g:each>
				</g:each>
			</ul>

		</div>		
	
	</body>
</html>
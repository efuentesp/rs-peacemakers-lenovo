<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="surveyAssigned.list.header" default="Activate Survey" /></title>
	</head>
	
	<body>

		<ul class="breadcrumb">
			<li><a href="${createLink(uri: "/socialGroup/schoolList?city=${socialGroup?.parent?.geo.id}&country=${socialGroup?.parent?.geo?.parent.id}")}"><g:message code="socialGroup.school.list.header" default="Schools" /></a> <span class="divider">/</span></li>
			<li><a href="${createLink(uri: "/socialGroup/groupList?school=${socialGroup?.parent.id}&stage=${socialGroup?.stage.id}&period=${socialGroup?.period.id}&city=${socialGroup?.parent?.geo.id}&country=${socialGroup?.parent?.geo?.parent.id}")}"><g:message code="socialGroup.group.list.header" default="Groups" /></a> <span class="divider">/</span></li>
			<li class="active"><g:message code="surveyAssigned.list.header" default="Activate Survey" /></li>
		</ul>	
		
		<!-- Page Header -->
		<div>
			<h1>
				<i class="icon-check"></i> <g:message code="surveyAssigned.list.header" default="Activate Surveys"/> <small><strong>${socialGroup?.parent.name}</strong>  [ ${socialGroup?.stage.name}, ${socialGroup?.period.name} (${socialGroup.name}) ]</small>
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
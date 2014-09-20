<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="socialGroup.group.list.header" default="Groups" /></title>
	</head>
	
	<body>
		
		<ul class="breadcrumb">
			<li><a href="${createLink(uri: "/socialGroup/schoolList?city=${city}&country=${country}")}"><g:message code="socialGroup.school.list.header" default="Schools" /></a> <span class="divider">/</span></li>
			<li class="active"><g:message code="socialGroup.group.list.header" default="Groups" /></li>
		</ul>
		
		<!-- Page Header -->
		<div>
			<h1>
				<i class="icon-book"></i> <g:message code="socialGroup.group.list.header" default="Groups"/> <small><strong>${schoolBean.name}</strong>  [ ${schoolBean?.geo.name}, ${schoolBean?.geo?.parent.name} (${schoolBean?.geo?.parent?.parent.name}) ]</small>
			</h1>
			<br>
		</div> <!-- page-header -->
		
		<div class="row-fluid">
		
			<!-- Left Panel -->
			<g:render template="groupLeftPanel"/>

			<!--  Content Panel -->
			<div class="span9">

					<!-- Action Bar -->
					<g:render template="groupAction"/>
					
					<!-- Table -->
					<g:render template="groupTable"/>
				
					<!-- Pagination --> 
					<g:render template="groupPagination"/>
				
	
			</div> <!-- /span9 -->
			
		</div>
	</body>
</html>

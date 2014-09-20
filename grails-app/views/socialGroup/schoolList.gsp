<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="socialGroup.school.list.header" default="Schools" /></title>
	</head>
	
	<body>
	
		<!--  Breadcrumb -->
		<ul class="breadcrumb">
		    <li class="active"><g:message code="socialGroup.school.list.header" default="Schools" /></li>
	    </ul>
    
		<div class="row-fluid">
			<!-- Left Panel -->
			<g:render template="schoolLeftPanel"/>

			<!--  Content Panel -->
			<div class="span9">
				
				<g:if test="${socialGroupList}">		
						
					<!-- Page Header -->
					<div>
						<h1>
							<i class="icon-bell"></i> <g:message code="socialGroup.school.list.header" default="Schools"/> <g:if test="${city}"><small>${city.name}, ${city?.parent.name} (${city?.parent?.parent.name})</small></g:if>
						</h1>
					</div> <!-- page-header -->
					
					<!-- Action Bar -->
					<g:render template="schoolAction"/>
					
					<!-- Table -->
					<g:render template="schoolTable"/>
				
					<!-- Pagination --> 
					<g:render template="schoolPagination"/>
					
				</g:if>
	
			</div> <!-- /span9 -->
			
		</div>
	</body>
</html>

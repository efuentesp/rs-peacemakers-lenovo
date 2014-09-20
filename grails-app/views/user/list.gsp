<!doctype html>
<html>
	<head>
		<shiro:hasRole name="Administrator">
			<meta name="layout" content="main">
		</shiro:hasRole>
		<shiro:hasRole name="SchoolAdmin">
			<meta name="layout" content="schoolAdmin">
		</shiro:hasRole>
		<shiro:hasRole name="SchoolAssistant">
			<meta name="layout" content="schoolAdmin">
		</shiro:hasRole>
		<title><g:message code="user.list.header" default="Users" /></title> 
	</head>
	
	<body>
	
		<!-- Left Panel -->
		<g:render template="leftPanel"/>
			
		<!--  Content Panel -->
		<div class="span9">

			<!-- Page Header -->
			<div class="page-header">
				<h1>
					<i class="icon-group"></i> <g:message code="user.list.header" default="Users"/>
				</h1>
			</div> <!-- page-header -->
			    	
			<!-- Table -->
			<g:if test="${users}">
				<g:render template="table"/>
			</g:if>
		
			<!-- Pagination --> 
			<g:render template="pagination"/>

		</div> <!-- /span9 -->
	
	</body>
</html>

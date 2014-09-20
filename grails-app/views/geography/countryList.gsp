<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="geography.country.list.header" default="Countries" /></title>
	</head>
	
	<body>
		<!-- Left Panel -->
		<g:render template="leftPanel"/>
		
		<!--  Content Panel -->
		<div class="span9">
			<!-- Page Header -->
			<div class="page-header">
				<h1><g:message code="geography.country.list.header" default="Country"/></h1>
			</div> <!-- page-header -->
			<p></p>
	
			<!-- Action Bar -->
			<g:render template="action"/>
			
			<!-- Table -->
			<g:render template="table"/>
		
			<!-- Pagination --> 
			<g:render template="pagination"/>

		</div> <!-- /span9 -->
	
	</body>
</html>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="geography.subdivision.list.header" default="Subdivisions" /></title>
	</head>
	
	<body>
		<!-- Left Panel -->
		<g:render template="leftPanel"/>
		
		<!-- Content Panel -->
		<div class="span9">
			<!-- Page Header -->
			<div class="page-header">
				<h1><g:message code="geography.subdivision.list.header" default="Subdivisions"/></h1>
			</div> <!-- page-header -->
			<p></p>
			
			<form action="subdivisionList" method="post" class="well form-search" >
				<!-- <label class="control-label" for="country"><g:message code="geography.geoType.country.label" default="Country"/></label> -->
				<g:hiddenField name="countrySelected" value="${countrySelected}" />
				<g:select name="country" from="${countryList}" value="${countrySelected}" optionKey="id" optionValue="name" noSelection='['':"${g.message(code:'geography.city.select.noselection.label', default:'-Choose a Country-')}"]' />
				<button type="submit" class="btn btn-info"><g:message code="default.button.search.label" default="Search"/></button>
			</form>
	
			<g:if test="${countrySelected}">
				<!-- Action Bar -->
				<g:render template="action"/>
				
				<!-- Table -->
				<g:render template="table"/>
			
				<!-- Pagination --> 
				<g:render template="pagination"/>
			</g:if>
			
		</div> <!-- /span9 -->
	
	</body>
</html>

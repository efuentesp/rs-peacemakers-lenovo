<!doctype html>
<html>
	<head>
		<meta name="layout" content="print">
		<title><g:message code="groupMember.password.list.header" default="Group Member Passwords" /></title>
		<link rel="stylesheet" href="${resource(dir: 'fileupload/css', file: 'fileupload.css')}"> 
	</head>
	
	<body>
		
		<!--  Content Panel -->
		<div class="span12">

			<!-- Action Bar -->
			<g:render template="actionUsersToPrint"/>

			<!-- Page Header -->
			<div>
				<h3>
					<!-- <i class="icon-unlock"></i> <g:message code="groupMember.password.list.header" default="Group Member Passwords"/> <br> -->
					<small><strong>${socialGroupSelected?.parent.name} (${socialGroupSelected?.stage.name}, ${socialGroupSelected?.period.name} ${socialGroupSelected.name})</strong></small>
				</h3>
			</div> <!-- page-header -->

			<g:render template="tableUsersToPrint"/>

		</div> <!-- /span9 -->
	
	</body>
</html>

<!doctype html>
<html>
	<head>
		<shiro:hasRole name="Administrator">
			<meta name="layout" content="main">
		</shiro:hasRole>
		<shiro:hasRole name="SchoolAdmin">
			<meta name="layout" content="schoolAdmin">
		</shiro:hasRole>
		<title><g:message code="sociometricTestResults.matrixChart.header" default="Matrix Chart" /></title>
	
		<link rel="stylesheet" href="${resource(dir: 'd3/css', file: 'd3.css')}"> 
	
		<script src="${resource(dir: 'd3', file: 'd3.v2.js')}"></script>

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
				<i class="icon-th"></i> <g:message code="sociometricTestResults.adjacencyMatrix.header" default="Adjacency Matrix"/> <small><strong>${socialGroup?.parent.name} (${socialGroup?.stage.name}, ${socialGroup?.period.name} ${socialGroup.name})</strong></small>
			</h1>
		</div> <!-- page-header -->
		
		<g:hiddenField id= "socialGroup" name="socialGroup" value="${socialGroup.id}" />
		<g:hiddenField id= "restURI" name="restURI" value="${restURI}" />
		
		<div>
		
			<g:render template="submenu"/>
    		
			<!--  
			<div class="controls">
				<fieldset id="type">
					<input id="type_0" type="radio" checked="checked" value="0" name="type">
					<label class="sel" for="type_0">
						<span class="test1">Test 1</span>
					</label>
					<input id="type_1" type="radio" value="1" name="type">
					<label class="" for="type_1">
						<span class="test2">Test 2</span>
					</label>
				</fieldset>
			</div>
			-->
			
			<div class="controls">
				<fieldset id="type">
					<g:each var="sociometricTest" status="i" in="${sociometricTests}">
						<input id="type_${i}" type="radio" <g:if test="${i==0}">checked="checked"</g:if> value="${i}" name="type">
						<label <g:if test="${i==0}">class="sel"</g:if> for="type_${i}">
							<span><g:message code="sociometricTest.list.header" default="Test" /> ${i+1}</span>
						</label>
					</g:each>
				</fieldset>
			</div>		
			
			<div id="loading"></div>
			<div id="matrix"></div>
			
			<script src="${resource(dir: 'd3/js', file: 'd3-matrix.js')}"></script>

		</div>		
	
	</body>
</html>
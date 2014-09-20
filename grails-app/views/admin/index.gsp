<!doctype html>
<html lang="es">
	<head>
		<meta name="layout" content="simple"/>
		<title><g:message code="default.brand.name" default="The Peacemaker Program 2.0"/></title>
	</head>
	<body>
	
		<g:hiddenField id= "restURI" name="restURI" value="${restURI}" />
	
		<div id="start" class="">
			<h1>
				<img src="${resource(dir: 'images', file: 'logo_program.png')}" alt="The Peacemaker Program" width="200" height="200"/>
				<g:message code="default.brand.name" default="The Peacemaker Program 2.0"/>
			</h1>
		</div>
	
		<div class="row">

			<div class="span4">
				<div class="well">
					<div class="equalheight" style="height: 125px;">
						<h3>
							<i class="icon-cog"></i>
							<g:message code="home.admin.label" default="System Administrator"/>
						</h3>
						<p>
							<g:message code="home.admin.text" default="System Administrator access only."/>
							<br>
						</p>
						<br>
					</div>
					<p style="text-align: center;">
						<a class="scroll btn btn-primary btn-large" href="${createLink(uri: "/socialGroup")}"><g:message code="home.button.label" default="Login"/></a>
					</p>
				</div>
			</div>

			<!-- 
			<div class="span4">
				<div class="well">
					<div class="equalheight" style="height: 125px;">
						<h3>
							<i class="icon-bell"></i>
							<g:message code="home.school.admin.label" default="School Administrator"/>
						</h3>
						<p>
							<g:message code="home.school.admin.text" default="School Administrator access only."/>
							<br>
						</p>
						<br>
					</div>
					<p style="text-align: center;">
						<a class="scroll btn btn-primary btn-large" href="${createLink(uri: "/school")}"><g:message code="home.button.label" default="Login"/></a>
					</p>
				</div>
			</div>
			<div class="span4">
				<div class="well">
					<div class="equalheight" style="height: 125px;">
						<h3>
							<i class="icon-star"></i>
							<g:message code="home.student.label" default="Student"/>
						</h3>
						<p>
							<g:message code="home.student.text" default="Student access only."/>
							<br>
						</p>
						<br>
					</div>
					<p style="text-align: center;">
						<a class="scroll btn btn-primary btn-large" href="${createLink(uri: "/student")}"><g:message code="home.button.label" default="Login"/></a>
					</p>
				</div>
				
			</div>
			-->					
		</div>

	</body>
</html>

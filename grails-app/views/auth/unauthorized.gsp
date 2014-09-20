<head>
	<shiro:hasRole name="Administrator">
		<meta name="layout" content="main">
	</shiro:hasRole>
	<shiro:hasRole name="SchoolAdmin">
		<meta name="layout" content="schoolAdmin">
	</shiro:hasRole>
	<shiro:hasRole name="Student">
		<meta name="layout" content="simple">
	</shiro:hasRole>
	<title><g:message code="springSecurity.denied.title" /></title>
</head>

<body>
	<div class='body'>
		<div class='errors'><g:message code="shiroSecurity.denied.message" default="You do not have permission to access this page." /></div>
		<br>
		<shiro:hasRole name="Student">
	    	<g:link controller="auth" action="signOut" class="btn btn-large btn-inverse">
	    		<i class="icon-off icon-white"></i>
				<g:message code="default.navbar.logout" default="Logout"/>
	    	</g:link>
		</shiro:hasRole>
	</div>
</body>
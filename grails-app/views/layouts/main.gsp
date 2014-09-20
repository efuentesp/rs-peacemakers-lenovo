<!doctype html>
<html lang="es">
	<head>
		<meta charset="utf-8">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="initial-scale = 1.0">
		<meta name="description" content="">
		<meta name="author" content="">
		
		<!-- Le styles -->
		<link rel="stylesheet" href="${resource(dir: 'bootstrap/css', file: 'bootstrap.css')}">
		<link rel="stylesheet" href="${resource(dir: 'font-awesome/css', file: 'font-awesome.css')}">
		<style>
			body {
				padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
			}
    	</style>
 
		
		<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
	    <!--[if lt IE 9]>
	      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	    <![endif]-->

		<!-- Le fav and touch icons -->
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		
		<g:javascript library='jquery' />

		<g:layoutHead/>
		<r:require module="export"/>
        <r:layoutResources />
	</head>
	
	<body>
	
		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="navbar-inner">
				<div class="container-fluid">
				
					<!-- .btn-navbar is used as the toggle for collapsed navbar content -->
					<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</a> <!-- /btn-navbar -->

					<!-- Brand name -->
				    <a class="brand" href="#">
				    	<img src="${resource(dir: 'images', file: 'logo_small.png')}" alt="The Peacemaker Program" width="23" height="23"/>
				    	<g:message code="default.brand.name" default="The Peacemaker Program 2.0"/>
				    </a> <!-- /brand -->

				    <div class="nav-collapse">
				    	<!-- Home -->
				    	<!-- 
					    <ul class="nav">
						    <li class="active">
							    <a href="${createLink(uri: '/')}">
							    	<i class="icon-home icon-white"></i>
							    	<g:message code="default.navbar.home" default="Home"/>
							    </a>
						    </li>
						</ul>--> <!-- /nav -->

						<!-- Social Groups (Schools) -->
						<ul class="nav">
						    <li class="dropdown">
						    	<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						    		<i class="icon-bell icon-white"></i>
						    		<g:message code="default.navbar.setup.socialGroup.schools" default="Schools"/>
						    		<b class="caret"></b>
						    	</a>
						    	<ul class="dropdown-menu">
						    		<!-- List Schools -->
						    		<li>
						    			<a href="${createLink(uri: '/socialGroup')}">
						    				<i class="icon-search"></i>
						    				<g:message code="default.button.search.label" default="Search"/>
						    			</a>
						    		</li>						    							    		
						    		<!-- List Schools -->
						    		<li>
						    			<a href="${createLink(uri: '/socialGroup/schoolCreate')}">
						    				<i class="icon-plus"></i>
						    				<g:message code="default.button.create.label" default="Add"/>
						    			</a>
						    		</li>	
						    	</ul>					    	
						    </li>
						</ul> <!-- /nav -->

						<!-- 
					    <ul class="nav">
						    <li <g:if test="${controller} == 'socialGroup'">class="active"</g:if> >
				    			<a href="${createLink(uri: '/socialGroup')}">
				    				<i class="icon-bell"></i>
				    				<g:message code="default.navbar.setup.socialGroup.schools" default="Schools"/>
				    			</a>				    			
						    </li>
						</ul>--> <!-- /nav -->
						
						<!-- Setup -->
						<ul class="nav">
						    <li class="dropdown">
						    	<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						    		<i class="icon-cog icon-white"></i>
						    		<g:message code="default.navbar.setup" default="Setup"/>
						    		<b class="caret"></b>
						    	</a>
						    	<ul class="dropdown-menu">
						    		<!-- Geographies -->
						    		<li>
						    			<a href="${createLink(uri: '/geography')}">
						    				<i class="icon-globe"></i>
						    				<g:message code="default.navbar.setup.geography" default="Geography"/>
						    			</a>
						    		</li>

						    		<!-- Surveys -->
						    		<li>
						    			<a href="${createLink(uri: '/survey')}">
						    				<i class="icon-check"></i>
						    				<g:message code="default.navbar.setup.survey" default="Survey"/>
						    			</a>
						    		</li>						    		
						    	
						    		<!-- Users -->
						    		<li>
						    			<a href="${createLink(uri: '/user')}">
						    				<i class="icon-user"></i>
						    				<g:message code="default.navbar.setup.user" default="Users"/>
						    			</a>
						    		</li>
						    							    		
						    	</ul>
						    </li>
						</ul> <!-- /nav -->
						
						<ul class="nav pull-right">
							<li>
								<!-- User -->
								<g:if test="${user}">
							    	<a href="#">
							    		<i class="icon-user icon-white"></i>
							    		${user.username}
							    	</a>
						    	</g:if>
						    </li>
						    <li>
						    	<!-- Logout -->
						    	<g:link controller="Auth" action="signOutAdmin">
						    		<i class="icon-off icon-white"></i>
						    		<g:message code="default.navbar.logout" default="Logout"/>
						    	</g:link>
						    </li>
						</ul> <!-- /nav pull-right-->
					</div> <!-- /nav-collapse -->
					
				</div> <!-- /container-fluid -->
			</div> <!-- /navbar-inner -->
		</nav> <!-- /navbar-fixed-top -->
		
		<div class="container-fluid">
			<div class="row-fluid">
				<g:layoutBody/>
			</div> <!--  /row-fluid -->
					
			<hr>
			<span class="muted">
				<footer class="footer">
					<p>&copy; Copyright 2013 Peacemakers. All rights reserved.</p>
				</footer>
			</span>
			
		</div> <!-- /container-fluid -->

		<div id="spinner" class="spinner" style="display:none;">
			<g:message code="spinner.alt" default="Loading&hellip;"/>
		</div>
		
		<!-- Le javascript
    	================================================== -->
    	<!-- Placed at the end of the document so the pages load faster -->
		<g:javascript library="application"/>
		<script src="${resource(dir: 'bootstrap/js', file: 'bootstrap.js')}"></script>
		<script src="${resource(dir: 'js', file: 'validation.js')}"></script>
        <r:layoutResources />
       
	</body>
</html>
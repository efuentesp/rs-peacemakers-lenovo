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

				    <a class="brand" href="#">
				    	<img src="${resource(dir: 'images', file: 'logo_small.png')}" alt="The Peacemaker Program" width="25" height="25"/>
				    	<g:message code="default.brand.name" default="The Peacemaker Program 2.0"/>
				    </a> <!-- /brand -->
					
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
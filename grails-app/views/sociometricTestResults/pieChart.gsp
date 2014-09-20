<!doctype html>
<html>
	<head>
		<shiro:hasRole name="Administrator">
			<meta name="layout" content="main">
		</shiro:hasRole>
		<shiro:hasRole name="SchoolAdmin">
			<meta name="layout" content="schoolAdmin">
		</shiro:hasRole>
		<title><g:message code="sociometricTestResults.pieChart.header" default="Bar Chart" /></title>

		<link rel="stylesheet" href="${resource(dir: 'd3/css', file: 'd3.css')}">
	
		<script src="${resource(dir: 'd3', file: 'd3.v2.js')}"></script>

	</head>
	
	<body>
	
		<ul class="breadcrumb">
			<li><a href="${createLink(uri: "/socialGroup/schoolList?city=${socialGroup?.parent?.geo.id}&country=${socialGroup?.parent?.geo?.parent.id}")}"><g:message code="socialGroup.school.list.header" default="Schools" /></a> <span class="divider">/</span></li>
			<li><a href="${createLink(uri: "/socialGroup/groupList?school=${socialGroup?.parent.id}&stage=${socialGroup?.stage.id}&period=${socialGroup?.period.id}&city=${socialGroup?.parent?.geo.id}&country=${socialGroup?.parent?.geo?.parent.id}")}"><g:message code="socialGroup.group.list.header" default="Groups" /></a> <span class="divider">/</span></li>
			<li class="active"><g:message code="default.navbar.results" default="Sociometric Test Results" /></li>
		</ul>
		
		<!-- Page Header -->
		<div>
			<h1>
				<i class="icon-th"></i> <g:message code="sociometricTestResults.pieChart.header" default="Pie Chart"/> <small><strong>${socialGroup?.parent.name} (${socialGroup?.stage.name}, ${socialGroup?.period.name} ${socialGroup.name})</strong></small>
			</h1>
		</div> <!-- page-header -->		
	
		<g:hiddenField id= "socialGroup" name="socialGroup" value="${socialGroup.id}" />
		
		<span id="tile_yellow" class="tile_yellow"></span>
		<span id="tile_blue" class="tile_blue"></span>
		<span id="tile_orange" class="tile_orange"></span>
		<span id="tile_red" class="tile_red"></span>
		<span id="tile_default" class="tile_default"></span>
		
		<div>		
			
			<g:render template="submenu"/>			

			<div id="pie"></div>
			
			<div class="span3 rbow2">
				<ul>
					<li>
						<span class="tile_yellow">&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<span><strong>82%</strong></span>
						<span>Computer</span>
					</li>
					<li>
						<span class="tile_blue">&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<span>18%</span>
						<span>Mobile</span>
					</li>
					<li>
						<span class="tile_orange">&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<span>18%</span>
						<span>Mobile</span>
					</li>
					<li>
						<span class="tile_red">&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<span>18%</span>
						<span>Mobile</span>
					</li>
				</ul>
			</div>	
			
			<div class="span3 rbow2">
				<ul>
					<li>
						<span class="tile_yellow">&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<span>82%</span>
						<span>Computer</span>
					</li>
					<li>
						<span class="tile_blue">&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<span>18%</span>
						<span>Mobile</span>
					</li>
					<li>
						<span class="tile_orange">&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<span>18%</span>
						<span>Mobile</span>
					</li>
					<li>
						<span class="tile_red">&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<span>18%</span>
						<span>Mobile</span>
					</li>
				</ul>
			</div>			
			
			<script src="${resource(dir: 'd3/js', file: 'd3-pie.js')}"></script>
		</div>		
	
	</body>
</html>
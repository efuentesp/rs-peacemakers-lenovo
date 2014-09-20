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
		
		<link rel="stylesheet" href="${resource(dir: 'jqplot/css', file: 'jquery.jqplot.min.css')}">
		<link rel="stylesheet" href="${resource(dir: 'fuelux/css', file: 'fuelux.css')}">
		
		<style type="text/css">
			.sociometricCriteria .jqplot-point-label {
				//border: 1.5px solid #aaaaaa;
				//padding: 1px 3px;
				//background-color: #eeccdd;
				color: white;
				font-size: 12px; 
			}
		</style>	
	
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
				<i class="icon-th"></i> <g:message code="sociometricTestResults.pieChart.header" default="Pie Chart"/> <small><strong>${socialGroup?.parent.name} (${socialGroup?.stage.name}, ${socialGroup?.period.name} ${socialGroup.name})</strong></small>
			</h1>
		</div> <!-- page-header -->		
			
		<div>					
			<g:render template="submenu"/>				

			<fieldset>
				<g:form action="jqPlotBarChart" method="post" class="form-inline">
		
					<g:hiddenField id= "socialGroupId" name="socialGroupId" value="${socialGroup.id}" />
					<g:hiddenField id= "id" name="id" value="${socialGroup.id}" />
					<g:hiddenField id= "restURI" name="restURI" value="${restURI}" />
					
					<!-- <input type="text" name="maxPercentage" value="30" maxlength="3" required id="maxPercentage" class="input-mini spinner-input" > -->
					
					<div class="fuelux">
					    <div id="ex-spinner" class="spinner">
					    	<div class="input-append">
						    	<input type="text"  id="maxPercentage"  name="maxPercentage" value="${params.maxPercentage}" required class="input-mini spinner-input numbersOnly" maxlength="3" autocomplete='off'>
						    	<span class="add-on">%</span>
						    </div>
						   	<!-- 
						    <div class="spinner-buttons btn-group btn-group-vertical">
							    <button class="btn spinner-up">
							    <i class="icon-chevron-up"></i>
							    </button>
							    <button class="btn spinner-down">
							    <i class="icon-chevron-down"></i>
							    </button>
						    </div>
						    -->
					    </div>
						<button type="submit" class="btn btn-small btn-success">
							<i class="icon-refresh icon-white"></i>
							<g:message code="sociometricTestResults.button.update.label" default="Update Results"/>
						</button>	
				    </div>
		    				
	
				</g:form>
			</fieldset>
			
			<div id="loading"></div>
			
			<g:each in="${sociometricCriterias}" var="sociometricCriteria">
				<div id="${sociometricCriteria.code}" class="sociometricCriteria" data-id="${sociometricCriteria.id}" style="width:600px; height:250px;"></div>
				<br><br>
			</g:each>				
			
			<script type="text/javascript">

				$(document).ready(function(){

				    // Can specify a custom tick Array.
				    // Ticks should match up one for each y value (category) in the series.
				    //var ticks = ['1ra Votación', '2da Votación', '3ra Votación'];

				    var socialGroupId = $('#socialGroupId').attr('value');
				    var maxPercentage = $('#maxPercentage').attr('value');
				    
				    $('.sociometricCriteria').each(function(i) {
					    var sociometricCriteriaCd = $(this).attr('id');
					    var sociometricCriteriaId = $(this).data('id');
					    //console.log(sociometricCriteriaId);
					    console.log(document.URL);
					    console.log(window.location.host);
				    
					    $.ajax({
						  beforeSend: function() {
								console.log("Start...");
								$("#loading").html('<img width="200" height="200" alt="Wait a second..." src="/rs-peacemakers/static/images/spinner8.gif">');
						  },
						  complete: function() {
								console.log("Stop..");
								$("#loading").html('');
						  },
					      async: false,
					      //url: "/cf-peacemakers/sociometricTestResults/piejson", //Desarrollo
					      //url: "/sociometricTestResults/piejson", //Producción
					      url: $('#restURI').val(),
					      data: { criteria: sociometricCriteriaId, group: socialGroupId, maxPercentage: maxPercentage },
					      dataType:"json",
					      success: function(data) {
					    		
							    var plot1 = $.jqplot(sociometricCriteriaCd, data.data, {
							    	title: data.title,
							        // The "seriesDefaults" option is an options object that will
							        // be applied to all series in the chart.
							        seriesDefaults:{
							            renderer:$.jqplot.BarRenderer,
							            rendererOptions: { fillToZero: true },
							            //pointLabels: { show: true, location: 's', edgeTolerance: -50 }
							            pointLabels: { show: true, location: 's' }
							        },
							        // Custom labels for the series are specified with the "label"
							        // option on the series option.  Here a series option object
							        // is specified for each series.
							        series: data.series,
							        // Show the legend and put it outside the grid, but inside the
							        // plot container, shrinking the grid to accomodate the legend.
							        // A value of "outside" would not shrink the grid and allow
							        // the legend to overflow the container.
							        legend: {
							            show: true,
							            placement: 'outsideGrid'
							        },
							        highlighter: {
							            show: true,
							            sizeAdjust: 7.5
							        },
							        axes: {
							            // Use a category axis on the x axis and use our custom ticks.
							            xaxis: {
							                renderer: $.jqplot.CategoryAxisRenderer,
							                ticks: data.ticks
							            },
							            // Pad the y axis just a little so bars can get close to, but
							            // not touch, the grid boundaries.  1.2 is the default padding.
							            yaxis: {
								            min: 0,
								            //max: data.size,
							                pad: 1.05,
							                tickOptions: {formatString: '%d'}
							            }
							        }
							    });
					    	  
					      }
					    }); // ajax

					}); // each sociometricCriteria
				     
				}); // document
			</script>
			
		</div>		
	
		<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="excanvas.js"></script><![endif]-->
		<script src="${resource(dir: 'jqplot/js', file: 'jquery.jqplot.min.js')}"></script>
		<script src="${resource(dir: 'jqplot/js/plugins', file: 'jqplot.barRenderer.min.js')}"></script>
		<script src="${resource(dir: 'jqplot/js/plugins', file: 'jqplot.categoryAxisRenderer.min.js')}"></script>
		<script src="${resource(dir: 'jqplot/js/plugins', file: 'jqplot.pointLabels.min.js')}"></script>
		<script src="${resource(dir: 'jqplot/js/plugins', file: 'jqplot.json2.min.js')}"></script>
	
	</body>
</html>
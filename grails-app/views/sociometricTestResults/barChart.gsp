<!doctype html>
<html>
	<head>
		<shiro:hasRole name="Administrator">
			<meta name="layout" content="main">
		</shiro:hasRole>
		<shiro:hasRole name="SchoolAdmin">
			<meta name="layout" content="schoolAdmin">
		</shiro:hasRole>
		<title><g:message code="sociometricTestResults.barChart.header" default="Bar Chart" /></title>
		
		<link rel="stylesheet" href="${resource(dir: 'fileupload/css', file: 'fileupload.css')}">
		<link rel="stylesheet" href="${resource(dir: 'd3/css', file: 'd3.css')}">
		<link rel="stylesheet" href="${resource(dir: 'fuelux/css', file: 'fuelux.css')}">
		
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
				<i class="icon-th"></i> <g:message code="sociometricTestResults.barChart.header" default="Bar Chart"/> <small><strong>${socialGroup?.parent.name} (${socialGroup?.stage.name}, ${socialGroup?.period.name} ${socialGroup.name})</strong></small>
			</h1>
		</div> <!-- page-header -->		
		
		<div>		
			
			<g:render template="submenu"/>
	
			<fieldset>
				<g:form action="barChart" method="post" class="form-inline">
		
					<g:hiddenField id= "socialGroup" name="socialGroup" value="${socialGroup.id}" />
					<g:hiddenField id= "id" name="id" value="${socialGroup.id}" />
					
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
				
			<g:each in="${sociometricTestResults}" var="criteria">
				<div>
					<h3>Tipo de Votación: ${criteria.criteria.name}</h3>
					<g:each in="${criteria.tests}" var="test">
						<div>
							<div id="cardlist">
								<h4>Votación ${test.test.sequence}</h4>
								<ul id="grid">
								
									<g:each in="${test.criteriaResponses}" var="criteriaResponse">
										<!-- <h4>${criteriaResponse.criteriaResponse.question}</h4> -->
										<g:each in="${criteriaResponse.testResult}" var="member">
											
											<g:if test="${member.results.size() > 0}">
												<li class="card">
													<div class="cell">
														<div>
															<img  class="image-photo" src="${createLink(controller: 'GroupMember', action: 'renderPhoto', id: member.groupMember.id)}"/>
														</div>
														<div>
															<h5>${member.groupMember}</h5>
														</div>
														<div>
															<ul>
																<g:each in="${member.results}" var="result">
																	<li>
																		<label>
																			<g:message code="${result.criteriaResponse.question}" default="${result.criteriaResponse.question}"/>
																		</label>
																		<tb:progressBar value="${result.percentage}" color="${result.criteriaResponse.rgbHex}"></tb:progressBar>
																		<br>									
																	</li>
																	<ul>
																		<g:each in="${result.responseOptions}" var="option">
																			<li>
																			<label>
																				${option.question}
																			</label>
																			<tb:progressBar value="${option.percentage}" color="${result.criteriaResponse.rgbHex}"></tb:progressBar>
																			<br>																			
																			</li>
																		</g:each>
																	</ul>
																</g:each>
															</ul>
															<br>
														</div>
													</div>
												</li>
											</g:if>
											
										</g:each>
									</g:each>
								
									
								</ul>
							</div>
						</div>
					</g:each>
				</div>
			</g:each>
				
		</div>

		<script src="${resource(dir: 'highcharts', file: 'highcharts.js')}"></script>
		
	</body>
</html>
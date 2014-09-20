<!doctype html>
<html>
	<head>
		<meta name="layout" content="schoolAdmin">
		<title><g:message code="socialGroup.group.edit.header" default="Edit Group" /></title>
	</head>
	
	<body>
	
		<ul class="breadcrumb">
			<li><a href="${createLink(uri: "/schoolAdmin/groupList?school=${schoolBean.id}")}"><g:message code="socialGroup.group.list.header" default="Groups" /></a> <span class="divider">/</span></li>
			<li class="active"><g:message code="socialGroup.group.edit.header" default="Edit Group" /></li>
		</ul>
		
		<!-- Page Header -->
		<div>
			<h1>
				<i class="icon-book"></i> <g:message code="socialGroup.group.edit.header" default="Edit Group"/> <small><strong>${schoolBean.name}</strong>  [ ${schoolBean?.geo.name}, ${schoolBean?.geo?.parent.name} (${schoolBean?.geo?.parent?.parent.name}) ]</small>
			</h1>
			<br>
		</div> <!-- page-header -->		
		
		<div class="row-fluid">
			<!-- Left Panel -->
			<g:render template="groupLeftPanel"/>
			
			<!--  Content Panel -->
			<div class="span9">
		
				<!-- Error Panel -->
				<g:if test="${flash.message}">
					<div class="alert alert-block alert-error">
						<a class="close" data-dismiss="alert">&times;</a>
						${flash.message}
					</div>
				</g:if>
	
				<!-- 
				<g:hasErrors bean="${groupBean}">
					<div class="alert alert-block alert-error">
						<a class="close" data-dismiss="alert">&times;</a>
						<ul>
							<g:eachError bean="${groupBean}" var="error">
							<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
								<g:message error="${error}"/>
							</li>
							</g:eachError>
						</ul>
					</div>
				</g:hasErrors> -->
				
				<!-- Form -->
				<fieldset>
					<g:form action="groupUpdate" method="post" class="form-horizontal">
	
							<g:hiddenField name="school" value="${school}" />
							<g:hiddenField name="groupId" value="${groupBean.id}" />
							<g:hiddenField name="city" value="${city}" />
							<g:hiddenField name="country" value="${country}" />
							<g:hiddenField name="id" value="${groupBean?.id}" />
							<g:hiddenField name="version" value="${groupBean?.version}" />							
	
							<tb:controlGroup name="stage"
											bean="groupBean"
											labelMessage="${g.message(code:"socialGroup.groupType.stage.label", default:"Stage")}"
											error="${hasErrors(bean:groupBean, field:'name', 'error')}"
											errors="${g.renderErrors(bean:groupBean, field:'name', as:'list')}">
								<!--<g:field type="text" name="stage" id="stage" class="input-medium" required="" value=""/>-->
								<input 	type="text" class="input-medium"
										name="stage" required="" value="${groupBean?.stage.name}" autocomplete='off'
										data-provide="typeahead" data-items="4"
										data-source='${stageJSON}'>							
							</tb:controlGroup>							

							<tb:controlGroup name="period"
											bean="groupBean"
											labelMessage="${g.message(code:"socialGroup.groupType.period.label", default:"Period")}"
											error="${hasErrors(bean:groupBean, field:'name', 'error')}"
											errors="${g.renderErrors(bean:groupBean, field:'name', as:'list')}">
								<!--<g:field type="text" name="period" id="period" class="input-medium" required="" value=""/>-->
								<input 	type="text" class="input-medium"
										name="period" required="" value="${groupBean?.period.name}" autocomplete='off'
										data-provide="typeahead" data-items="4"
										data-source='${periodJSON}'>									
							</tb:controlGroup>

							<tb:controlGroup name="group"
											bean="groupBean"
											labelMessage="${g.message(code:"socialGroup.groupType.group.label", default:"Group")}"
											error="${hasErrors(bean:groupBean, field:'name', 'error')}"
											errors="${g.renderErrors(bean:groupBean, field:'name', as:'list')}">
								<g:field type="text" name="group" id="group" class="input-medium" required="" value="${groupBean.name}" autocomplete='off'/>
							</tb:controlGroup>
							
							<div class="form-actions">
								<button type="submit" class="btn btn-success">
									<i class="icon-ok icon-white"></i>
									<g:message code="default.button.update.label" default="Update"/>
								</button>
								<a href="${createLink(uri: "/schoolAdmin/groupList?school=${schoolBean.id}")}" class="btn">
									<i class="icon-ban-circle"></i>
									<g:message code="default.button.cancel.label" default="Cancel"/>
								</a> <!-- /btn -->							
							</div>
						
					</g:form>
				</fieldset>
	
			</div> <!-- /span -->
		</div>	
	</body>
</html>

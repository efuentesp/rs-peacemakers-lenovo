<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="socialGroup.school.delete.header" default="Delete School" /></title>
	</head>
	
	<body>
		<!-- Left Panel -->
		<g:render template="schoolLeftPanel"/>
		
		<!--  Content Panel -->
		<div class="span9">
			<!-- Page Header -->
			<div class="page-header">
				<h1>
					<i class="icon-bell"></i> <g:message code="socialGroup.school.delete.header" default="Delete School"/>
				</h1>
			</div> <!-- page-header -->
			<p></p>
	
			<!-- Error Panel -->
			<g:if test="${flash.message}">
				<div class="alert alert-block alert-info">
					<a class="close" data-dismiss="alert">&times;</a>
					${flash.message}
				</div>
			</g:if>
	
			<!-- Form -->
			<fieldset>
				<g:form action="schoolRemove" method="post" class="form-horizontal">

					<g:hiddenField name="geo" value="${geoBean?.id}" />
					<g:hiddenField name="city" value="${city}" />
					<g:hiddenField name="country" value="${country}" />	
					<g:hiddenField name="id" value="${schoolBean?.id}" />
					<g:hiddenField name="version" value="${schoolBean?.version}" />

					<tb:controlGroup name="name"
									bean="schoolBean"
									labelMessage="${g.message(code:"socialGroup.name.label", default:"Name")}"
									error="${hasErrors(bean:schoolBean, field:'name', 'error')}"
									errors="${g.renderErrors(bean:schoolBean, field:'name', as:'list')}">
						<span class="input-xxlarge uneditable-input">${schoolBean?.name}</span>
					</tb:controlGroup>
					
					<div class="control-group">
						<label class="control-label"><g:message code="socialGroup.groupCategory.label" default="Category"/></label>
						<div class="controls">
							<span class="input-medium uneditable-input"><g:message code="socialGroup.groupCategory.${schoolBean?.groupCategory.toString()}.label" default="${schoolBean?.groupCategory.toString()}"/></span>
						</div>
					</div>
					
					<tb:controlGroup name="street"
									bean="schoolBean"
									labelMessage="${g.message(code:"socialGroup.address.street.label", default:"Street")}"
									error="${hasErrors(bean:schoolBean, field:'address?.street', 'error')}"
									errors="${g.renderErrors(bean:schoolBean, field:'address.street', as:'list')}">
						<span class="input-xxlarge uneditable-input">${schoolBean?.address?.street}</span>
					</tb:controlGroup>	

					<fieldset>
						<div class="control-group">
							<label class="control-label" for="geoName"><g:message code="geography.name.label" default="Name"/></label>
							<div class="controls">
								<span class="input-xlarge uneditable-input">${geoBean?.name}</span>
							</div>
						</div>
					</fieldset>

					<h4><g:message code="role.ROLE_ADMIN_SCHOOL.label" default="School Administrator"/></h4>

					<tb:controlGroup name="user"
									bean="user"
									labelMessage="${g.message(code:"user.username.label", default:"User id")}"
									error="${hasErrors(bean:user, field:'user', 'error')}"
									errors="${g.renderErrors(bean:user, field:'user', as:'list')}">
						<span class="input-large uneditable-input">${schoolBean.admin.username}</span>
					</tb:controlGroup>
					
					<tb:controlGroup name="password"
									bean="user"
									labelMessage="${g.message(code:"user.password.label", default:"Password")}"
									error="${hasErrors(bean:user, field:'password', 'error')}"
									errors="${g.renderErrors(bean:user, field:'password', as:'list')}">
						<span class="input-large uneditable-input">${schoolBean.admin.unencode}</span>
					</tb:controlGroup>
					
					<div class="form-actions">
						<button type="submit" class="btn btn-danger">
							<i class="icon-trash icon-white"></i>
							<g:message code="default.button.delete.label" default="Delete"/>
						</button>
						<a href="${createLink(uri: "/socialGroup/${action}List?city=${city}&country=${country}")}" class="btn">
							<i class="icon-ban-circle"></i>
							<g:message code="default.button.cancel.label" default="Cancel"/>
						</a> <!-- /btn -->	
					</div>
					
				</g:form>
			</fieldset>

		</div> <!-- /span9 -->
	
	</body>
</html>

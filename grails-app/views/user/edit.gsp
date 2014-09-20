<!doctype html>
<html>
	<head>
		<shiro:hasRole name="Administrator">
			<meta name="layout" content="main">
		</shiro:hasRole>
		<shiro:hasRole name="SchoolAdmin">
			<meta name="layout" content="schoolAdmin">
		</shiro:hasRole>
		<shiro:hasRole name="SchoolAssistant">
			<meta name="layout" content="schoolAdmin">
		</shiro:hasRole>
		<title><g:message code="user.edit.header" default="Edit School" /></title>
	</head>
	
	<body>
		<!-- Left Panel -->
		<shiro:hasRole name="Administrator">
			<g:render template="leftPanel"/>
		</shiro:hasRole>
		
		<!--  Content Panel -->
		<div class="span9">
			<!-- Page Header -->
			<div class="page-header">
				<h1>
					<i class="icon-group"></i> <g:message code="user.edit.header" default="Edit User"/> <g:if test="${groupMember}"><small>${groupMember}</small></g:if>
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
				<g:form action="update" method="post" class="form-horizontal">
				
					<g:hiddenField name="user" value="${userToEdit.id}" />
					<g:hiddenField name="role" value="${role}" />
					<g:hiddenField name="socialGroup" value="${socialGroup}" />
				
					<div class="control-group">
						<label class="control-label"><g:message code="user.username.label" default="User"/></label>
						<div class="controls">
							<span class="input-large uneditable-input">${userToEdit.username}</span>
						</div>
					</div>
					
					<tb:controlGroup name="password"
									bean="userToEdit"
									labelMessage="${g.message(code:"user.password.label", default:"Password")}"
									error="${hasErrors(bean:userToEdit, field:'password', 'error')}"
									errors="${g.renderErrors(bean:userToEdit, field:'password', as:'list')}">
						<g:field type="text" name="password" id="password" class="input-large" value="${userToEdit.unencode}" autocomplete='off'/>
					</tb:controlGroup>									
					
					<div class="control-group">
						<label class="control-label"><g:message code="user.enabled.label" default="Status"/></label>
						<div class="controls">
							<g:if test="${userToEdit.username != 'admin'}">
								<label class="radio">
									<input type="radio" name="userEnabled" id="enabled" value="true" <g:if test = "${userToEdit.enabled == true}"> checked </g:if>>
									<g:message code="user.enabled.true.label" default="Enabled"/>
								</label>							
								<label class="radio">
									<input type="radio" name="userEnabled" id="disabled" value="false" <g:if test = "${userToEdit.enabled == false}"> checked </g:if>>
									<g:message code="user.enabled.false.label" default="Disabled"/>
								</label>
							</g:if>
							<g:else>
								<span class="input-medium uneditable-input"><g:message code="user.enabled.${userToEdit.enabled}.label" default="unknown"/></span>
							</g:else>
						</div>
					</div>
					
					<g:if test="${groupMember}"></g:if>
					<g:else>					
					<div class="control-group">
						<label class="control-label"><g:message code="role.list.header" default="Roles"/></label>
						<div class="controls">
							<g:if test="${userToEdit.username != 'admin'}">
								<g:each in="${roles}" var="role">				
									<label class="checkbox">
										<input type="checkbox" name="roles" value="${role.name}" <g:if test="${role.name in userToEdit.roles.name}">checked</g:if>>
										<g:message code="role.${role.name}.label" default="Role Unknown"/>
									</label>
								</g:each>
							</g:if>
							<g:else>
								<g:each in="${userToEdit.getAuthorities()}" var="role">
									<span class="input-medium uneditable-input"><g:message code="role.${role.name}.label" default="Role Unknown"/></span>
								</g:each>
							</g:else>
						</div>
					</div>
					</g:else>		
					
					<div class="form-actions">
						<button type="submit" class="btn btn-success">
							<i class="icon-ok icon-white"></i>
							<g:message code="default.button.update.label" default="Update"/>
						</button>
						<g:if test="${groupMember}">
							<a href="${createLink(uri: "/user/listBySocialGroup/${socialGroup}")}" class="btn">
								<i class="icon-ban-circle"></i>
								<g:message code="default.button.cancel.label" default="Cancel"/>
							</a> <!-- /btn -->
						</g:if>
						<g:else>
							<a href="${createLink(uri: "/user/list/${role}")}" class="btn">
								<i class="icon-ban-circle"></i>
								<g:message code="default.button.cancel.label" default="Cancel"/>
							</a> <!-- /btn -->
						</g:else>	
					</div>
					
				</g:form>
			</fieldset>

		</div> <!-- /span9 -->
	
	</body>
</html>

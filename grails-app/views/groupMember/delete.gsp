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
		<title><g:message code="groupMember.delete.header" default="Delete Student" /></title>
		<link rel="stylesheet" href="${resource(dir: 'fileupload/css', file: 'fileupload.css')}"> 
	</head>
	
	<body>

		<ul class="breadcrumb">
			<shiro:hasRole name="Administrator">
				<li><a href="${createLink(uri: "/socialGroup/schoolList?city=${groupMemberBean?.socialGroup?.parent?.geo.id}&country=${groupMemberBean?.socialGroup?.parent?.geo?.parent.id}")}"><g:message code="socialGroup.school.list.header" default="Schools" /></a> <span class="divider">/</span></li>
				<li><a href="${createLink(uri: "/socialGroup/groupList?school=${groupMemberBean?.socialGroup?.parent.id}&stage=${groupMemberBean?.socialGroup?.stage.id}&period=${groupMemberBean?.socialGroup?.period.id}&city=${groupMemberBean?.socialGroup?.parent?.geo.id}&country=${groupMemberBean?.socialGroup?.parent?.geo?.parent.id}")}"><g:message code="socialGroup.group.list.header" default="Groups" /></a> <span class="divider">/</span></li>
			</shiro:hasRole>
			<shiro:hasRole name="SchoolAdmin">
				<li><a href="${createLink(uri: "/schoolAdmin/groupList?school=${groupMemberBean?.socialGroup?.parent.id}&stage=${groupMemberBean?.socialGroup?.stage.id}&period=${groupMemberBean?.socialGroup?.period.id}&city=${groupMemberBean?.socialGroup?.parent?.geo.id}&country=${groupMemberBean?.socialGroup?.parent?.geo?.parent.id}")}"><g:message code="socialGroup.group.list.header" default="Groups" /></a> <span class="divider">/</span></li>
			</shiro:hasRole>
			<shiro:hasRole name="SchoolAssistant">
				<li><a href="${createLink(uri: "/schoolAdmin/groupList?school=${groupMemberBean?.socialGroup?.parent.id}&stage=${groupMemberBean?.socialGroup?.stage.id}&period=${groupMemberBean?.socialGroup?.period.id}&city=${groupMemberBean?.socialGroup?.parent?.geo.id}&country=${groupMemberBean?.socialGroup?.parent?.geo?.parent.id}")}"><g:message code="socialGroup.group.list.header" default="Groups" /></a> <span class="divider">/</span></li>
			</shiro:hasRole>
			<li><a href="${createLink(uri: "/groupMember/list/${groupMemberBean?.socialGroup.id}")}"><g:message code="groupMember.list.header" default="Group Member" /></a> <span class="divider">/</span></li>
			<li class="active"><g:message code="groupMember.label" default="Group Member" /></li>
		</ul>
				
		<!--  Content Panel -->
		<div class="span9">
			<!-- Page Header -->
			<div class="page-header">
				<h1>
					<i class="icon-group"></i> 
					<g:message code="groupMember.delete.header" default="Delete Student"/>
					<p><small><strong>${groupMemberBean?.socialGroup?.parent.name} (${groupMemberBean?.socialGroup?.stage.name}, ${groupMemberBean?.socialGroup?.period.name} ${groupMemberBean?.socialGroup.name})</strong></small></p>
				</h1>
			</div>
	
			<!-- Error Panel -->
			<g:if test="${flash.message}">
				<div class="alert alert-block alert-info">
					<a class="close" data-dismiss="alert">&times;</a>
					${flash.message}
				</div>
			</g:if>

			<g:hasErrors bean="${groupMemberBean}">
				<div class="alert alert-block alert-error">
					<a class="close" data-dismiss="alert">&times;</a>
					<ul>
						<g:eachError bean="${groupMemberBean}" var="error">
						<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
							<g:message error="${error}"/>
						</li>
						</g:eachError>
					</ul>
				</div>
			</g:hasErrors>

	
			<!-- Form -->
			<fieldset>
				<g:form action="remove" method="post" class="form-horizontal">

						<g:hiddenField name="socialGroup" value="${groupMemberBean?.socialGroup.id}" />
						
						<g:hiddenField name="id" value="${groupMemberBean.id}" />
						<g:hiddenField name="version" value="${groupMemberBean.version}" />
						
						<div class="control-group">
							<label class="control-label"><g:message code="groupMember.person.photo.label" default="Photo"/></label>
							<div class="controls">
								<img class="photo" src="${createLink(controller:'GroupMember', action:'renderPhoto', id:groupMemberBean.id)}"/>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label"><g:message code="groupMember.person.fullName.label" default="Full Name"/></label>
							<div class="controls inline-inputs">
								<span class="input-xlarge uneditable-input">${groupMemberBean?.person.firstSurname} ${groupMemberBean?.person.secondSurname}, ${groupMemberBean?.person.firstName}</span>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label"><g:message code="groupMember.person.gender.label" default="Gender"/></label>
							<div class="controls">
								<span class="input-medium uneditable-input"><g:message code="groupMember.person.gender.${groupMemberBean?.person.gender}.label" default="--"/></span>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label"><g:message code="groupMember.person.birthday.label" default="Birthday"/></label>
							<div class="input controls">
								<span class="input-medium uneditable-input"><g:formatDate date="${groupMemberBean?.person.birthday}" type="date" style="LONG"/></span>
							</div>
						</div>
						
						<div class="form-actions">
							<button type="submit" class="btn btn-danger">
								<i class="icon-trash icon-white"></i>
								<g:message code="default.button.delete.label" default="Delete"/>
							</button>
							<a href="${createLink(uri: "/groupMember/list/${groupMemberBean?.socialGroup.id}")}" class="btn">
								<i class="icon-ban-circle"></i>
								<g:message code="default.button.cancel.label" default="Cancel"/>
							</a> <!-- /btn -->							
						</div>
					
				</g:form>
			</fieldset>

		</div> <!-- /span -->
    
	    <script src="${resource(dir: 'bootstrap/js', file: 'bday-picker.min.js')}"></script>
    
	</body>
	
</html>

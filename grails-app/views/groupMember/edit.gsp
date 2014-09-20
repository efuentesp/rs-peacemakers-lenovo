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
		<title><g:message code="groupMember.edit.header" default="Edit Student" /></title>
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
					<g:message code="groupMember.edit.header" default="Edit Student"/>
					<p><small><strong>${groupMemberBean?.socialGroup?.parent.name} (${groupMemberBean?.socialGroup?.stage.name}, ${groupMemberBean?.socialGroup?.period.name} ${groupMemberBean?.socialGroup.name})</strong></small></p>
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
				<g:uploadForm action="update" method="post" class="form-horizontal">

					<g:hiddenField name="unknownPhoto" value="no" />

						<g:hiddenField name="socialGroup" value="${groupMemberBean?.socialGroup.id}" />
						<g:hiddenField id= "restURI" name="restURI" value="${restURI}" />
						
						<g:hiddenField name="id" value="${groupMemberBean.id}" />
						<g:hiddenField name="version" value="${groupMemberBean.version}" />
						
						<g:hiddenField name="birthay" value="${groupMemberBean?.person.birthday}" />

						
						<div class="control-group">
							<label class="control-label"><g:message code="groupMember.person.photo.label" default="Photo"/></label>
							<div class="controls">
								<img id="photo" class="photo" src="${createLink(controller:'GroupMember', action:'renderPhoto', id:groupMemberBean.id)}"/>
								<input type="file" id="photoUpload" name="photoUpload" size="20" />
								<a class="btn btn-small btn-danger" onclick="removePhoto();">
									<i class="icon-remove icon-white"></i>
									<g:message code="groupMember.button.removePhoto.label" default="Remove Photo"/>
								</a>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label"><g:message code="groupMember.person.fullName.label" default="Full Name"/></label>
							<div class="controls inline-inputs">
								<input type="text" name="firstName" value="${groupMemberBean?.person.firstName}" required="" id="firstName" autocomplete='off' class="input-medium" placeholder="<g:message code="groupMember.person.firstName.label" default="First Name"/>">
								<input type="text" name="firstSurname" value="${groupMemberBean?.person.firstSurname}" required="" id="firstSurname" autocomplete='off' class="input-medium" placeholder="<g:message code="groupMember.person.firstSurname.label" default="First Surname"/>">
								<input type="text" name="secondSurname" value="<g:if test="${groupMemberBean?.person.secondSurname}">${groupMemberBean?.person.secondSurname}</g:if>" id="secondSurname" autocomplete='off' class="input-medium" placeholder="<g:message code="groupMember.person.secondSurname.label" default="Second Surname"/>">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label"><g:message code="groupMember.person.gender.label" default="Gender"/></label>
							<div class="controls">
								<label class="radio">
									<input type="radio" name="gender" id="genderFemale" value="F" <g:if test = "${groupMemberBean?.person.gender.toString() == 'FEMALE'}"> checked </g:if>>
									<g:message code="groupMember.person.gender.FEMALE.label" default="Female"/>
								</label>							
								<label class="radio">
									<input type="radio" name="gender" id="genderMale" value="M" <g:if test = "${groupMemberBean?.person.gender.toString() == 'MALE'}"> checked </g:if>>
									<g:message code="groupMember.person.gender.MALE.label" default="Male"/>
								</label>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label"><g:message code="groupMember.person.birthday.label" default="Birthday"/></label>
							<div class="input controls">
								<div class="picker" id="birthday"></div>
							</div>
						</div>
						
						<div class="form-actions">
							<button type="submit" class="btn btn-success">
								<i class="icon-ok icon-white"></i>
								<g:message code="default.button.update.label" default="Update"/>
							</button>
							<a href="${createLink(uri: "/groupMember/list/${groupMemberBean?.socialGroup.id}")}" class="btn">
								<i class="icon-ban-circle"></i>
								<g:message code="default.button.cancel.label" default="Cancel"/>
							</a> <!-- /btn -->							
						</div>
					
				</g:uploadForm>
			</fieldset>

		</div> <!-- /span -->
    
	    <script src="${resource(dir: 'bootstrap/js', file: 'bday-picker.min.js')}"></script>
	    
		<script type="text/javascript">
			$(document).ready(function(){

				$("#birthday").birthdaypicker({
					maxAge: 25,
					dateFormat: "bigEndian",
					yearLabel: "-- Año --",
					monthLabel: "-- Mes --",
					dayLabel: "-- Día --"
				});
			});

			function removePhoto() {
	            //var src = '/cf-peacemakers/groupMember/renderPhoto/0'; //Desarrollo
	            //var src = '/groupMember/renderPhoto/0'; //Producción
	            var src = $('#restURI').val();
	            $('#photo').attr("src", src);
	            $('#unknownPhoto').val("yes");
			}
	    </script>
    
	</body>
	
</html>

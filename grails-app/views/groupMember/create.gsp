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
		<title><g:message code="groupMember.create.header" default="Create Student" /></title>
	</head>
	
	<body>
	
		<ul class="breadcrumb">
			<shiro:hasRole name="Administrator">
				<li><a href="${createLink(uri: "/socialGroup/schoolList?city=${socialGroupSelected?.parent?.geo.id}&country=${socialGroupSelected?.parent?.geo?.parent.id}")}"><g:message code="socialGroup.school.list.header" default="Schools" /></a> <span class="divider">/</span></li>
				<li><a href="${createLink(uri: "/socialGroup/groupList?school=${socialGroupSelected?.parent.id}&stage=${socialGroupSelected?.stage.id}&period=${socialGroupSelected?.period.id}&city=${socialGroupSelected?.parent?.geo.id}&country=${socialGroupSelected?.parent?.geo?.parent.id}")}"><g:message code="socialGroup.group.list.header" default="Groups" /></a> <span class="divider">/</span></li>
			</shiro:hasRole>
			<shiro:hasRole name="SchoolAdmin">
				<li><a href="${createLink(uri: "/schoolAdmin/groupList?school=${socialGroupSelected?.parent.id}&stage=${socialGroupSelected?.stage.id}&period=${socialGroupSelected?.period.id}&city=${socialGroupSelected?.parent?.geo.id}&country=${socialGroupSelected?.parent?.geo?.parent.id}")}"><g:message code="socialGroup.group.list.header" default="Groups" /></a> <span class="divider">/</span></li>
			</shiro:hasRole>
			<shiro:hasRole name="SchoolAssistant">
				<li><a href="${createLink(uri: "/schoolAdmin/groupList?school=${socialGroupSelected?.parent.id}&stage=${socialGroupSelected?.stage.id}&period=${socialGroupSelected?.period.id}&city=${socialGroupSelected?.parent?.geo.id}&country=${socialGroupSelected?.parent?.geo?.parent.id}")}"><g:message code="socialGroup.group.list.header" default="Groups" /></a> <span class="divider">/</span></li>
			</shiro:hasRole>
			<li><a href="${createLink(uri: "/groupMember/list/${socialGroupSelected.id}")}"><g:message code="groupMember.list.header" default="Group Member" /></a> <span class="divider">/</span></li>
			<li class="active"><g:message code="groupMember.label" default="Group Member" /></li>
		</ul>
		
		<!--  Content Panel -->
		<div class="span9">
			<!-- Page Header -->
			<div class="page-header">
				<h1>
					<i class="icon-group"></i>  <g:message code="groupMember.create.header" default="Create Student"/>
					<p><small><strong>${socialGroupSelected?.parent.name} (${socialGroupSelected?.stage.name}, ${socialGroupSelected?.period.name} ${socialGroupSelected.name})</strong></small></p>
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
				<g:uploadForm action="save" method="post" class="form-horizontal">

						<g:hiddenField name="socialGroup" value="${socialGroupSelected.id}" />
						
						<!-- Photo -->
						<div class="control-group">
							<label class="control-label"><g:message code="groupMember.person.photo.label" default="Photo"/></label>
							<div class="controls">
								<input type="file" id="photoUpload" name="photoUpload" size="20" value="" required />
							</div>
						</div>
						
						<!-- Group Member name -->
						<div class="control-group">
							<label class="control-label"><g:message code="groupMember.person.fullName.label" default="Full Name"/></label>
							<div class="controls inline-inputs">
								<input type="text" name="firstName" value="" required id="firstName"  autocomplete='off' class="input-medium" placeholder="<g:message code="groupMember.person.firstName.label" default="First Name"/>">
								<input type="text" name="firstSurname" value="" required id="firstSurname"  autocomplete='off' class="input-medium" placeholder="<g:message code="groupMember.person.firstSurname.label" default="First Surname"/>">
								<input type="text" name="secondSurname" value="" required id="firstSurname"  autocomplete='off' class="input-medium" placeholder="<g:message code="groupMember.person.secondSurname.label" default="Second Surname"/>">
							</div>
						</div>
						
						<!-- Group Member gender -->
						<div class="control-group">
							<label class="control-label"><g:message code="groupMember.person.gender.label" default="Gender"/></label>
							<div class="controls">
								<label class="radio">
									<input type="radio" name="gender" id="genderFemale" value="F">
									<g:message code="groupMember.person.gender.FEMALE.label" default="Female"/>
								</label>							
								<label class="radio">
									<input type="radio" name="gender" id="genderMale" value="M">
									<g:message code="groupMember.person.gender.MALE.label" default="Male"/>
								</label>
							</div>
						</div>

						<!-- Group Member birthday -->
						<div class="control-group">
							<label class="control-label"><g:message code="groupMember.person.birthday.label" default="Birthday"/></label>
							<div class="input controls">
								<!-- <g:datePicker name="birthday" default="${new Date().plus(7)}" precision="day" relativeYears="[-20..0]" noSelection="['':'-Choose-']"/> -->
								<div class="picker" id="birthday"></div>
							</div>
						</div>
						
						<div class="form-actions">
							<button type="submit" class="btn btn-primary">
								<i class="icon-ok icon-white"></i>
								<g:message code="default.button.create.label" default="Save"/>
							</button>
							<a href="${createLink(uri: "/groupMember/list/${socialGroupSelected.id}")}" class="btn">
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
	    </script>
    
	</body>
	
</html>

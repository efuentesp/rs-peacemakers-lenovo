<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="survey.delete.header" default="Delete Survey" /></title>
	</head>
	
	<body>
		
		<!--  Content Panel -->
		<div class="span9">
			<!-- Page Header -->
			<div class="page-header">
				<h1>
					<i class="icon-check"></i>  <g:message code="survey.delete.header" default="Delete Survey"/>
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

			<g:hasErrors bean="${surveyBean}">
				<div class="alert alert-block alert-error">
					<a class="close" data-dismiss="alert">&times;</a>
					<ul>
						<g:eachError bean="${surveyBean}" var="error">
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
					
					<g:hiddenField name="id" value="${surveyBean?.id}" />
					<g:hiddenField name="version" value="${surveyBean?.version}" />
					
					<!-- 	
					<tb:controlGroup name="code"
									bean="surveyBean"
									labelMessage="${g.message(code:"survey.code.label", default:"Code")}"
									error="${hasErrors(bean: surveyBean, field: 'code', 'error')}"
									errors="${g.renderErrors(bean: surveyBean, field: 'code', as:'list')}">
						<g:field type="text" name="code" id="code" class="input-medium" required="" value="" autocomplete='off'/>
					</tb:controlGroup>
					-->
					
					<tb:controlGroup name="name"
									bean="surveyBean"
									labelMessage="${g.message(code:"survey.name.label", default:"Name")}"
									error="${hasErrors(bean: surveyBean, field: 'name', 'error')}"
									errors="${g.renderErrors(bean: surveyBean, field: 'name', as:'list')}">
						<span class="input-xxlarge uneditable-input">${surveyBean.name}</span>
					</tb:controlGroup>
					
					<div class="form-actions">
						<button type="submit" class="btn btn-danger">
							<i class="icon-trash icon-white"></i>
							<g:message code="default.button.delete.label" default="Delete"/>
						</button>
						<a href="${createLink(uri: "/survey/list/")}" class="btn">
							<i class="icon-ban-circle"></i>
							<g:message code="default.button.cancel.label" default="Cancel"/>
						</a> <!-- /btn -->							
					</div>
					
				</g:form>
			</fieldset>

		</div> <!-- /span -->
        
	</body>
	
</html>

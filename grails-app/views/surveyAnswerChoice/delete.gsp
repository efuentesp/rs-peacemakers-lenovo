<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="survey.question.answerChoice.delete.header" default="Delete Survey Answer Choice" /></title>
	</head>
	
	<body>
		
		<!--  Content Panel -->
		<div class="span9">
			<!-- Page Header -->
			<div class="page-header">
				<h1>
					<i class="icon-check"></i>  <g:message code="survey.question.answerChoice.delete.header" default="Delete Survey Answer Choice"/>
					<small><strong>${surveyAnswerChoice.question.description}</strong></small>
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

			<g:hasErrors bean="${surveyAnswerChoice}">
				<div class="alert alert-block alert-error">
					<a class="close" data-dismiss="alert">&times;</a>
					<ul>
						<g:eachError bean="${surveyAnswerChoice}" var="error">
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
					
					<g:hiddenField name="id" value="${surveyAnswerChoice?.id}" />
					<g:hiddenField name="version" value="${surveyAnswerChoice?.version}" />
					
					<tb:controlGroup name="description"
									bean="surveyAnswerChoiceBean"
									labelMessage="${g.message(code:"survey.question.answerChoice.description.label", default:"Description")}"
									error="${hasErrors(bean: surveyAnswerChoiceBean, field: 'description', 'error')}"
									errors="${g.renderErrors(bean: surveyAnswerChoiceBean, field: 'description', as:'list')}">
						<span class="input-xxlarge uneditable-input">${surveyAnswerChoice.description}</span>
					</tb:controlGroup>
					
					<tb:controlGroup name="points"
									bean="surveyAnswerChoiceBean"
									labelMessage="${g.message(code:"survey.question.answerChoice.points.label", default:"Points")}"
									error="${hasErrors(bean: surveyAnswerChoiceBean, field: 'points', 'error')}"
									errors="${g.renderErrors(bean: surveyAnswerChoiceBean, field: 'points', as:'list')}">
						<span class="input-small uneditable-input">${surveyAnswerChoice.points}</span>
					</tb:controlGroup>
					
					<div class="form-actions">
						<button type="submit" class="btn btn-danger">
							<i class="icon-trash icon-white"></i>
							<g:message code="default.button.delete.label" default="Delete"/>
						</button>
						<a href="${createLink(uri: "/surveyAnswerChoice/list")}/${surveyAnswerChoice.question.id}" class="btn">
							<i class="icon-ban-circle"></i>
							<g:message code="default.button.cancel.label" default="Cancel"/>
						</a> <!-- /btn -->							
					</div>
					
				</g:form>
			</fieldset>

		</div> <!-- /span -->
        
	</body>
	
</html>

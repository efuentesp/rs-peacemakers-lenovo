<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="survey.question.answerChoice.create.header" default="Create Survey Answer Choice" /></title>
	</head>
	
	<body>
		
		<!--  Content Panel -->
		<div class="span9">
			<!-- Page Header -->
			<div class="page-header">
				<h1>
					<i class="icon-check"></i>  <g:message code="survey.question.answerChoice.create.header" default="Create Survey Answer Choice"/>
					<small><strong>${surveyQuestion.description}</strong></small>
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

			<g:hasErrors bean="${surveyQuestion}">
				<div class="alert alert-block alert-error">
					<a class="close" data-dismiss="alert">&times;</a>
					<ul>
						<g:eachError bean="${surveyQuestion}" var="error">
						<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
							<g:message error="${error}"/>
						</li>
						</g:eachError>
					</ul>
				</div>
			</g:hasErrors>
	
			<!-- Form -->
			<fieldset>
				<g:form action="save" method="post" class="form-horizontal">
					
					<g:hiddenField name="surveyQuestion" value="${surveyQuestion.id}" />
					
					<!-- 
					<tb:controlGroup name="code"
									bean="surveyAnswerChoiceBean"
									labelMessage="${g.message(code:"survey.question.answerChoice.code.label", default:"Code")}"
									error="${hasErrors(bean: surveyAnswerChoiceBean, field: 'code', 'error')}"
									errors="${g.renderErrors(bean: surveyAnswerChoiceBean, field: 'code', as:'list')}">
						<g:field type="text" name="code" id="code" class="input-medium" required="" value="" autocomplete='off'/>
					</tb:controlGroup>
					-->
					
					<tb:controlGroup name="description"
									bean="surveyAnswerChoiceBean"
									labelMessage="${g.message(code:"survey.question.answerChoice.description.label", default:"Description")}"
									error="${hasErrors(bean: surveyAnswerChoiceBean, field: 'description', 'error')}"
									errors="${g.renderErrors(bean: surveyAnswerChoiceBean, field: 'description', as:'list')}">
						<g:field type="text" name="description" id="description" class="input-xxlarge" required="" value="" autocomplete='off'/>
					</tb:controlGroup>
					
					<tb:controlGroup name="points"
									bean="surveyAnswerChoiceBean"
									labelMessage="${g.message(code:"survey.question.answerChoice.points.label", default:"Points")}"
									error="${hasErrors(bean: surveyAnswerChoiceBean, field: 'points', 'error')}"
									errors="${g.renderErrors(bean: surveyAnswerChoiceBean, field: 'points', as:'list')}">
						<g:field type="text" name="points" id="points" class="input-small" required="" value="" autocomplete='off'/>
					</tb:controlGroup>
					
					<div class="form-actions">
						<button type="submit" class="btn btn-primary">
							<i class="icon-ok icon-white"></i>
							<g:message code="default.button.create.label" default="Save"/>
						</button>
						<a href="${createLink(uri: "/surveyAnswerChoice/list")}/${surveyQuestion.id}" class="btn">
							<i class="icon-ban-circle"></i>
							<g:message code="default.button.cancel.label" default="Cancel"/>
						</a> <!-- /btn -->							
					</div>
					
				</g:form>
			</fieldset>

		</div> <!-- /span -->
        
	</body>
	
</html>

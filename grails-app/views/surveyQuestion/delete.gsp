<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="survey.question.delete.header" default="Delete Survey Question" /></title>
	</head>
	
	<body>
		
		<!--  Content Panel -->
		<div class="span9">
			<!-- Page Header -->
			<div class="page-header">
				<h1>
					<i class="icon-check"></i>  <g:message code="survey.question.delete.header" default="Delete Survey Question"/>
					<small><strong>${surveyQuestion.survey.name}</strong></small>
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
				<g:form action="remove" method="post" class="form-horizontal">
					
					<g:hiddenField name="id" value="${surveyQuestion?.id}" />
					<g:hiddenField name="version" value="${surveyQuestion?.version}" />
					
					<!-- 
					<tb:controlGroup name="code"
									bean="surveyQuestionBean"
									labelMessage="${g.message(code:"survey.question.code.label", default:"Code")}"
									error="${hasErrors(bean: surveyQuestionBean, field: 'code', 'error')}"
									errors="${g.renderErrors(bean: surveyQuestionBean, field: 'code', as:'list')}">
						<g:field type="text" name="code" id="code" class="input-medium" required="" value="" autocomplete='off'/>
					</tb:controlGroup>
					-->
					
					<tb:controlGroup name="description"
									bean="surveyQuestionBean"
									labelMessage="${g.message(code:"survey.question.description.label", default:"Description")}"
									error="${hasErrors(bean: surveyQuestionBean, field: 'description', 'error')}"
									errors="${g.renderErrors(bean: surveyQuestionBean, field: 'description', as:'list')}">
						<span class="input-xxlarge uneditable-input">${surveyQuestion.description}</span>
					</tb:controlGroup>

					<!-- Survey Question type -->
					<g:hiddenField name="type" value="MULTI_CHOICE" />
					<g:hiddenField name="sequence" value="0" />
					<!-- 
					<div class="control-group">
						<label class="control-label"><g:message code="survey.question.type.label" default="Type"/></label>
						<div class="controls">
							<label class="radio">
								<input type="radio" name="type" id="typeMultiChoice" value="MULTI_CHOICE">
								<g:message code="survey.question.type.MULTI_CHOICE.label" default="Multi Choice"/>
							</label>							
							<label class="radio">
								<input type="radio" name="type" id="typeMultipleCorrect" value="MULTIPLE_CORRECT">
								<g:message code="survey.question.type.MULTIPLE_CORRECT.label" default="Multiple Correct"/>
							</label>
						</div>
					</div>
					-->
					
					<div class="form-actions">
						<button type="submit" class="btn btn-danger">
							<i class="icon-trash icon-white"></i>
							<g:message code="default.button.delete.label" default="Delete"/>
						</button>
						<a href="${createLink(uri: "/surveyQuestion/list")}/${surveyQuestion.survey.id}" class="btn">
							<i class="icon-ban-circle"></i>
							<g:message code="default.button.cancel.label" default="Cancel"/>
						</a> <!-- /btn -->							
					</div>
					
				</g:form>
			</fieldset>

		</div> <!-- /span -->
        
	</body>
	
</html>

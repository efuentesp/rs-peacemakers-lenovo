<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="geography.country.create.header" default="Create Country" /></title>
	</head>
	
	<body>
		<!-- Left Panel -->
		<g:render template="leftPanel"/>
		
		<!--  Content Panel -->
		<div class="span9">
			<!-- Page Header -->
			<div class="page-header">
				<h1><g:message code="geography.country.create.header" default="Create Country"/></h1>
			</div> <!-- page-header -->
			<p></p>
	
			<!-- Error Panel -->
			<g:if test="${flash.message}">
				<div class="alert alert-block alert-info">
					<a class="close" data-dismiss="alert">&times;</a>
					${flash.message}
				</div>
			</g:if>
			<!-- 
			<g:hasErrors bean="${countryBean}">
				<div class="alert alert-block alert-error">
					<a class="close" data-dismiss="alert">&times;</a>
					<ul>
						<g:eachError bean="${countryBean}" var="error">
						<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
							<g:message error="${error}"/>
						</li>
						</g:eachError>
					</ul>
				</div>
			</g:hasErrors>
			 -->
	
			<!-- Form -->
			<fieldset>
				<g:form action="countrySave" method="post" class="form-vertical">
				
						<!-- 
						<div class="control-group ${hasErrors(bean:countryBean, field:'isoCode', 'error')}">
							<label class="control-label" for="isoCode">
								<g:message code="geography.isoCode.label" default="Code"/>
							</label>
							<div class="controls">
								<input type="text" name="isoCode" value="" required="" id="isoCode" class="input-small" >
								<g:hasErrors bean="${countryBean}" field="isoCode">
									<span class="help-inline">
								       <g:renderErrors bean="${countryBean}" field="isoCode" as="list" />
								    </span>
								</g:hasErrors>
							</div>
						</div>
						-->

						<tb:controlGroup name="isoCode"
										bean="countryBean"
										labelMessage="${g.message(code:"geography.isoCode.label", default:"Code")}"
										error="${hasErrors(bean:countryBean, field:'isoCode', 'error')}"
										errors="${g.renderErrors(bean:countryBean, field:'isoCode', as:'list')}">
							<input type="text" name="isoCode" value="" required="" id="isoCode" class="input-small alphaOnly" style="text-transform:uppercase;">
						</tb:controlGroup>

						<tb:controlGroup name="name"
										bean="countryBean"
										labelMessage="${g.message(code:"geography.name.label", default:"Name")}"
										error="${hasErrors(bean:countryBean, field:'name', 'error')}"
										errors="${g.renderErrors(bean:countryBean, field:'name', as:'list')}">
							<input type="text" name="name" value="" required="" id="name" class="input-xlarge alphaOnly" >
						</tb:controlGroup>
						
						<div class="form-actions">
							<button type="submit" class="btn btn-primary">
								<i class="icon-ok icon-white"></i>
								<g:message code="default.button.create.label" default="Save"/>
							</button>
							<a href="${createLink(uri: "/geography/${action}List")}" class="btn">
								<i class="icon-ban-circle"></i>
								<g:message code="default.button.cancel.label" default="Cancel"/>
							</a> <!-- /btn -->							
						</div>
					
				</g:form>
			</fieldset>

		</div> <!-- /span -->
	
	</body>
</html>

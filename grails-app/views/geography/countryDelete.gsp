<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="geography.country.delete.header" default="Delete Country" /></title>
	</head>
	
	<body>
		<!-- Left Panel -->
		<g:render template="leftPanel"/>
		
		<!--  Content Panel -->
		<div class="span9">
			<!-- Page Header -->
			<div class="page-header">
				<h1><g:message code="geography.country.delete.header" default="Delete Country"/></h1>
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
				<g:form action="countryRemove" method="post" class="form-vertical">

					<g:hiddenField name="id" value="${countryBean?.id}" />
					<g:hiddenField name="version" value="${countryBean?.version}" />

					<tb:controlGroup name="isoCode"
									bean="countryBean"
									labelMessage="${g.message(code:"geography.isoCode.label", default:"Code")}"
									error="${hasErrors(bean:countryBean, field:'isoCode', 'error')}"
									errors="${g.renderErrors(bean:countryBean, field:'isoCode', as:'list')}">
						<span class="input-small uneditable-input">${countryBean.isoCode}</span>
					</tb:controlGroup>

					<tb:controlGroup name="name"
									bean="countryBean"
									labelMessage="${g.message(code:"geography.name.label", default:"Name")}"
									error="${hasErrors(bean:countryBean, field:'name', 'error')}"
									errors="${g.renderErrors(bean:countryBean, field:'name', as:'list')}">
						<span class="input-xlarge uneditable-input">${countryBean.name}</span>
					</tb:controlGroup>
					
					<div class="form-actions">
						<button type="submit" class="btn btn-danger">
							<i class="icon-trash icon-white"></i>
							<g:message code="default.button.delete.label" default="Delete"/>
						</button>
						<a href="${createLink(uri: "/geography/${action}List")}" class="btn">
							<i class="icon-ban-circle"></i>
							<g:message code="default.button.cancel.label" default="Cancel"/>
						</a> <!-- /btn -->	
					</div>
					
				</g:form>
			</fieldset>

		</div> <!-- /span9 -->
	
	</body>
</html>

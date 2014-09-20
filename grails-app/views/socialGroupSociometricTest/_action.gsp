
<g:form action="save" method="post" class="form-inline">
		<g:select 	from="${sociometricCriterias}"
		id="sociometricCriteria"
		name="sociometricCriteria"
		noSelection="['':'-- Seleccionar --']"
		optionKey="id"
		required=""
		optionValue="name"/>
		<button type="submit" class="btn btn-primary">
			<i class="icon-plus icon-white"></i>
			<g:message code="default.button.create.label" default="Add New"/>
		</button>
		
		<g:hiddenField name="socialGroup" value="${socialGroup.id}" />
</g:form>

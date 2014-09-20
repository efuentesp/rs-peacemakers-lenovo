<g:form action="schoolCreate" method="post">
	<div class="form-actions">
	
		<g:hiddenField name="city" value="${city.id}" />
		<g:hiddenField name="country" value="${country.id}" />
		
		<button type="submit" class="btn btn-primary">
			<i class="icon-plus icon-white"></i>
			<g:message code="default.button.create.label" default="Add New"/>
		</button>		
						
	</div>
</g:form>
<g:form action="groupCreate" method="post">
		
	<form class="form-inline">

		<g:hiddenField name="school" value="${school}" />
		<g:hiddenField name="stage" value="${stage}" />
		<g:hiddenField name="period" value="${period}" />	
		<g:hiddenField name="city" value="${city}" />
		<g:hiddenField name="country" value="${country}" />

		<button type="submit" class="btn btn-primary">
			<i class="icon-plus icon-white"></i>
			<g:message code="default.button.create.label" default="Add New"/>
		</button>
		
	</form>	
						
</g:form>
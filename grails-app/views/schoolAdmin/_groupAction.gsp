
<g:form action="groupCreate" method="post">
		
	<form class="form-inline">

		<g:hiddenField name="school" value="${schoolBean.id}" />

		<button type="submit" class="btn btn-primary">
			<i class="icon-plus icon-white"></i>
			<g:message code="default.button.create.label" default="Add New"/>
		</button>
		
	</form>	
						
</g:form>

<div class="well">
	<a href="${createLink(uri: "/groupMember/create")}/${fieldValue(bean: socialGroupSelected, field: "id")}" class="btn btn-primary">
		<i class="icon-plus icon-white"></i>
		<g:message code="default.button.create.label" default="Add New"/>
	</a>
	
	<a href="${createLink(uri: "/groupMember/createZip")}/${fieldValue(bean: socialGroupSelected, field: "id")}" class="btn btn-inverse">
		<i class="icon-file icon-white"></i>
		<g:message code="groupMember.button.createZip.label" default="Load ZIP File"/>
	</a>
	
	<a href="${createLink(uri: "/user/listBySocialGroup")}/${fieldValue(bean: socialGroupSelected, field: "id")}" class="btn btn-warning">
		<i class="icon-unlock icon-white"></i>
		<g:message code="groupMember.button.passwords.label" default="Passwords"/>
	</a>

	<button type="submit" class="btn btn-danger">
		<i class="icon-trash icon-white"></i>
		<g:message code="default.button.delete.label" default="Delete"/>
	</button>

</div>
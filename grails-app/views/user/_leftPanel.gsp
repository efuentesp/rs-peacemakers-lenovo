<div class="span3">

	<div class="well">

		<ul class="nav nav-list">
			<li class="nav-header"><g:message code="role.list.header" default="Roles"/></li>
			<g:each in="${roles}" var="role">
				<li><a href="${createLink(uri: "/user/list/${role.id}")}"><g:message code="role.${role.name}.label" default="Roles"/></a></li>
			</g:each>
		</ul>

	</div>
	
</div> <!-- /span3 -->
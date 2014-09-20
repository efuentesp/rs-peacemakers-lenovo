<table class="table">
	<thead>
		<tr>
			<th><g:message code="user.username.label" default="User"/></th>
			<th><g:message code="user.enabled.label" default="Status"/></th>
			<th><g:message code="role.list.header" default="Roles"/></th>
			<th></th>
		</tr>
	</thead>
	<tbody>

		<!-- TODO: Show a message when table is empty -->

		<g:each in="${users}" status="i" var="user">
		<tr>
			<td>
				<a href="#"><strong>${user.username}</strong></a>
			</td>
			<td>
				<g:if test="${user.enabled}"><span class="label label-success"><g:message code="user.enabled.true.label" default="Active"/></span></g:if>
				<g:else><span class="label label-important"><g:message code="user.enabled.false.label" default="Inactive"/></span></g:else>
			</td>
			<td>
				<g:each in="${user.roles}" var="role">
					<g:message code="role.${role.name}.label" default="Roles"/>
					<br>
				</g:each>
			</td>			
			<td class="link">

				<div class="btn-toolbar" style="margin: 0;">
					<div class="btn-group">
						<button class="btn dropdown-toggle" data-toggle="dropdown"><g:message code="default.button.action.label" default="Action"/> <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li><a href="${createLink(uri: "/user/edit")}?user=${user.id}&role=${selectedRole.id}"><i class="icon-edit"></i> <g:message code="default.button.edit.label" default="Edit"/></a></li>
							<!-- <li class="divider"></li>
							<li><a href="#"><i class="icon-trash"></i> <g:message code="default.button.delete.label" default="Delete"/></a></li>
							<li><a href="#"><i class="icon-trash"></i> <g:message code="default.button.delete.label" default="Delete"/></a></li> -->
						</ul>
					</div>
				</div>						
			</td>
		</tr>
		</g:each>

	</tbody>
</table> <!-- table -->

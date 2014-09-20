<table class="table table-condensed">
	<thead>
		<tr>
			<th><g:message code="groupMember.person.fullName.label" default="Full Name"/></th>
			<th><g:message code="groupMember.user.userName.label" default="User"/></th>
			<th><g:message code="groupMember.user.password.label" default="Password"/></th>
			<th><g:message code="groupMember.user.enabled.label" default="Status"/></th>
		</tr>
	</thead>
	<tbody>

		<!-- TODO: Show a message when table is empty -->

		<g:each in="${groupMemberList}" var="groupMemberBean">
		<tr>
			<td>${groupMemberBean}</td>
			<td>${groupMemberBean.user.username}</td>
			<td>${groupMemberBean.user.unencode}</td>
			<td>
				<g:if test="${groupMemberBean.user.enabled}"><span class="label label-success"><g:message code="user.enabled.true.label" default="Active"/></span></g:if>
				<g:else><span class="label label-important"><g:message code="user.enabled.false.label" default="Inactive"/></span></g:else>
			</td>
		</tr>
		</g:each>

	</tbody>
</table> <!-- table -->

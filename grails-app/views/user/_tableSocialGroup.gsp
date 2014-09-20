<table class="table">
	<thead>
		<tr>
			<th><g:message code="groupMember.person.photo.label" default="Photo"/></th>
			<th><g:message code="groupMember.person.fullName.label" default="Full Name"/></th>
			<th><g:message code="groupMember.user.userName.label" default="User"/></th>
			<th><g:message code="groupMember.user.password.label" default="Password"/></th>
			<th><g:message code="groupMember.user.enabled.label" default="Status"/></th>
			<th></th>
		</tr>
	</thead>
	<tbody>

		<!-- TODO: Show a message when table is empty -->

		<g:each in="${groupMemberList}" var="groupMemberBean">
		<tr>
			<td><img class="photo_small" src="${createLink(controller:'GroupMember', action:'renderPhoto', id:groupMemberBean.id)}"/></td>
			<td>${groupMemberBean}</td>
			<td>${groupMemberBean.user.username}</td>
			<td>${groupMemberBean.user.unencode}</td>
			<td>
				<g:if test="${groupMemberBean.user.enabled}"><span class="label label-success"><g:message code="user.enabled.true.label" default="Active"/></span></g:if>
				<g:else><span class="label label-important"><g:message code="user.enabled.false.label" default="Inactive"/></span></g:else>
			</td>
			<td class="link">
				
				<div class="btn-toolbar" style="margin: 0;">
			
					<div class="btn-group">
						<button class="btn dropdown-toggle" data-toggle="dropdown"><g:message code="default.button.action.label" default="Action"/> <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li><a href="${createLink(uri: "/user/edit")}?user=${groupMemberBean.user.id}&socialGroup=${groupMemberBean.socialGroup.id}&groupMember=${groupMemberBean.id}"><i class="icon-edit"></i> <g:message code="default.button.edit.label" default="Edit"/></a></li>
							<!-- <li class="divider"></li> -->
						</ul>
					</div>
			
				</div>
										
			</td>
		</tr>
		</g:each>

	</tbody>
</table> <!-- table -->

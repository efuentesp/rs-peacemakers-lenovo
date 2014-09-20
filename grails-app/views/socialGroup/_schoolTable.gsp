<g:if test="${socialGroupList}">	
	<table class="table">
		<thead>
			<tr>
				<th><g:message code="socialGroup.name.label" default="Name"/></th>
				<th><g:message code="socialGroup.address.label" default="Address"/></th>
				<th></th>
			</tr>
		</thead>
		<tbody>
	
			<g:each in="${socialGroupList}" status="i" var="socialGroupBean">
			<tr>
				<td>
					<a href="${createLink(uri: "/socialGroup/${action}Edit")}/${fieldValue(bean: socialGroupBean, field: "id")}"><strong>${fieldValue(bean: socialGroupBean, field: "name")}</strong></a>
					<g:set var="groupCatagory" value="socialGroup.groupCategory.${socialGroupBean?.groupCategory.toString()}.label" />
					<g:set var="defaultGroupCatagory" value="${socialGroupBean?.groupCategory.toString()}" />
					<p class="muted"><g:message code="${groupCatagory}" default="${defaultGroupCatagory}"/></p>
				</td>
				<td>
					<address>
						${fieldValue(bean: socialGroupBean, field: "address.street")}<br>
						${fieldValue(bean: socialGroupBean, field: "geo.name")}, ${socialGroupBean?.geo?.parent.name}<br>
						${socialGroupBean?.geo?.parent?.parent.name}
					</address>
				</td>
				<td class="link">
	
					<div class="btn-toolbar" style="margin: 0;">
						<div class="btn-group">
							<a href="${createLink(uri: "/socialGroup/groupList")}?school=${fieldValue(bean: socialGroupBean, field: "id")}&city=${city.id}&country=${country.id}" class="btn btn-success">
								<i class="icon-book icon-white"></i>
								<g:message code="socialGroup.groupType.groups.label" default="Groups"/>
							</a>
						</div>
						<div class="btn-group">
							<button class="btn dropdown-toggle" data-toggle="dropdown"><g:message code="default.button.action.label" default="Action"/> <span class="caret"></span></button>
							<ul class="dropdown-menu">
								<li><a href="${createLink(uri: "/socialGroup/${action}Edit")}/${fieldValue(bean: socialGroupBean, field: "id")}"><i class="icon-edit"></i> <g:message code="default.button.edit.label" default="Edit"/></a></li>
								<!-- <li class="divider"></li> -->
								<li><a href="${createLink(uri: "/socialGroup/${action}Delete")}/${fieldValue(bean: socialGroupBean, field: "id")}"><i class="icon-trash"></i> <g:message code="default.button.delete.label" default="Delete"/></a></li>
							</ul>
						</div>
					</div>						
				</td>
			</tr>
			</g:each>
	
		</tbody>
	</table> <!-- table -->
</g:if>
<g:else>
	<h4><small><g:message code="groupMember.warning.emptyCity.label" default="Empty City. Press 'Add' to create Schools."/></small></h4>
</g:else>

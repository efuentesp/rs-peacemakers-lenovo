<table class="table">
	<thead>
		<tr>
			<th><g:message code="sociometricTest.sequence.label" default="Sequence"/></th>
			<th><g:message code="sociometricTest.sociometricCriteria.label" default="Sociometric Criteria"/></th>
			<th><g:message code="sociometricTest.sociometricCriteria.countVotingGroupmembers.label" default="Students with votes"/></th>
			<th><g:message code="sociometricTest.sociometricCriteria.countNonVotingGroupmembers.label" default="Students without votes"/></th>
			<th><g:message code="sociometricTest.sociometricCriteria.votingDate.label" default="Voting Date"/></th>
			<th><g:message code="sociometricTest.status.label" default="Status"/></th>
			<th></th>
		</tr>
	</thead>
	<tbody>

		<!-- TODO: Show a message when table is empty -->

		<g:each in="${sociometricTests}" var="sociometricTest">
		<tr>
			<td>${sociometricTest.sequence}</td>
			<td>
				<g:message code="${sociometricTest?.sociometricCriteria.code}" default="${sociometricTest?.sociometricCriteria.name}"/>
				<!-- <span class="badge badge-info">${sociometricTest.sociometricTestResults.size()}</span> -->
			</td>
			<td>${sociometricTest.countVotingGroupMembers()}</td>			
			<td>${sociometricTest.countGroupMembers() - sociometricTest.countVotingGroupMembers()}</td>
			<td><g:formatDate date="${sociometricTest.testBeginningDate()}" type="date" style="MEDIUM"/></td>
			<td>
				<g:if test="${sociometricTest.enabled}"><span class="label label-success"><g:message code="sociometricTest.enabled.true.label" default="Active"/></span></g:if>
				<g:else><span class="label label-important"><g:message code="sociometricTest.enabled.false.label" default="Inactive"/></span></g:else>			
			</td>

			<td class="link">
				<div class="btn-toolbar" style="margin: 0;">
					<div class="btn-group">
						<button class="btn dropdown-toggle" data-toggle="dropdown"><g:message code="default.button.action.label" default="Action"/> <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<g:if test="${sociometricTest.enabled}">
								<li><a href="${createLink(uri: "/socialGroupSociometricTest/disable")}/${sociometricTest.id}"><i class="icon-thumbs-down"></i> <g:message code="sociometricTest.button.disable.label" default="Disable Sociometric Test"/></a></li>
							</g:if>
							<g:else>
								<li><a href="${createLink(uri: "/socialGroupSociometricTest/enable")}/${sociometricTest.id}"><i class="icon-thumbs-up"></i> <g:message code="sociometricTest.button.enable.label" default="Enable Sociometric Test"/></a></li>
							</g:else>
							<g:if test="${sociometricTest.sociometricTestResults.size() == 0}">
							<li class="divider"></li>
							<li><a href="${createLink(uri: "/socialGroupSociometricTest/delete")}/${sociometricTest.id}"><i class="icon-trash"></i> <g:message code="default.button.delete.label" default="Delete"/></a></li>
							</g:if>
						</ul>
					</div>
				</div>									
			</td>
		</tr>
		</g:each>

	</tbody>
</table> <!-- table -->

<g:if test="${sociometricTestsApplied}">

	<table class="table">
		<thead>
			<tr>
				<th class="span1"><g:message code="sociometricTest.sequence.label" default="Sequence"/></th>
				<th class="span8"><g:message code="sociometricTest.sociometricCriteria.label" default="Sociometric Test"/></th>
				<th class="span2"><g:message code="sociometricTest.status.label" default="Status"/></th>
				<th></th>
			</tr>
		</thead>
		<tbody>
	
			<g:each in="${sociometricTestsApplied}" var="sociometricTestApplied">
				<tr>
					<td>${sociometricTestApplied.sociometricTest.sequence}</td>
					<td><g:message code="${sociometricTestApplied.sociometricTest.sociometricCriteria.code}" default="${sociometricTestApplied.sociometricTest.sociometricCriteria.name}"/></td>
					<td>
						<g:if test="${sociometricTestApplied.applied}"><span><g:message code="sociometricTest.applied.true.label" default="Applied"/></span></g:if>
						<g:else><span><g:message code="sociometricTest.applied.false.label" default="Not Applied"/></span></g:else>
					</td>
		
					<td class="link">
						<div class="btn-toolbar" style="margin: 0;">
							<g:if test="${!sociometricTestApplied.applied}">
							<a href="${createLink(uri: "/student/list")}/${sociometricTestApplied.sociometricTest.id}" class="btn btn-large btn-primary">
								<i class="icon-comment-alt icon-white"></i>
								<g:message code="sociometricTest.button.apply.label" default="Apply"/>
							</a>
							</g:if>
						</div>									
					</td>
				</tr>
			</g:each>
	
		</tbody>
	</table> <!-- table -->

</g:if>
<g:else>
	<h4><small><g:message code="sociometricTest.warning.notAssigned.label" default="Sociometric Test not assigned to Group member."/></small></h4>
	<br>
</g:else>

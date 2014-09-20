<g:if test="${surveysApplied}">
	<table class="table">
		<thead>
			<tr>
				<th class="span1"><g:message code="surveyAssigned.sequence.label" default="Sequence"/></th>
				<th class="span8"><g:message code="survey.label" default="Survey"/></th>
				<th class="span1"><g:message code="surveyAssigned.score.label" default="Score"/></th>
				<th class="span2"><g:message code="surveyAssigned.enabled.label" default="Status"/></th>
				<th></th>
			</tr>
		</thead>
		<tbody>
	
			<!-- TODO: Show a message when table is empty -->
	
			<g:each in="${surveysApplied}" var="surveyApplied">
			<tr>
				<td>${surveyApplied.surveyAssigned.sequence}</td>
				<td>${surveyApplied.surveyAssigned.survey.name}</td>
				<td><g:formatNumber number="${surveyApplied.score}" type="number" maxFractionDigits="0" />%</td>
				<td>
					<g:if test="${surveyApplied.applied}"><span><g:message code="surveyAssigned.applied.true.label" default="Applied"/></span></g:if>
					<g:else><span><g:message code="surveyAssigned.applied.false.label" default="Not Applied"/></span></g:else>
				</td>
	
				<td class="link">
					<div class="btn-toolbar" style="margin: 0;">
						<g:if test="${!surveyApplied.applied}">
						<a href="${createLink(uri: "/surveyAssigned/list")}/${surveyApplied.surveyAssigned.id}" class="btn btn-large btn-primary">
							<i class="icon-check icon-white"></i>
							<g:message code="surveyAssigned.button.apply.label" default="Apply"/>
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
	<h4><small><g:message code="surveyAssigned.warning.notAssigned.label" default="Sociometric Test not assigned to Group member."/></small></h4>
	<br>
</g:else>

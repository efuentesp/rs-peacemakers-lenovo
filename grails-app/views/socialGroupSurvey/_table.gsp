<table class="table">
	<thead>
		<tr>
			<th><g:message code="surveyAssigned.sequence.label" default="Sequence"/></th>
			<th><g:message code="survey.name.label" default="Survey Assigned"/></th>
			<th><g:message code="surveyAssigned.countSurveyAppliedGroupMembers.label" default="Students with Survey answered"/></th>
			<th><g:message code="surveyAssigned.countNonSurveyAppliedGroupMembers.label" default="Students without Survey answered"/></th>
			<th><g:message code="surveyAssigned.surveyAnsweredDate.label" default="Survey answerd Date"/></th>			
			<th><g:message code="surveyAssigned.enabled.label" default="Status"/></th>
			<th></th>
		</tr>
	</thead>
	<tbody>

		<!-- TODO: Show a message when table is empty -->

		<g:each in="${surveysAssigned}" var="surveyAssigned">
		<tr>
			<td>${surveyAssigned.sequence}</td>
			<td>
				${surveyAssigned?.survey.name}
				<!-- <span class="badge badge-info">${surveyAssigned?.answers.size()}</span> -->
			</td>
			<td>${surveyAssigned.countSurveyAppliedGroupMembers()}</td>			
			<td>${surveyAssigned.countGroupMembers() - surveyAssigned.countSurveyAppliedGroupMembers()}</td>
			<td><g:formatDate date="${surveyAssigned.testBeginningDate()}" type="date" style="MEDIUM"/></td>			
			<td>
				<g:if test="${surveyAssigned.enabled}"><span class="label label-success"><g:message code="surveyAssigned.enabled.true.label" default="Active"/></span></g:if>
				<g:else><span class="label label-important"><g:message code="surveyAssigned.enabled.false.label" default="Inactive"/></span></g:else>			
			</td>

			<td class="link">
				<div class="btn-toolbar" style="margin: 0;">
					<div class="btn-group">
						<button class="btn dropdown-toggle" data-toggle="dropdown"><g:message code="default.button.action.label" default="Action"/> <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<g:if test="${surveyAssigned.enabled}">
								<li><a href="${createLink(uri: "/socialGroupSurvey/disable")}/${surveyAssigned.id}"><i class="icon-thumbs-down"></i> <g:message code="sociometricTest.button.disable.label" default="Disable Sociometric Test"/></a></li>
							</g:if>
							<g:else>
								<li><a href="${createLink(uri: "/socialGroupSurvey/enable")}/${surveyAssigned.id}"><i class="icon-thumbs-up"></i> <g:message code="sociometricTest.button.enable.label" default="Enable Sociometric Test"/></a></li>
							</g:else>
							<g:if test="${surveyAssigned.answers.size() == 0}">
							<li class="divider"></li>
							<li><a href="${createLink(uri: "/socialGroupSurvey/delete")}/${surveyAssigned.id}"><i class="icon-trash"></i> <g:message code="default.button.delete.label" default="Delete"/></a></li>
							</g:if>
						</ul>
					</div>
				</div>									
			</td>
		</tr>
		</g:each>

	</tbody>
</table> <!-- table -->

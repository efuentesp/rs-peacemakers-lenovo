<table class="table">
	<thead>
		<tr>
			<th><g:message code="survey.question.answerChoice.sequence.label" default="Sequence"/></th>
			<th><g:message code="survey.question.answerChoice.description.label" default="Description"/></th>
			<th><g:message code="survey.question.answerChoice.points.label" default="Points"/></th>
			<th></th>
		</tr>
	</thead>
	<tbody>

		<!-- TODO: Show a message when table is empty -->

		<g:each in="${surveyAnswerChoices}" var="choice">
		<tr>
			<td>${choice.sequence}</td>
			<td>${choice.description}</td>
			<td>${choice.points}</td>

			<td class="link">
				<div class="btn-toolbar" style="margin: 0;">
					<div class="btn-group">
						<button class="btn dropdown-toggle" data-toggle="dropdown"><g:message code="default.button.action.label" default="Action"/> <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li><a href="${createLink(uri: "/surveyAnswerChoice/edit")}/${choice.id}"><i class="icon-edit"></i> <g:message code="default.button.edit.label" default="Edit"/></a></li>
							<!-- <li class="divider"></li> -->
							<li><a href="${createLink(uri: "/surveyAnswerChoice/delete")}/${choice.id}"><i class="icon-trash"></i> <g:message code="default.button.delete.label" default="Delete"/></a></li>
						</ul>
					</div>
				</div>									
			</td>
		</tr>
		</g:each>

	</tbody>
</table> <!-- table -->

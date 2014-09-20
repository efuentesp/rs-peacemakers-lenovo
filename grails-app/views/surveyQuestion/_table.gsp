<table class="table">
	<thead>
		<tr>
			<th><g:message code="survey.question.sequence.label" default="Sequence"/></th>
			<th><g:message code="survey.question.description.label" default="Description"/></th>
			<th><g:message code="survey.question.type.label" default="Type"/></th>
			<th></th>
		</tr>
	</thead>
	<tbody>

		<!-- TODO: Show a message when table is empty -->

		<g:each in="${surveyQuestions}" var="question">
		<tr>
			<td>${question.sequence}</td>
			<td>${question.description}</td>
			<!-- <td><g:message code="survey.question.type.${question.type}.label" default="Type"/></td> -->

			<td class="link">
				<div class="btn-toolbar" style="margin: 0;">
				<a href="${createLink(uri: "/surveyAnswerChoice/list")}/${question.id}" class="btn btn-inverse">
					<i class="icon-list-ol icon-white"></i>
					<g:message code="survey.question.answerChoice.list.header" default="Answers"/>
				</a>
				
				<div class="btn-group">
					<button class="btn dropdown-toggle" data-toggle="dropdown"><g:message code="default.button.action.label" default="Action"/> <span class="caret"></span></button>
					<ul class="dropdown-menu">
						<li><a href="${createLink(uri: "/surveyQuestion/edit")}/${question.id}"><i class="icon-edit"></i> <g:message code="default.button.edit.label" default="Edit"/></a></li>
						<!-- <li class="divider"></li> -->
						<li><a href="${createLink(uri: "/surveyQuestion/delete")}/${question.id}"><i class="icon-trash"></i> <g:message code="default.button.delete.label" default="Delete"/></a></li>
					</ul>
				</div>
				</div>									
			</td>
		</tr>
		</g:each>

	</tbody>
</table> <!-- table -->

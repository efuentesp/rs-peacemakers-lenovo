<table class="table">
	<thead>
		<tr>
			<th><g:message code="survey.name.label" default="Name"/></th>
			<th></th>
		</tr>
	</thead>
	<tbody>

		<!-- TODO: Show a message when table is empty -->

		<g:each in="${surveys}" var="survey">
		<tr>
			<td>${survey.name}</td>

			<td class="link">
				<div class="btn-toolbar" style="margin: 0;">
					<a href="${createLink(uri: "/surveyQuestion/list")}/${survey.id}" class="btn btn-inverse">
						<i class="icon-list-ol icon-white"></i>
						<g:message code="survey.question.list.header" default="Questions"/>
					</a>
					
					<div class="btn-group">
						<button class="btn dropdown-toggle" data-toggle="dropdown"><g:message code="default.button.action.label" default="Action"/> <span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li><a href="${createLink(uri: "/survey/edit")}/${survey.id}"><i class="icon-edit"></i> <g:message code="default.button.edit.label" default="Edit"/></a></li>
							<!-- <li class="divider"></li> -->
							<li><a href="${createLink(uri: "/survey/delete")}/${survey.id}"><i class="icon-trash"></i> <g:message code="default.button.delete.label" default="Delete"/></a></li>
						</ul>
					</div>
				</div>									
			</td>
		</tr>
		</g:each>

	</tbody>
</table> <!-- table -->

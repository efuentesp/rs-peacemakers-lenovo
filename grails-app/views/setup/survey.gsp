<h1>Surveys Loaded</h1>

<g:each in="${json.surveys}" var="survey">
<ul>
	<li>
		[${survey.code}] ${survey.name}
		<ul>
		<g:each in="${survey.questions}" var="question">
			<li>
				${question.sequence}. [${question.code}] ${question.description} (ID: ${question.id})
				<ul>
				<g:each in="${question.answerChoices}" var="choice">
					<li>
						${choice.sequence}.[${choice.code}] ${choice.description} (Points: ${choice.points}) (ID: ${choice.id})
					</li>
				</g:each>
				</ul>
			</li>
		</g:each>
		</ul>
	</li>
</ul>
</g:each>
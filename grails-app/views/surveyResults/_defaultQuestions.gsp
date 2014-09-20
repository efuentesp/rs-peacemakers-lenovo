				<table class="table table-condensed">	
					<caption>
						<h4><g:message code="${question.surveyAssigned.survey.name}" default="${question.surveyAssigned.survey.name}"/> </h4>
					</caption>
				
					<thead>
						<tr>
							<th>
								<g:message code="surveyResults.question" default="Question"/>
							</th>
							<th>
								<g:message code="surveyResults.groupMember.score" default="Score"/>
							</th>
						</tr>
					</thead>
					
					<tbody>
						<g:each in="${question.surveyResults}" var="${result}">
							<g:if test="${result.percentage > 60}">
								<tr>
							</g:if>
							<g:else>
								<tr class="error">
							</g:else>
								<td>${result.question.sequence}. <g:message code="${result.question.description}" default="${result.question.description}"/></td>
								<td><g:formatNumber number="${result.percentage}" type="number" maxFractionDigits="0" roundingMode="HALF_DOWN" />%</td>
							</tr>
						</g:each>
					</tbody>	
				</table>

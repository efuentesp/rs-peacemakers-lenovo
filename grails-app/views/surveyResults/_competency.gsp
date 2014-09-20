			
				<br>
				<h4><g:message code="${survey.surveyAssigned.survey.name}" default="${survey.surveyAssigned.survey.name}"/></h4>
				
				<blockquote>
					<p><g:message code="surveyResults.socialGroup.total" default="Social Group total: "/> <strong>${survey.surveyAssigned.countGroupMembers()}</strong></p>
					<p><g:message code="surveyResults.socialGroup.answered" default="Social Group total: "/> <strong>${survey.socialGroupTotalResult.size}</strong></p>
				</blockquote>
			
				<table class="table table-condensed">	
					<caption>
						<h4><g:message code="${survey.surveyAssigned.survey.name}" default="${survey.surveyAssigned.survey.name}"/> </h4>
					</caption>
				
					<thead>
						<tr>
							<th></th>
							<th>
								<g:message code="surveyResults.groupMember.name" default="Name"/>
							</th>
							<th>
								<g:message code="surveyResults.groupMember.factor1" default="Factor 1"/>
							</th>
							<th>
								<g:message code="surveyResults.groupMember.factor2" default="Factor 2"/>
							</th>
							<th>
								<g:message code="surveyResults.groupMember.factor3" default="Factor 3"/>
							</th>
							<th>
								<g:message code="surveyResults.groupMember.factor4" default="Factor 4"/>
							</th>
							<th></th>
						</tr>
					</thead>
					
					<tbody>
						<g:each in="${survey.surveyResults}" var="${result}">
							<tr>
								<td>
									<!-- <img  style="width: 50px; height: 60px;" src="${createLink(controller: 'GroupMember', action: 'renderPhoto', id: result.groupMember.id)}"/> -->
								</td>
								<td>${result.groupMember}</td>
								<td>
									<g:if test="${result.points > 0}">
										<p><g:formatNumber number="${result.competency.f1}" type="number" maxFractionDigits="0" minFractionDigits="1" roundingMode="HALF_DOWN" locale="es_mx"/></p>
									</g:if>
									<g:else>
										<p>--</p>
									</g:else>
								</td>
								<td>
									<g:if test="${result.points > 0}">
										<p><g:formatNumber number="${result.competency.f2}" type="number" maxFractionDigits="1" minFractionDigits="1" roundingMode="HALF_DOWN" locale="es_mx"/> </p>
									</g:if>
									<g:else>
										<p>--</p>
									</g:else>
								</td>
								<td>
									<g:if test="${result.points > 0}">
										<p><g:formatNumber number="${result.competency.f3}" type="number" maxFractionDigits="1" minFractionDigits="1" roundingMode="HALF_DOWN" locale="es_mx"/></p>
									</g:if>
									<g:else>
										<p>--</p>
									</g:else>
								</td>
								<td>
									<g:if test="${result.points > 0}">
										<p><g:formatNumber number="${result.competency.f4}" type="number" maxFractionDigits="1" minFractionDigits="1" roundingMode="HALF_DOWN" locale="es_mx"/></p>
									</g:if>
									<g:else>
										<p>--</p>
									</g:else>
								</td>																									
								<td>
								</td>
							</tr>
						</g:each>
					</tbody>	
				</table>
			

			
				<br>
				<h4><g:message code="${survey.surveyAssigned.survey.name}" default="${survey.surveyAssigned.survey.name}"/></h4>
				
				<blockquote>
					<p><g:message code="surveyResults.socialGroup.total" default="Social Group total: "/> <strong>${survey.surveyAssigned.countGroupMembers()}</strong></p>
					<p><g:message code="surveyResults.socialGroup.answered" default="Social Group total: "/> <strong>${survey.socialGroupTotalResult.size}</strong></p>
					<p><g:message code="surveyResults.socialGroup.percentage" default="Social Group percentage: "/> <strong><g:formatNumber number="${survey.socialGroupTotalResult.percentage}" type="number" maxFractionDigits="0" roundingMode="HALF_DOWN" />%</strong></p>
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
								<g:message code="surveyResults.groupMember.score" default="Score"/>
							</th>
							<th></th>
						</tr>
					</thead>
					
					<tbody>
						<g:each in="${survey.surveyResults}" var="${result}">
							<g:if test="${result.percentage > 60}">
								<tr>
							</g:if>
							<g:else>
								<tr class="warning">
							</g:else>
								<td>
									<g:if test="${result.percentage <= 60}">
										<img  style="width: 50px; height: 60px;" src="${createLink(controller: 'GroupMember', action: 'renderPhoto', id: result.groupMember.id)}"/>
									</g:if>
								</td>
								<td>${result.groupMember}</td>
								<td>
									<g:if test="${result.percentage > 0}">
										<g:formatNumber number="${result.percentage}" type="number" maxFractionDigits="0" roundingMode="HALF_DOWN" />%
									</g:if>
									<g:else>
										<g:message code="surveyResults.socialGroup.na" default="Not available"/>
									</g:else>
								</td>
								<td>
									<g:if test="${result.percentage <= 60}">
										<g:each in="${result.sociometricTestResults}" var="criteria">
											<div>
												<!-- ${criteria.criteria.name} -->
												<g:each in="${criteria.tests}" var="test">
													<!--  ${test.test.sequence} -->
													<ul>
													<g:each in="${test.results}" var="r">
														<li>
															<label>
																<g:message code="${r.criteriaResponse.question}" default="${r.criteriaResponse.question}"/>
															</label>
															<tb:progressBar value="${r.percentage}" color="${r.criteriaResponse.rgbHex}"></tb:progressBar>
															<br>									
														</li>
													</g:each>
													</ul>
												</g:each>
											</div>
										</g:each>
									</g:if>
								</td>
							</tr>
						</g:each>
					</tbody>	
				</table>
			

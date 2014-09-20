			
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
								<g:message code="surveyResults.groupMember.neap" default="NEAP"/>
							</th>
							<th>
								<g:message code="surveyResults.groupMember.igap" default="IGAP"/>
							</th>
							<th>
								<g:message code="surveyResults.groupMember.imap" default="IMAP"/>
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
									<g:if test="${result.bullymetric.count > 0}">
										<p><g:formatNumber number="${result.bullymetric.neap}" type="number" maxFractionDigits="0" roundingMode="HALF_DOWN" /></p>
									</g:if>
									<g:else>
										<p>--</p>
									</g:else>
								</td>
								<td>
									<g:if test="${result.bullymetric.count > 0}">
										<p><g:formatNumber number="${result.bullymetric.igap}" type="number" maxFractionDigits="1" minFractionDigits="1" roundingMode="HALF_DOWN" locale="es_mx"/> </p>
									</g:if>
									<g:else>
										<p>--</p>
									</g:else>
								</td>
								<td>
									<g:if test="${result.bullymetric.count > 0}">
										<p><g:formatNumber number="${result.bullymetric.imap}" type="number" maxFractionDigits="1" minFractionDigits="1" roundingMode="HALF_DOWN" locale="es_mx"/></p>
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
			

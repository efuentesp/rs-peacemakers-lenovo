<h1>Schools Loaded</h1>

<g:each in="${json.schools}" var="school">
<ul>
	<li>
		${school.name} [${school.groupCategory}, ${school.geo}]
		<ul>
		<g:each in="${school.groups}" var="group">
			<li>
				${group.name} (${group.stage}, ${group.period})
				<ul>
				<g:each in="${group.groupMembers}" var="groupMember">
					<li>
						(ID: ${groupMember.id}) ${groupMember.firstName} ${groupMember.firstSurname} ${groupMember.secondSurname}
						<ul>
						<g:each in="${groupMember.surveysApplied}" var="surveyApplied">
							<li>
								(${surveyApplied.sequence}) ${surveyApplied.code}
							</li>
						</g:each>
						</ul>
						
						<ul>
						<g:each in="${groupMember.sociometricTests}" var="sociometricTest">
							<li>
								(${sociometricTest.sequence}) ${sociometricTest.sociometricCriteria}
							</li>
						</g:each>
						</ul>						
					</li> 
				</g:each>
				</ul>
			</li>
		</g:each>
		</ul>
	</li>
</ul>
</g:each>
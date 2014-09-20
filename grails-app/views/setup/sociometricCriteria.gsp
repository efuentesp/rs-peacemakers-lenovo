<h1>Sociometric Criteria Loaded</h1>

<g:each in="${json.sociometricCriterias}" var="sociometricCriteria">
<ul>
	<li>
		[${sociometricCriteria.code}] ${sociometricCriteria.name}: ${sociometricCriteria.description}
		<ul>
		<g:each in="${sociometricCriteria.responses}" var="response">
			<li>
				${response.sequence}. ${response.question} [${response.color}] [${response.rgbHex}]
			</li>
		</g:each>
		</ul>
	</li>
</ul>
</g:each>
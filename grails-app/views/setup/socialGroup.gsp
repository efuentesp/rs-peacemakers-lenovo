<h1>Social Group Loaded</h1>

<br>
<h2>Stages:</h2>
<g:each in="${json.socialGroupStages}" var="stage">
<ul>
	<li>
		${stage.name}
	</li>
</ul>
</g:each>

<br>
<h2>Periods:</h2>
<g:each in="${json.socialGroupPeriods}" var="period">
<ul>
	<li>
		${period.name}
	</li>
</ul>
</g:each>
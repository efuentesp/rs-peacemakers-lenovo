<h1>Geographies Loaded</h1>
<br>
<h2>Countries</h2>
<g:each in="${json.countries}" var="country">
<ul>
	<li>
		[${country.isoCode}] ${country.name}
	</li>
</ul>
</g:each>

<br>
<h2>States</h2>
<g:each in="${json.states}" var="state">
<ul>
	<li>
		[${state.isoCode}] ${state.name} (${state.abbreviation}) => ${state.parent}
	</li>
</ul>
</g:each>

<br>
<h2>Cities</h2>
<g:each in="${json.cities}" var="city">
<ul>
	<li>
		[${city.isoCode}] ${city.name} => ${city.parent}
	</li>
</ul>
</g:each>
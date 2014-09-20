<div class="span3">

	<div class="well">

		<g:each in="${stageTree}" var="stage">
			<ul class="nav nav-list">
				<li class="nav-header">${stage.stage.name}</li>
				<g:each in="${stage.periods}" var="period">
					<li><a href="${createLink(uri: "/schoolAdmin/groupList?school=${school}&stage=${stage.stage.id}&period=${period.id}&city=${city}&country=${country}")}">${period.name}</a></li>
				</g:each>
			</ul>
		</g:each>

	</div>
	
</div> <!-- /span3 -->



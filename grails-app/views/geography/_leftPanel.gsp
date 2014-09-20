		<div class="span3">
			<div class="well">
				<ul class="nav nav-list">
					<li class="nav-header">
						<i class="icon-globe"></i>
						<g:message code="default.navbar.setup.geography" default="Geographies" />
					</li>
					<li <g:if test = "${action == 'country'}"> class="active" </g:if> >
						<a href="${createLink(uri: '/geography/countryList')}" class="list">
							<i class="icon-list icon-white"></i>
							<g:message code="geography.country.list.header" default="Countries" />
						</a>
					</li>
					<li <g:if test = "${action == 'subdivision'}"> class="active" </g:if> >
						<a href="${createLink(uri: '/geography/subdivisionList')}" class="list">
							<i class="icon-list icon-white"></i>
							<g:message code="geography.subdivision.list.header" default="Subdivisions" />
						</a>
					</li>
					<!-- 
					<li <g:if test = "${action == 'city'}"> class="active" </g:if> >
						<a href="${createLink(uri: '/geography/cityList')}" class="list">
							<i class="icon-list icon-white"></i>
							<g:message code="geography.city.list.header" default="Cities" />
						</a>
					</li>
					-->
				</ul>
			</div>
		</div> <!-- /span3 -->
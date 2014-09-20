<div class="span3">

	<div class="well">
		<ul class="nav nav-list">
			<!--  
			<li class="nav-header">
				<g:message code="socialGroup.school.list.header" default="Group Members" />
			</li>
			-->
			<g:each in="${socialGroupTree}" var="school">
				<li>
					<h4>${school.name}</h4>
					<ul>
						<g:each var="stage" in="${school.children}">
							<li>
								<h6>${stage.name}</h6>
								<ul>
									<g:each var="period" in="${stage.children}">
										<li>
											<h6>${period.name}</h6>
											<ul>
												<g:each var="group" in="${period.children}">
													<g:set var="active" value="${false}" />
													<li <g:if test = "${active}"> class="active" </g:if>>
														<a href="${createLink(uri: "/sociometricTestResults/adjacencyMatrix/${group.id}")}" class="list">
															<i class="icon-list"></i>
															${group.name}
														</a>													
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
				<br>
			</g:each>
		</ul>
	</div>
	
</div> <!-- /span3 -->
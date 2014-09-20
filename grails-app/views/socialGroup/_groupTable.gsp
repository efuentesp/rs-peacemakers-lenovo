<g:if test="${socialGroupArray}">
	<table class="table table-condensed">
		<thead>
			<tr>
				<th><g:message code="socialGroup.groupType.stage.label" default="Stage"/></th>
				<th><g:message code="socialGroup.groupType.period.label" default="Period"/></th>
				<th><g:message code="socialGroup.groupType.group.label" default="Group"/></th>
				<!-- <th><g:message code="socialGroup.groupType.group.count.label" default="No. Students"/></th>-->
				<th><i class="icon-group"></i></th>
				<th><i class="icon-comment-alt"></i></th>
				<th><i class="icon-check"></i></th>
				<th><i class="icon-retweet"></i></th>
				<th></th>
			</tr>
		</thead>
		<tbody>
	
			<g:each in="${socialGroupArray}" status="i" var="socialGroupBean">
			<tr>
				<td>
					${socialGroupBean?.socialGroup?.stage.name}
				</td>
				<td>
					${socialGroupBean?.socialGroup?.period.name}
				</td>
				<td>
					${fieldValue(bean: socialGroupBean?.socialGroup, field: "name")}
				</td>
				<td>
					<g:if test="${socialGroupBean?.socialGroup?.groupMembers.size() > 0}">
						<span class="badge badge-info">${socialGroupBean?.socialGroup?.groupMembers.size()}</span>
					</g:if>
					<g:else>
						<span class="badge">0</span>
					</g:else>
				</td>
				<td><g:if test="${socialGroupBean.cBullying > 0}"><a href="${createLink(uri: '/sociometricTestResults/matrixChart')}/${socialGroupBean?.socialGroup.id}"><i class="icon-comment-alt"></i> (${socialGroupBean.cBullying})</a></g:if></td>
				<td><g:if test="${socialGroupBean.cSurveys > 0}"><a href="${createLink(uri: '/surveyResults/list')}/${socialGroupBean?.socialGroup.id}"><i class="icon-check"></i> (${socialGroupBean.cSurveys})</a></g:if></td>
				<td><g:if test="${socialGroupBean.cSociogram > 0}"><a href="${createLink(uri: '/sociogram/list')}/${socialGroupBean?.socialGroup.id}"><i class="icon-retweet"></i> (${socialGroupBean.cSociogram})</a></g:if></td>			
				<td class="link">
	
					<div class="btn-toolbar" style="margin: 0;">
						<div class="btn-group">
							<a href="${createLink(uri: "/groupMember/list")}/${fieldValue(bean: socialGroupBean?.socialGroup, field: "id")}" class="btn btn-success btn-small">
								<i class="icon-group icon-white"></i>
								<g:message code="groupMember.list.header" default="Group Members"/>
							</a>
						</div>
						<div class="btn-group">
							<button class="btn btn-info btn-small dropdown-toggle" data-toggle="dropdown"><g:message code="default.navbar.results" default="Results"/> <span class="caret"></span></button>
							<ul class="dropdown-menu">
								<li><a href="${createLink(uri: '/sociometricTestResults/matrixChart')}/${socialGroupBean?.socialGroup.id}"><i class="icon-comment-alt"></i> <g:message code="default.navbar.results.sociometricTests" default="Sociometric Tests"/></a></li>
								<li><a href="${createLink(uri: '/surveyResults/list')}/${socialGroupBean?.socialGroup.id}"><i class="icon-check"></i> <g:message code="default.navbar.results.surveys" default="Surveys"/></a></li>
								<li><a href="${createLink(uri: '/sociogram/list')}/${socialGroupBean?.socialGroup.id}"><i class="icon-retweet"></i> <g:message code="sociometricTestResults.directedGraph.header" default="Sociogram"/></a></li>
							</ul>
						</div>
						<div class="btn-group">
							<button class="btn btn-small dropdown-toggle" data-toggle="dropdown"><g:message code="default.button.action.label" default="Action"/> <span class="caret"></span></button>
							<ul class="dropdown-menu">
								<li><a href="${createLink(uri: "/socialGroupSociometricTest/list")}/${fieldValue(bean: socialGroupBean?.socialGroup, field: "id")}"><i class="icon-comment-alt"></i> <g:message code="socialGroup.sociometricTest.button.activate.label" default="Activate Sociometric Test"/></a></li>
								<li><a href="${createLink(uri: "/socialGroupSurvey/list")}/${fieldValue(bean: socialGroupBean?.socialGroup, field: "id")}"><i class="icon-check"></i> <g:message code="socialGroup.survey.button.activate.label" default="Activate Survey"/></a></li>
								<li class="divider"></li>						
								<li><a href="${createLink(uri: "/socialGroup/${action}Edit")}/${fieldValue(bean: socialGroupBean?.socialGroup, field: "id")}"><i class="icon-edit"></i> <g:message code="default.button.edit.label" default="Edit"/></a></li>
								<!-- <li class="divider"></li> -->
								<li><a href="${createLink(uri: "/socialGroup/${action}Delete")}/${fieldValue(bean: socialGroupBean?.socialGroup, field: "id")}"><i class="icon-trash"></i> <g:message code="default.button.delete.label" default="Delete"/></a></li>
							</ul>
						</div>
					</div>						
				</td>
			</tr>
			</g:each>
	
		</tbody>
	</table> <!-- table -->
</g:if>
<g:elseif test="${stageTree}">
	<h4><small><g:message code="groupMember.warning.selectGroup.label" default="Empty Groups. Press 'Add' to create Groups."/></small></h4>
</g:elseif>
<g:else>
	<h4><small><g:message code="groupMember.warning.emptySchool.label" default="Empty Groups. Press 'Add' to create Groups."/></small></h4>
</g:else>

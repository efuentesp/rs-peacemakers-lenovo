			<table class="table">
				<thead>
					<tr>
						<th><g:message code="geography.isoCode.label" default="Code"/></th>
						<th><g:message code="geography.name.label" default="Name"/></th>
						<th></th>
					</tr>
				</thead>
				<tbody>

					<!-- TODO: Show a message when table is empty -->

					<g:each in="${geoList}" status="i" var="geoBean">
					<tr>
						<td>${fieldValue(bean: geoBean, field: "isoCode")}</td>
						<td>${fieldValue(bean: geoBean, field: "name")}</td>
						<td class="link">
							<a href="${createLink(uri: "/geography/${action}Edit")}/${fieldValue(bean: geoBean, field: "id")}" class="btn btn-success">
								<i class="icon-pencil icon-white"></i>
								<g:message code="default.button.edit.label" default="Edit"/>
							</a>
							<a href="${createLink(uri: "/geography/${action}Delete")}/${fieldValue(bean: geoBean, field: "id")}" class="btn btn-danger">
								<i class="icon-trash icon-white"></i>
								<g:message code="default.button.delete.label" default="Delete"/>
							</a>							
						</td>
					</tr>
					</g:each>

				</tbody>
			</table> <!-- table -->

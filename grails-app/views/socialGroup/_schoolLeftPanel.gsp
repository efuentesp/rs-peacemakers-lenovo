<div class="span3">

	<div class="well">
		<h5><p class="muted"><g:message code="socialGroup.search.byschool.label" default="SEARCH BY SCHOOL"/></p></h5>
		
		<g:form action="schoolList" method="post" class="form-vertical">
			<input 	type="text" class="input-large"
			name="schoolName" required="" value="" autocomplete='off'
			data-provide="typeahead" data-items="4"
			data-source='${schoolJSON}'>
			
			<div>
				<button type="submit" class="btn btn-info">
					<i class="icon-search icon-white"></i>
					<g:message code="default.button.search.label" default="Search"/>
				</button>						
			</div>				
		</g:form>	
	</div>
	
	<div class="well">
	
		<h5><p class="muted"><g:message code="socialGroup.search.bycity.label" default="SEARCH BY CITY"/></p></h5>
	
		<g:form action="schoolList" method="post" class="form-vertical">
			<fieldset>
			
				<div class="control-group">
					<label class="control-label" for="country">
						<g:message code="geography.geoType.country.label" default="Country"/>
					</label>
					<div class="controls">
						<g:select 	from="${countries}"
									id="country"
									name="country"
									class="span11"
									noSelection="['':'-- Seleccionar --']"
									optionKey="id"
									optionValue="name"
									required=""
									onchange="${ remoteFunction(
												 action: 'getCitiesByCountry',
												 update: 'city',
												 params: '\'country=\'+$(\'#country\').val()') }"/>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label" for="city">
						<g:message code="geography.geoType.city.label" default="City"/>
					</label>
					<div class="controls">
						<div id="city">
							<g:select name="city" from="" disabled="true" class="span11"/>
						</div>
					</div>
				</div>
								
			</fieldset>
			
			<div>
				<button type="submit" class="btn btn-info">
					<i class="icon-search icon-white"></i>
					<g:message code="default.button.search.label" default="Search"/>
				</button>						
			</div>			
			
		</g:form>
	</div>
	
</div> <!-- /span3 -->



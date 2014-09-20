<div id="countryCreate" class="modal hide fade">

	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal">&times;</button>
		<h3><g:message code="geography.country.create.header" default="Create Country"/></h3>
	</div>
	
	<form class="form-horizontal" action="">
		<div class="modal-body">
			<fieldset>
				<div class="control-group">
					<label class="control-label" for="isoCode"><g:message code="geography.isoCode.label" default="Code"/></label>
					<div class="controls">
						<input type="text" class="input-small" id="isoCode">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name"><g:message code="geography.name.label" default="Name"/></label>
					<div class="controls">
						<input type="text" class="input-xlarge" id="name">
						<!-- <p class="help-block">In addition to freeform text, any HTML5 text-based input appears like so.</p> -->
					</div>
				</div>
			</fieldset>
		</div>
		
		<div class="modal-footer">
			<a href="#" class="btn">Close</a>
			<a href="#" class="btn btn-primary">Save changes</a>
		</div>
	</form>
	
</div> <!-- /modal -->
<!-- Error Panel -->
<g:if test="${flash.message}">
	<div class="alert alert-block alert-info">
		<a class="close" data-dismiss="alert">&times;</a>
		${flash.message}
	</div>
</g:if>

<fieldset>
	<g:uploadForm action="geography" method="post" class="form-horizontal">
	
		<div class="control-group">
			<label class="control-label">Geographies (Countries, States and Cities):</label>
			<div class="controls">
				<input type="file" id="jsonGeoUpload" name="jsonGeoUpload" value="" required />
			</div>
		</div>
		
		<div class="form-actions">
			<button type="submit" class="btn btn-primary">
				<i class="icon-ok icon-white"></i>
				Upload
			</button>						
		</div>
		
	</g:uploadForm>
</fieldset>

<fieldset>
	<g:uploadForm action="sociometricCriteria" method="post" class="form-horizontal">
	
		<div class="control-group">
			<label class="control-label">Sociometric Criterias:</label>
			<div class="controls">
				<input type="file" id="jsonSociometricCriteriaUpload" name="jsonSociometricCriteriaUpload" value="" required />
			</div>
		</div>
		
		<div class="form-actions">
			<button type="submit" class="btn btn-primary">
				<i class="icon-ok icon-white"></i>
				Upload
			</button>						
		</div>
		
	</g:uploadForm>
</fieldset>

<fieldset>
	<g:uploadForm action="survey" method="post" class="form-horizontal">
	
		<div class="control-group">
			<label class="control-label">Survey:</label>
			<div class="controls">
				<input type="file" id="jsonSurveyUpload" name="jsonSurveyUpload" value="" required />
			</div>
		</div>
		
		<div class="form-actions">
			<button type="submit" class="btn btn-primary">
				<i class="icon-ok icon-white"></i>
				Upload
			</button>						
		</div>
		
	</g:uploadForm>
</fieldset>

<fieldset>
	<g:uploadForm action="socialGroup" method="post" class="form-horizontal">
	
		<div class="control-group">
			<label class="control-label">Social Group (Stages and Periods):</label>
			<div class="controls">
				<input type="file" id="jsonSocialGroupUpload" name="jsonSocialGroupUpload" value="" required />
			</div>
		</div>
		
		<div class="form-actions">
			<button type="submit" class="btn btn-primary">
				<i class="icon-ok icon-white"></i>
				Upload
			</button>						
		</div>
		
	</g:uploadForm>
</fieldset>

<fieldset>
	<g:uploadForm action="school" method="post" class="form-horizontal">
	
		<div class="control-group">
			<label class="control-label">School:</label>
			<div class="controls">
				<input type="file" id="jsonSchoolUpload" name="jsonSchoolUpload" value="" required />
			</div>
		</div>
		
		<div class="form-actions">
			<button type="submit" class="btn btn-primary">
				<i class="icon-ok icon-white"></i>
				Upload
			</button>						
		</div>
		
	</g:uploadForm>
</fieldset>

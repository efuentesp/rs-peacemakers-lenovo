<div>
	<g:form action="save" name="surveyForm" onkeypress="return event.keyCode != 13;">
	
		<g:hiddenField name="groupMember" value="${groupMember.id}" />
		<g:hiddenField name="surveyAssigned" value="${surveyAssigned.id}" />

		<ul  id="questions" style="list-style: none outside none;">	
		<g:each in="${surveyQuestions}" var="question">
			<li>
				<fieldset>
					<legend>
						<strong>${question.sequence}. ${question.description}</strong>
					</legend>
					<div>
						<!-- Survey Question Choices -->
						<div class="controls">
						<g:each in="${question.choices}" var="choice">
			
								<label class="radio">
									<input type="radio" name="choice.${question.id}" id="choice${choice.id}" value="${choice.id}">
									${choice.description}
								</label>
			
						</g:each>
						</div>
					</div>
				</fieldset>
				<br>
			</li>
		</g:each>
		</ul>
		
		<div class="form-actions">
			<div class="span3">
				<button id="finish" type="submit" class="btn btn-primary btn-large btn-block" disabled>
					<i class="icon-ok-sign icon-white"></i>
					<g:message code="surveyAssigned.button.finish.label" default="F I N I S H"/>
				</button>
			</div>						
		</div>
	</g:form>
	
	<script type="text/javascript">
	    $("input[type='radio']").change(function() {
	        //console.log($("input[type='radio']:checked").val());
	        //console.log($("input[type='radio']:checked"));
	        var finish = false;
	    	$.each(
	    		$("input[type='radio']:checked"),
	   			function( intIndex, obj ) {
		   			if ($("#questions li").size() == $("input[type='radio']:checked").size()) {
		   				finish = true;
		   			}
	   			}
	    	);
	    	if (finish) {
	    		$('#finish').removeAttr("disabled");
		    	//console.log("SI se puede salir");
		    } else {
		    	$('#finish').attr("disabled", "disabled");;
			    //console.log("NO se puede salir")
			}
	    });		
	</script>
		
</div>
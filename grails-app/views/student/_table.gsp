
	<g:form action="vote" name="votingForm" onkeypress="return event.keyCode != 13;">
		<fieldset>
			<g:hiddenField name="socialGroup" value="${groupMember?.socialGroup.id}" />
			<g:hiddenField name="sociometricTest" value="${sociometricTest.id}" />
			<g:hiddenField name="fromGroupMember" value="${groupMember.id}" />
		
			<ul class="vote-list">
				<g:each in="${groupMemberList}" var="groupMemberBean">
					<li>
						<div class="student-card">
							<div class="student-photo">
								<div style="position:relative; height:120px;">
								<img class="photo_big" src="${createLink(controller:'student', action:'renderPhoto', id:groupMemberBean.id)}" style="z-index:0;position:absolute;"/>
								<img class="photo_big" src="${resource(dir: 'fileupload/img', file: 'cover.gif')}" style="z-index:1;position:absolute;" />
								</div>
							</div>
							<div class="student-name">
								<h4>${groupMemberBean.getFullName()}</h4>
							</div>					
							<div id="vote${groupMemberBean.id}" class="student-vote">
								<g:if test="${sociometricTest.sociometricCriteria.code in ['bullying']}">
									<select name="voteSelected.${groupMemberBean.id}">
										<option value="-1"></option>
										<g:each in="${sociometricCriteriaResponseList}" var="sociometricCriteriaResponse">
											<optgroup label="${message(code: sociometricCriteriaResponse.question, default: sociometricCriteriaResponse.question)}">
												<g:each in="${sociometricCriteriaResponse.option.sort {it.sequence}}" var="sociometricCriteriaResponseOption">
													<option value="${sociometricCriteriaResponse.id}|${sociometricCriteriaResponseOption.id}">${sociometricCriteriaResponseOption.question}</option>
												</g:each>
											</optgroup>
										</g:each>
									</select>
								</g:if>
								<g:else>
									<g:each in="${sociometricCriteriaResponseList}" var="sociometricCriteriaResponse">
										<label>
											<input type="radio" name="vote.${groupMemberBean.id}" id="sociometricCriteriaResponse${sociometricCriteriaResponse.sequence}" value="${sociometricCriteriaResponse.id}">
											<g:message code="${sociometricCriteriaResponse.question}" default="${sociometricCriteriaResponse.question}"/>
										</label>								
									</g:each>
									<a id="reset" class="btn btn-warning btn-mini" onclick="reset(${groupMemberBean.id})">
										<i class="icon-remove icon-white"></i>
										<g:message code="sociometriccriteria.button.reset.label" default="Reset"/>
									</a>
								</g:else>													
							</div>
						</div>
					</li>
				</g:each>
			</ul>
		</fieldset>
		
		<div class="form-actions">
			<div class="span3">
				<button id="finish" type="submit" class="btn btn-primary btn-large btn-block" disabled>
					<i class="icon-ok-sign icon-white"></i>
					<g:message code="sociometriccriteria.button.finish.label" default="V O T E"/>
				</button>
			</div>						
		</div>
	</g:form>
	
	<script type="text/javascript">
	    $("input[type='radio']").change(function() {
			finish();
			//alert(this);
	    });
	    $("select").change(function() {
	    	selectFinish(this);
		});

		function selectFinish(obj) {
			var total = 0, notSelected = 0, selected = 0;
			console.log(obj.value);
			$('select > option').each(function() {
				total++;
			    //console.log($(this).text() + ' ' + $(this).val());
			});
			$('select  > option:selected').each(function() {
				notSelected++;
			    //console.log($(this).text() + ' ' + $(this).val());
			});
			selected = total - notSelected;

	    	if (selected > 0) {
	    		$('#finish').removeAttr("disabled");
		    	//console.log("SI se puede salir");
		    } else {
		    	$('#finish').attr("disabled", "disabled");;
			    //console.log("NO se puede salir")
			}			
			//alert(obj.value+" / "+countSelected);
		}

		function finish() {
	        //console.log($("input[type='radio']:checked").val());
	        //console.log($("input[type='radio']:checked"));
	        //console.log($('#criteria').val());
	        if ($('#criteria').val() == 'classmate_want' || $('#criteria').val() == 'classmate_guess') {
		        console.log("CLASSMATE");
		        //var yes = 0, no = 0;
		        var i = 0;
		    	$.each(
		    		$("input[type='radio']:checked"),
		   			function( intIndex, obj ) {
		    			console.log(obj);
		    			/*
			   			if (obj.value == 1) {
				   			yes++;
			   			}
			   			if (obj.value == 2) {
				   			no++;
				   		}
				   		*/
			   			if (obj.value > 0) {
				   			i++;
			   			}
		   			}
		    	);
		    	/*
		    	if (yes == 3 && no == 3) {
		    		$('#finish').removeAttr("disabled");
			    	console.log("SI se puede salir");
			    } else {
			    	$('#finish').attr("disabled", "disabled");;
				    console.log("NO se puede salir, " + yes + ", " + no);
				}
				*/
		    	if (i == 6) {
		    		$('#finish').removeAttr("disabled");
			    	console.log("SI se puede salir, " + i);
			    } else {
			    	$('#finish').attr("disabled", "disabled");;
				    console.log("NO se puede salir, " + i);
				}				
		    } else {
			    console.log("PEACEMAKER");
		        var i = 0;
		    	$.each(
		    		$("input[type='radio']:checked"),
		   			function( intIndex, obj ) {
		    			//console.log(obj);
			   			if (obj.value > 0) {
				   			i++;
			   			}
		   			}
		    	);
		    	
		    	if (i > 0) {
		    		$('#finish').removeAttr("disabled");
			    	//console.log("SI se puede salir");
			    } else {
			    	$('#finish').attr("disabled", "disabled");;
				    //console.log("NO se puede salir")
				}
		    }			
		}
	    
	    function reset(c) {
		    //alert("Reset!" + c);
		    $('#vote' + c + ' input[type="radio"]:checked').attr('checked', false);
		    finish();
		}
	    // $('#vote1 input[type="radio"]:checked').attr('checked', false);
	</script>


	<g:form action="vote" name="votingForm" onkeypress="return event.keyCode != 13;">
		<fieldset>
			<g:hiddenField name="socialGroup" value="${groupMember?.socialGroup.id}" />
			<g:hiddenField name="sociometricTest" value="${sociometricTest.id}" />
			<g:hiddenField name="fromGroupMember" value="${groupMember.id}" />
		
			<input type="text" value="" id="trace"/>
			<div><label id="fullMemberName"></label></div>
		
			<div id="like1rst" class="image-dropdown">
				<g:each in="${groupMemberList}" var="groupMemberBean">
					<input type="radio" id="line${groupMemberBean.id}" name="line-style" value="${groupMemberBean.id}" />
					<label for="line${groupMemberBean.id}">
						<img for="line${groupMemberBean.id}" src="${createLink(controller:'student', action:'renderPhoto', id:groupMemberBean.id)}"/>
						<label class="memberName" style="display: none;">${groupMemberBean.getFullName()}</label>
					</label>
				</g:each>
			</div>
			
			<div id="like2nd" class="image-dropdown">
				<g:each in="${groupMemberList}" var="groupMemberBean">
					<input type="radio" id="line${groupMemberBean.id}" name="line-style" value="${groupMemberBean.id}" />
					<label for="line${groupMemberBean.id}">
						<img for="line${groupMemberBean.id}" src="${createLink(controller:'student', action:'renderPhoto', id:groupMemberBean.id)}"/>
						<label class="memberName" style="display: none;">${groupMemberBean.getFullName()}</label>
					</label>
				</g:each>
			</div>			
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

		/*	
		var i = setInterval(function() {
			$("#trace").val($("input[name=line-style]:checked").val());
		}, 100); */

		$('#like1rst label').hover(function(){
			console.log($(this).find(".memberName").text());
			$("#fullMemberName").text($(this).find(".memberName").text());
		});
	
	    $("input[type='radio']").change(function() {
			finish();
			//alert(this);
	    });

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

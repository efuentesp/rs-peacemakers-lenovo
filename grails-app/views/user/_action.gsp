 <a class="btn btn-info" onclick="openNewWindow();">
 	<i class="icon-print"></i> <g:message code="default.button.printpreview.label" default="Print Preview"/>
 </a>

 <g:hiddenField name="socialGroup" value="${socialGroupSelected.id}" />

 <script language="JavaScript">
	 <!-- hide
	 function openNewWindow() {
		//popupWin = window.open('/cf-peacemakers/user/usersListToPrint/' + $('#socialGroup').val(), //Desarrollo
		//popupWin = window.open('/user/usersListToPrint/' + $('#socialGroup').val(), //Producción
		popupWin = window.open($('#restURI').val(),
		'open_window',
		'menubar, width=640, height=480, left=0, top=0')
	 }
	 // done hiding -->
 </script>
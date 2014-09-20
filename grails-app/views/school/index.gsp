<!doctype html>
<html lang="es">
	<head>
		<meta name="layout" content="simple"/>
		<title><g:message code="default.brand.name" default="The Peacemaker Program 2.0"/></title>
	</head>
	<body>
	
		<g:hiddenField id= "restURI" name="restURI" value="${restURI}" />
	
		<div id="start" class="">
			<h1>
				<img src="${resource(dir: 'images', file: 'logo_program.png')}" alt="The Peacemaker Program" width="200" height="200"/>
				<g:message code="default.brand.name" default="The Peacemaker Program 2.0"/>
			</h1>
		</div>
	
		<div class="row">

			<!-- 
			<div class="span4">
				<div class="well">
					<div class="equalheight" style="height: 125px;">
						<h3>
							<i class="icon-cog"></i>
							<g:message code="home.admin.label" default="System Administrator"/>
						</h3>
						<p>
							<g:message code="home.admin.text" default="System Administrator access only."/>
							<br>
						</p>
						<br>
					</div>
					<p style="text-align: center;">
						<a class="scroll btn btn-primary btn-large" href="${createLink(uri: "/socialGroup")}"><g:message code="home.button.label" default="Login"/></a>
					</p>
				</div>
			</div>
			-->

			<div class="span4">
				<div class="well">
					<div class="equalheight" style="height: 125px;">
						<h3>
							<i class="icon-bell"></i>
							<g:message code="home.school.admin.label" default="School Administrator"/>
						</h3>
						<p>
							<g:message code="home.school.admin.text" default="School Administrator access only."/>
							<br>
						</p>
						<br>
					</div>
					<p style="text-align: center;">
						<a class="scroll btn btn-primary btn-large" href="${createLink(uri: "/schoolAdmin")}"><g:message code="home.button.label" default="Login"/></a>
					</p>
				</div>
			</div>
			
			<div class="span8">
			<div class="span8">
				<div class="well">
				<p>
<small>
<strong>AVISO DE PRIVACIDAD DE “CONTRA EL BULLYING” A.C.</strong>
<br><br>
Con fundamento en los artículos 15 y 16 de la Ley Federal de Protección de Datos Personales en Posesión de los Particulares hacemos de su conocimiento que la ASOCIACIÓN CIVIL “CONTRA EL BULLYING.”, con domicilio en CALLE ROSAS NO. 9 COL. SAN ANGEL INN, DELEGACIÓN ÁLVARO OBREGÓN, MÉXICO DISTRITO FEDERAL, C.P. 01060, al recabar sus datos personales a través de la solicitud de inscripción de datos o por el dominio de internet <a href="http://www.contraelbullying.org">www.contraelbullying.org</a> , es responsable del uso que se dé a los mismos y de su protección.
<br><br>
La ASOCIACIÓN CIVIL “CONTRA EL BULLYING.”, está obligada en todo momento en términos de lo establecido por el Instituto Federal de Acceso a la Información y Protección de Datos (IFAI), a garantizar las condiciones y requisitos mínimos para la debida administración y custodia de los datos personales que se encuentren bajo su resguardo, con el objeto de garantizar a las personas el derecho de decidir sobre su uso y destino.
<br><br> 
Al proporcionar sus datos a través de solicitudes por escrito o por el dominio de internet <a href="http://www.contraelbullying.org">www.contraelbullying.org</a>, usted da su consentimiento para que el uso exclusivo de nuestra parte, sea orientado hacia las diversas:
Formas de identificación, fines estadísticos, contactarlos vía correo electrónico para mantenerlos informados sobre noticias de interés para nuestra organización CONTRA EL BULLYING AC., notificarles sobre conferencias, seminarios y para tratar asuntos relacionados con la vida escolar de los alumnos de los Colegios e Instituciones Educativas con quienes coadyuvamos en la prevención del Bullying, recordatorios de carácter administrativo, informarles sobre estudios, programas y/o conferencias que son parte del programa de calidad de nuestros servicios y en general para dar cumplimiento a las obligaciones contractuales mutuamente contraídas.
<br><br>
Asimismo, la ASOCIACIÓN CIVIL “CONTRA EL BULLYING”, deberá asegurar el adecuado tratamiento de dichos datos personales con la finalidad de impedir su transmisión ilícita y lesiva a la dignidad e intimidad del afectado.
Para las finalidades antes descritas, requerimos obtener sus Datos Personales y de su Familia, los cuales constituyen el conjunto ordenado de datos en posesión la ASOCIACIÓN CIVIL “CONTRA EL BULLYING”, con independencia de su forma de acceso, creación, almacenamiento u organización como siguen:
<br><br>
Nombre completo, RFC y/o CURP, Fecha de nacimiento, Lugar de nacimiento, Dirección particular, número de hijos, Teléfono fijo, Escuela de procedencia, Tipo de sangre, Estado Civil, Correo electrónico, Empresa en la que trabaja, así como domicilio y teléfono, Ocupación y puesto que desempeña, Nivel de escolaridad, nombre y teléfono contacto para avisar en caso de emergencia, autorización de pagos vía electrónica, Firma autógrafa.
<br><br>
Los padecimientos de Salud, son considerados como sensible de acuerdo con lo que establece la Ley en comento.
<br><br>
En el tratamiento de datos personales, se observarán los principios de licitud, calidad, información, seguridad y consentimiento. Además de ser exactos, adecuados, pertinentes y no excesivos para los fines que son recabados.
Usted puede en todo momento revocar su consentimiento tácito o expreso para el tratamiento de sus datos personales, así como confirmar y/o ratificar expresamente su consentimiento de uso de sus datos personales, para cuyos efectos, será necesario que envíe la solicitud en los términos del artículo 29 de la mencionada Ley, con atención a la C. MARIANA GONZÁLEZ MENDIOLA, responsable de la Asociación CIVIL “CONTRA EL BULLYING”, en la recolección y protección de sus datos personales a través del correo electrónico <a href="mailto:contacto@contraelbullying.org">contacto@contraelbullying.org</a>
</small>				
				</p>
				</div>
			</div>
			</div>	
			
			<!--
			<div class="span4">
				<div class="well">
					<div class="equalheight" style="height: 125px;">
						<h3>
							<i class="icon-star"></i>
							<g:message code="home.student.label" default="Student"/>
						</h3>
						<p>
							<g:message code="home.student.text" default="Student access only."/>
							<br>
						</p>
						<br>
					</div>
					<p style="text-align: center;">
						<a class="scroll btn btn-primary btn-large" href="${createLink(uri: "/student")}"><g:message code="home.button.label" default="Login"/></a>
					</p>
				</div>
				
			</div>
			-->					
		</div>

	</body>
</html>

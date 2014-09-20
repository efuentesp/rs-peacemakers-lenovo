package peacemakerprogram

class BootstrapTagLib {

	static namespace = "tb"
	
	def controlGroup = { attrs, body -> 
		out << "<div class=\"control-group " << attrs['error'] << "\">"
		out << "<label class=\"control-label\" for=\"" << attrs['name'] << "\">"
		out << attrs['labelMessage']
		out << "</label>"
		out << "<div class=\"controls\">"
		out << body()
		out << "<span class=\"help-inline\">"
		out << attrs['errors']
		out << "</span>"
		out << "</div>"
		out << "</div>"
	}
	
	def progressBar = { attrs, body ->
		def color = attrs['color']
		def width = 130
		Double percentage = attrs['value']
		def percentageStr = percentage.round(1)
		def fill = (width * percentage) / 100
		def unfill = 100 - fill
		out << "<div style='width:${width}px; clear:both; padding-bootom:10px; padding-left:5px;'>"
		out << "<div style='width:${fill}px; height:18px; background-color:${color}; float:left; text-align:center; color:#ffffff;'>${percentageStr}%</div>"
		out << "<div style='width:${unfill}px; height:18px; background-color:#E2E2E2; float:left;'></div>"
		out << "</div>"
	}
	
}

package com.peacemakers.domain

class SurveyResultDescription {

	String code
	Long minVal
	Long maxVal
	String shortDescription
	String description
	
    static constraints = {
		maxVal(nullable: true)
    }
}

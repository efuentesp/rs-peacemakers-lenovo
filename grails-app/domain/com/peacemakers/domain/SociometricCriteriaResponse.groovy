package com.peacemakers.domain

class SociometricCriteriaResponse {
	
	static hasMany = [option: SociometricCriteriaResponseOption]
	
	Integer sequence
	String question
	String color
	String rgbHex

    static constraints = {
		sequence (nullable: false)
		question (blank: false, unique: true, matches: "[a-z_]+")
		color (nullable: false, matches: "[a-z_]+")
		rgbHex (nullable: false)
    }
	
	static mapping = {
		sort sequence: "desc"
	}
}

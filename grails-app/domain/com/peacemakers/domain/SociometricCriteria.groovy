package com.peacemakers.domain

class SociometricCriteria {
	
	static hasMany = [sociometricCriteriaResponses:SociometricCriteriaResponse]

	String code
	String name
	String description
	List sociometricCriteriaResponses

    static constraints = {
		code (blank:false, unique:true, matches:"[a-z_]+")
		name (blank:false)
		description (blank:true)
		sociometricCriteriaResponses(nullable:false)
    }
}

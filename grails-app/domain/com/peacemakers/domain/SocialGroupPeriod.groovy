package com.peacemakers.domain

class SocialGroupPeriod {

	String name
	
    static constraints = {
		name(nullable: false, unique: true)
    }
}

package com.peacemakers.domain

class Address {

	String street
	//Geography geo
	
    static constraints = {
		street (blank:false)
		//geo (nullable:false)
    }
}

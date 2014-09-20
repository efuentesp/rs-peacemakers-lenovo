package com.peacemakers.domain

private enum GenderType {
	MALE ('Masculino'),
	FEMALE ('Femenino')
	
	//final static String id
	String name
	
	GenderType(String name) {
		this.name = name
	}
}

class Person {
	String nationalIdNumber
	String firstName
	String firstSurname
	String secondSurname
	GenderType gender
	Date birthday

    static constraints = {
		nationalIdNumber (nullable:true)
		firstName (blank:false)
		firstSurname (blank:false)
		secondSurname (blank:true, nullable:true)
		gender (nullable:true)
		birthday (nullable:true)
    }
	
	static mapping = {
		sort firstSurname: "desc"
	}
}

package com.peacemakers.domain

private enum ContactType {
	EMAIL ('EMAIL'),
	FACEBOOK ('FACEBOOK'),
	TWITTER ('TWITTER')
	
	//final static String id
	String name
	
	ContactType(String name) {
		this.name = name
	}
}

class ElectronicContactMech {
	
	String contact

    static constraints = {
		contact (nullable: false)
    }
}

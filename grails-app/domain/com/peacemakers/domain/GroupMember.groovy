package com.peacemakers.domain

import com.peacemakers.security.User;

class GroupMember {
	
	static belongsTo = [socialGroup:SocialGroup, person:Person]

	//SocialGroup socialGroup
	Person person
	byte[] photo
	String photoType = 'image/jpg'
	User user
	Long externalId
	
    static constraints = {
		// Only active Group Members have a User, and this User is associated to only one Group Member
		user (nullable: true, unique: true)
		//socialGroup (nullable: false)
		person (nullable: false)
		photo (nullable: false, maxSize: 35840)
		photoType (blank: false)
		externalId(nullable: true)
    }
	
	static mapping = {
		person sort: 'firstSurname', order: 'desc'
	}
	
	String toString() {
		return getFullName()
	}
	
	String getFullNameSurnameFirst() {
		String fullname = person.firstSurname
		if (person.secondSurname) {
			fullname += " " + person.secondSurname
		}
		fullname += ', '
		fullname += person.firstName
		
		return fullname
	}
	
	String getFullName() {
		String fullname
		fullname = person.firstName + " "
		fullname += person.firstSurname
		if (person.secondSurname) {
			fullname += " " + person.secondSurname
		}
		
		return fullname
	}
}

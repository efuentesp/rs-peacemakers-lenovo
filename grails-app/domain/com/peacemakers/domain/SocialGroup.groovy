package com.peacemakers.domain

import com.peacemakers.security.User;

private enum SocialGroupType {
	SCHOOL ('SCHOOL'),
	//STAGE ('STAGE'),
	//PERIOD ('PERIOD'),
	GROUP ('GROUP')
	
	//final static String id
	String name
	
	SocialGroupType(String name) {
		this.name = name
	}
}

private enum SocialGroupCategory {
	PUBLIC ('PUBLIC'),
	PRIVATE ('PRIVATE')
	
	//final static String id
	String name
	
	SocialGroupCategory(String name) {
		this.name = name
	}
}

class SocialGroup {

	static belongsTo = [parent:SocialGroup, geo:Geography]
	static hasMany = [groupMembers: GroupMember]
	static embedded = ['address']
	
	String name
	SocialGroup parent
	SocialGroupType groupType
	SocialGroupCategory groupCategory 
	SocialGroupStage stage
	SocialGroupPeriod period
	Address address
	Geography geo
	List groupMembers
	String lang = 'es'
	User admin
	User assistant
	
    static constraints = {
		name (blank: false)
		parent (nullable: true)
		groupType (nullable: false)
		groupCategory(nullable: true)
		stage(nullable: true)
		period(nullable: true)
		address (nullable: true)
		geo (nullable: true)
		groupMembers(nullable: true)
		admin(nullable: true)
		assistant(nullable: true)
    }
}

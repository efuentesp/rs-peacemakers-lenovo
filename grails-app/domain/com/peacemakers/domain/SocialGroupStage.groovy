package com.peacemakers.domain

class SocialGroupStage {
	
	String name

    static constraints = {
		name(nullable: false, unique: true)
    }
}

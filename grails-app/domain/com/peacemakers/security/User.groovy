package com.peacemakers.security

class User {
    String username
    String passwordHash
	String unencode
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired
	String lang = "es"
    
    static hasMany = [ roles: Role, permissions: String ]

    static constraints = {
        username(nullable: false, blank: false, unique: true)
		unencode nullable: true
    }
}

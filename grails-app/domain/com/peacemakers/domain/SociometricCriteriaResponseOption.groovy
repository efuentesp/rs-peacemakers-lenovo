package com.peacemakers.domain

class SociometricCriteriaResponseOption {

	static belongsTo = [response: SociometricCriteriaResponse]
	
	Integer sequence
	String question

  static constraints = {
		sequence (nullable: false)
		question (blank: false, unique: true, matches: "[a-z_]+")
  }
	
	static mapping = {
		sort sequence: "desc"
	}
	
	String toString() {
		return "${question}" // Description used to display question name in kardex in sociometric diagram
	} 

}

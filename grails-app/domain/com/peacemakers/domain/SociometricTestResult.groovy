package com.peacemakers.domain

class SociometricTestResult {

	static belongsTo = [socialGroup:SocialGroup, sociometricTest:SociometricTest, fromGroupMember:GroupMember, toGroupMember:GroupMember, sociometricCriteriaResponse:SociometricCriteriaResponse, sociometricCriteriaResponseOption:SociometricCriteriaResponseOption]
	
	SocialGroup socialGroup
	//SociometricTest sociometricTest
	Date testDate
	GroupMember fromGroupMember
	GroupMember toGroupMember
	SociometricCriteriaResponse sociometricCriteriaResponse
	SociometricCriteriaResponseOption sociometricCriteriaResponseOption
	
    static constraints = {
		socialGroup (nullable:false)
		//sociometricTest (nullable:false)
		testDate (nullable:false)
		fromGroupMember (nullable:false)
		toGroupMember (nullable:false)
		sociometricCriteriaResponse (nullable: false)
		sociometricCriteriaResponseOption (nullable: true)
    }
}

package com.peacemakers.domain

class SociometricTest {
	
	static belogsTo = [socialGroup: SocialGroup, sociometricCriteria: SociometricCriteria]
	static hasMany = [sociometricTestResults: SociometricTestResult]

	Integer sequence
	SocialGroup socialGroup
	SociometricCriteria sociometricCriteria
	List sociometricTestResults
	Boolean enabled = true
	Boolean resultOption = false
	
    static constraints = {
		sequence (nullable: false)
		socialGroup (nullable: false)
		sociometricCriteria (nullable: false)
		sociometricTestResults(nullable: true)
    }
	
	def countVotingGroupMembers() {
		def c = SociometricTestResult.createCriteria() 
		def resultsCount = c.get {
		    projections {
				eq("sociometricTest", this)
		        countDistinct "fromGroupMember"
		    }
		}
		return resultsCount
	}
	
	def countGroupMembers() {
		def c = GroupMember.createCriteria()
		def resultsCount = c.get {
			projections {
				eq("socialGroup", this.socialGroup)
				countDistinct "id"
			}
		}
		return resultsCount
	}
	
	def testBeginningDate() {
		def c = SociometricTestResult.createCriteria() 
		def minDate = c.get {
		    projections {
				eq("sociometricTest", this)
		        min "testDate"
		    }
		}
		return minDate
	}
}

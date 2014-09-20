package com.peacemakers.domain

class SurveyAssigned {
	
	static hasMany = [answers: SurveyAnswer]
	
	Integer sequence
	SocialGroup socialGroup
	Survey survey
	Boolean enabled = true

    static constraints = {
    }
	
	def countSurveyAppliedGroupMembers() {
		def c = SurveyAnswer.createCriteria()
		def resultsCount = c.get {
			projections {
				eq("surveyApplied", this)
				countDistinct "groupMember"
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
		def c = SurveyAnswer.createCriteria()
		def minDate = c.get {
			projections {
				eq("surveyApplied", this)
				min "dateAnswered"
			}
		}
		return minDate
	}
}

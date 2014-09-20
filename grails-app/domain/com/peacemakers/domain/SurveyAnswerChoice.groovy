package com.peacemakers.domain

class SurveyAnswerChoice {
	
	static belongsTo = [question: SurveyQuestion]
	
	Integer sequence
	//String code
	String description
	Integer points = 0
	Long externalId

    static constraints = {
		//code(unique: true)
		externalId(nullable: true)
    }
	
	static mapping = {
		sort "sequence"
	}
	
	static Integer getNextSequence(long surveyQuestionId) {
		def last = find 'from SurveyAnswerChoice where question.id=:surveyQuestionId order by sequence desc', [surveyQuestionId: surveyQuestionId]
		if (last) {
			return last.sequence + 1
		} else {
			return 1
		}
	}
}

package com.peacemakers.domain

class SurveyAnswer {
	
	static belongsTo = [surveyApplied: SurveyAssigned]
	
	GroupMember groupMember
	SurveyQuestion question
	SurveyAnswerChoice choiceSelected
	Date dateAnswered

    static constraints = {
    }
}

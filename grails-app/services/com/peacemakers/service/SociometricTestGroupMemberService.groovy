package com.peacemakers.service

import com.peacemakers.domain.GroupMember;
import com.peacemakers.domain.SociometricTest;
import com.peacemakers.domain.SociometricTestResult;
import com.peacemakers.domain.SurveyAnswer;
import com.peacemakers.domain.SurveyAnswerChoice;
import com.peacemakers.domain.SurveyAssigned;

class SociometricTestGroupMemberService {

    def isSociometricTestTaken(SociometricTest sociometricTest, GroupMember groupMember) {
		
		def sociometricTestId = sociometricTest.id
		def groupMemberId = groupMember.id
		
		def query = SociometricTestResult.where {
			fromGroupMember.id == groupMemberId && sociometricTest.id == sociometricTestId 
		}
		
		def result = query.list()
		
		return (result) ? true : false
    }
	
	def isSurveyTaken(SurveyAssigned surveyAssigned, GroupMember groupMember) {
		
		def groupMemberBean = groupMember
		
		def query = SurveyAnswer.where {
			surveyApplied == surveyAssigned && groupMember == groupMemberBean
		}
		
		def result = query.list()
		
		return (result) ? true : false
		
	}
	
	def score(SurveyAssigned surveyAssigned, GroupMember groupMember) {
		
		def groupMemberBean = groupMember
		
		def query = SurveyAnswer.where {
			surveyApplied == surveyAssigned && groupMember == groupMemberBean
		}
		
		def result = query.list()
		
		def total = 0
		def score = 0
		result.each { answer ->
			score += answer.choiceSelected.points
			def choices = SurveyAnswerChoice.findAllByQuestion(answer.question)
			choices.each{ choice ->
				total += choice.points
			}
		}
		
		score = total > 0 ? score = (score * 100) / total : 0
		
		return score
	}
}

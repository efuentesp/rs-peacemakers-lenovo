package com.peacemakers.controller

import org.apache.shiro.SecurityUtils;

import com.peacemakers.domain.GroupMember;
import com.peacemakers.domain.SurveyAnswer;
import com.peacemakers.domain.SurveyAnswerChoice;
import com.peacemakers.domain.SurveyAssigned;
import com.peacemakers.domain.SurveyQuestion;
import com.peacemakers.domain.SurveyResultDescription;
import com.peacemakers.security.User;

class SurveyAssignedController {
	def SurveyService

    def index() {
		redirect(action: "list", params: params)
	}
	
	def list() {
		println "list: ${params}"
		
		// Get User signed
		def subject = SecurityUtils.subject
		def userSigned = User.findByUsername( subject.principal )
		
		// Find User's Group Member
		def userSignedId = userSigned.id
		def userGroupMember = GroupMember.find {
			user.id == userSignedId
		}
		
		def surveyAssigned = SurveyAssigned.get(params.id)
		
		def surveyQuestions = SurveyQuestion.findAllBySurvey(surveyAssigned.survey)
		
		[	
			user: userSigned,
			groupMember: userGroupMember,
			surveyAssigned: surveyAssigned,
			surveyQuestions: surveyQuestions
		]
	}
	
	def save() {
		println "save: ${params}"
		
		def groupMember = GroupMember.get(params.groupMember)
		def surveyAssigned = SurveyAssigned.get(params.surveyAssigned)
		//surveyAssigned.lock()
		
		// To avoid duplicate survey answers
		def answered = SurveyAnswer.findAllBySurveyAppliedAndGroupMember(surveyAssigned, groupMember)
		//println answered.size()
		if (answered.size() > 0) {
			redirect(controller: "student", action: "main")
			return
		}
		
		def answers = params.choice
		answers.each { question, answer->
			def surveyQuestion = SurveyQuestion.get(question)
			def surveyAnswerChoice = SurveyAnswerChoice.get(answer)
			try {
				//surveyAssigned.addToAnswers(groupMember: groupMember, question: surveyQuestion, choiceSelected: surveyAnswerChoice, dateAnswered: new Date()).save(failOnError: true)
				def surveyAnswer = new SurveyAnswer(surveyApplied: surveyAssigned, groupMember: groupMember, question: surveyQuestion, choiceSelected: surveyAnswerChoice, dateAnswered: new Date()).save(flush: true)
			} catch (org.springframework.dao.OptimisticLockingFailureException e) {
				println "OptimisticLockingFailureException: ${groupMember} ,${surveyQuestion}, ${surveyAnswerChoice}, ${new Date()}"
			}
		}
		
		//println "**--> ${surveyAssigned.survey.id}"
		if (surveyAssigned.survey.id == 8.toLong()) {
			redirect(action: "computeResults", params: params)
		} else {
			redirect(controller: "student", action: "main")
		}
	}
	
	def computeResults() {
		//println "computeResults: ${params}"
		def surveyAssignedId = params.surveyAssigned
		def groupMemberId = params.groupMember
		//println "computeResults: ${surveyAssignedId} ${groupMemberId}"
		def surveyTotal = SurveyService.computeCuentaConmigoResults(surveyAssignedId, groupMemberId)
		//println surveyTotal
		
		redirect(action: "results", params: [sumCongruencia: surveyTotal.sumCongruencia, sumEmpatia: surveyTotal.sumEmpatia, sumAPI: surveyTotal.sumAPI, descriptionCongruencia: surveyTotal.descriptionCongruencia, descriptionEmpatia: surveyTotal.descriptionEmpatia, descriptionAPI: surveyTotal.descriptionAPI])
	}
	
	def results() {
		println "results(): ${params}"
	}
}

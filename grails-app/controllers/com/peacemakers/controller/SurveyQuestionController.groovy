package com.peacemakers.controller

import org.apache.shiro.SecurityUtils;
import org.springframework.dao.DataIntegrityViolationException;

import com.peacemakers.domain.QuestionType;
import com.peacemakers.domain.Survey;
import com.peacemakers.domain.SurveyQuestion;
import com.peacemakers.security.User;

class SurveyQuestionController {

    def index() {
		redirect(action: "list", params: params)
	}
	
	def list() {
		println "list: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def survey = Survey.get(params.id)
		
		def surveyQuestions = SurveyQuestion.findAllBySurvey(survey)
		
		[survey: survey, surveyQuestions: surveyQuestions, user: user]
	}
	
	def create() {
		println "create: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def survey = Survey.get(params.id)
		
		[survey: survey, user: user]
	}
	
	def edit() {
		println "edit: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def surveyQuestion = SurveyQuestion.get(params.id)
		
		[surveyQuestion: surveyQuestion, user: user]
	}

	def delete() {
		println "delete: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def surveyQuestion = SurveyQuestion.get(params.id)
		
		[surveyQuestion: surveyQuestion, user: user]
	}
		
	def save() {
		println "save: ${params}"
		
		def survey = Survey.get(params.survey)

		def type
		switch (params.type) {
			case 'MULTI_CHOICE':
				type = QuestionType.MULTI_CHOICE
				break
			case 'MULTIPLE_CORRECT':
				type = QuestionType.MULTIPLE_CORRECT
				break
			default:
				type = null
		}
		
		// Get last question
		def sequence =  SurveyQuestion.getNextSequence(params.survey.toLong())
		
		//def surveyQuestion = new SurveyQuestion(sequence: params.sequence, code: params.code, description: params.description, type: type)
		def surveyQuestion = new SurveyQuestion(sequence: sequence, description: params.description, type: type)
		if (!survey.addToQuestions(surveyQuestion).save(flush: true)) {
			render(view: "create", model: [survey: survey])
			return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'survey.question.label', default: 'Survey Question'), survey.id])
		redirect(action: "list", params: [id: params.survey])
	}
	
	def update() {
		println "update: ${params}"
		
		def surveyQuestion = SurveyQuestion.get(params.id.toLong())
		if (!surveyQuestion) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'surveyQuestion.label', default: 'Survey Question'), params.id])
			redirect(action: "list")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (surveyQuestion.version > version) {
				surveyQuestion.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'surveyQuestion.label', default: 'Survey Question')] as Object[],
						  "Another user has updated this Survey Question while you were editing")
				render(view: "edit", model: [surveyQuestion: surveyQuestion])
				return
			}
		}

		surveyQuestion.description = params.description

		if (!surveyQuestion.save(flush: true)) {
			render(view: "edit", model: [surveyQuestion: surveyQuestion])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'surveyQuestion.label', default: 'Survey Question'), surveyQuestion.id])
		redirect(action: "list", id: surveyQuestion.survey.id)
	}

	def remove() {
		println "remove: ${params}"
		
		def surveyQuestion = SurveyQuestion.get(params.id)
		if (!surveyQuestion) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'surveyQuestion.label', default: 'Survey Question'), params.id])
			redirect(action: "list", id: surveyQuestion.survey.id)
			return
		}

		try {
			surveyQuestion.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'surveyQuestion.label', default: 'Survey Question'), params.id])
			redirect(action: "list", id: surveyQuestion.survey.id)
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'surveyQuestion.label', default: 'Survey Question'), params.id])
			redirect(action: "delete", id: params.id)
		}
	}

}

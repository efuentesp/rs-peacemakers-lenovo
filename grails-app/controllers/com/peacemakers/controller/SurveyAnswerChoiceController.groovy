package com.peacemakers.controller

import org.apache.shiro.SecurityUtils;
import org.springframework.dao.DataIntegrityViolationException;

import com.peacemakers.domain.SurveyAnswerChoice;
import com.peacemakers.domain.SurveyQuestion;
import com.peacemakers.security.User;

class SurveyAnswerChoiceController {

    def index() {
		redirect(action: "list", params: params)
	}
	
	def list() {
		println "list: ${params}"

		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
				
		def surveyQuestion = SurveyQuestion.get(params.id)
		
		def surveyAnswerChoices = SurveyAnswerChoice.findAllByQuestion(surveyQuestion)
		
		[surveyQuestion: surveyQuestion, surveyAnswerChoices: surveyAnswerChoices, user: user]
	}
	
	def create() {
		println "create: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def surveyQuestion = SurveyQuestion.get(params.id)
		
		[surveyQuestion: surveyQuestion, user: user]
	}

	def edit() {
		println "edit: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def surveyAnswerChoice = SurveyAnswerChoice.get(params.id)
		
		[surveyAnswerChoice: surveyAnswerChoice, user: user]
	}

	def delete() {
		println "delete: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def surveyAnswerChoice = SurveyAnswerChoice.get(params.id)
		
		[surveyAnswerChoice: surveyAnswerChoice, user: user]
	}
			
	def save() {
		println "save: ${params}"
		
		def surveyQuestion = SurveyQuestion.get(params.surveyQuestion)
				
		// Get last answer choice
		def sequence =  SurveyAnswerChoice.getNextSequence(params.surveyQuestion.toLong())
		
		//def surveyAnswerChoice = new SurveyAnswerChoice(sequence: 0, code: params.code, description: params.description, points: params.points)
		def surveyAnswerChoice = new SurveyAnswerChoice(sequence: sequence, description: params.description, points: params.points)
		if (!surveyQuestion.addToChoices(surveyAnswerChoice).save(flush: true)) {
			render(view: "create", model: [surveyQuestion: surveyQuestion])
			return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'survey.question.label', default: 'Survey Question'), surveyQuestion.id])
		redirect(action: "list", params: [id: params.surveyQuestion])
	}
	
	def update() {
		println "update: ${params}"
		
		def surveyAnswerChoice = SurveyAnswerChoice.get(params.id.toLong())
		if (!surveyAnswerChoice) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'surveyAnswerChoice.label', default: 'Survey Answer Choice'), params.id])
			redirect(action: "list", id: surveyAnswerChoice.question.id)
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (surveyAnswerChoice.version > version) {
				surveyAnswerChoice.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'surveyAnswerChoice.label', default: 'Survey Answer Choice')] as Object[],
						  "Another user has updated this Survey Answer Choice while you were editing")
				render(view: "edit", model: [surveyAnswerChoice: surveyAnswerChoice])
				return
			}
		}

		surveyAnswerChoice.description = params.description
		surveyAnswerChoice.points = params.points.toInteger()

		if (!surveyAnswerChoice.save(flush: true)) {
			render(view: "edit", model: [surveyAnswerChoice: surveyAnswerChoice])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'surveyAnswerChoice.label', default: 'Survey Answer Choice'), surveyAnswerChoice.id])
		redirect(action: "list", id: surveyAnswerChoice.question.id)
	}

	def remove() {
		println "remove: ${params}"
		
		def surveyAnswerChoice = SurveyAnswerChoice.get(params.id)
		if (!surveyAnswerChoice) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'surveyAnswerChoice.label', default: 'Survey Answer Choice'), params.id])
			redirect(action: "list", id: surveyAnswerChoice.question.id)
			return
		}

		try {
			surveyAnswerChoice.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'surveyAnswerChoice.label', default: 'Survey Answer Choice'), params.id])
			redirect(action: "list", id: surveyAnswerChoice.question.id)
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'surveyAnswerChoice.label', default: 'Survey Answer Choice'), params.id])
			redirect(action: "delete", id: params.id)
		}
	}

}

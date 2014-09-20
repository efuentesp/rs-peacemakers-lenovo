package com.peacemakers.controller

import org.apache.shiro.SecurityUtils;
import org.springframework.dao.DataIntegrityViolationException;

import com.peacemakers.domain.Survey;
import com.peacemakers.security.User;

class SurveyController {

    def index() {
		redirect(action: "list", params: params)
	}
	
	def list() {
		println "list: ${params}"

		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
				
		def surveys = Survey.list()
		
		[surveys: surveys, user: user]
	}
	
	def create() {
		println "create: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		[user: user]
	}

	def edit() {
		println "edit: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def survey = Survey.get(params.id.toLong())
		
		[surveyBean: survey, user: user]
	}

	def delete() {
		println "delete: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def survey = Survey.get(params.id.toLong())
		
		[surveyBean: survey, user: user]
	}
			
	def save() {
		println "save: ${params}"
		
		//def survey = new Survey(code: params.code, name: params.name)
		def survey = new Survey(name: params.name)
		if (!survey.save(flush: true)) {
			render(view: "create", model: [surveyBean: survey])
			return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'survey.label', default: 'Survey'), survey.id])
		redirect(action: "list")
	}
	
	def update() {
		println "update: ${params}"
		
		def survey = Survey.get(params.id.toLong())
		if (!survey) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'survey.label', default: 'Survey'), params.id])
			redirect(action: "list")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (survey.version > version) {
				survey.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'survey.label', default: 'Survey')] as Object[],
						  "Another user has updated this Survey while you were editing")
				render(view: "edit", model: [surveyBean: survey])
				return
			}
		}

		survey.name = params.name

		if (!survey.save(flush: true)) {
			render(view: "edit", model: [surveyBean: survey])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'survey.label', default: 'Survey'), survey.id])
		redirect(action: "list", id: params.id)
	}

	def remove() {
		println "remove: ${params}"
		
		def survey = Survey.get(params.id)
		if (!survey) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'survey.label', default: 'Survey'), params.id])
			redirect(action: "list")
			return
		}

		try {
			survey.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'survey.label', default: 'Survey'), params.id])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'survey.label', default: 'Survey'), params.id])
			redirect(action: "delete", id: params.id)
		}
	}
	
}

package com.peacemakers.controller

import org.apache.shiro.SecurityUtils;
import org.springframework.dao.DataIntegrityViolationException;

import com.peacemakers.domain.SocialGroup;
import com.peacemakers.domain.Survey;
import com.peacemakers.domain.SurveyAssigned;
import com.peacemakers.security.User;

class SocialGroupSurveyController {
	
	def index() {
		redirect(action: "list", params: params)
	}
	
	def list() {
		println "list: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )

		def socialGroupBean = SocialGroup.get(params.id)
		
		def surveys = Survey.list()
		
		def surveysAssigned = SurveyAssigned.findAll {
			socialGroup == socialGroupBean
		}
		
		[socialGroup: socialGroupBean, surveys: surveys, surveysAssigned: surveysAssigned, user: user]
	}

	def save() {
		println "save: ${params}"
		
		def survey = Survey.get(params.survey)
		def socialGroup = SocialGroup.get(params.socialGroup)
		
		def surveysAssigned = SurveyAssigned.findAll(max: 1, sort: "sequence", order: "desc") {
			socialGroup.id == params.socialGroup.toLong() && survey.id == params.survey.toLong()
		}
		
		def sequence = 1
		surveysAssigned.each { s->
			sequence = s.sequence + 1
		}
		println "sequence: ${sequence}"
		
		def surveyAssigned = new SurveyAssigned(sequence: sequence, socialGroup: socialGroup, survey: survey)
		if (!surveyAssigned.save(flush: true)) {
			render(view: "list", model: [surveyAssigned: surveyAssigned])
			return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'survey.label', default: 'Survey Assigned'), surveyAssigned.id])
		redirect(action: "list", params: [id: params.socialGroup])
	}
	
	def disable() {
		println "disable: ${params}"
		
		def surveyAssigned = SurveyAssigned.get(params.id)
		def socialGroup = surveyAssigned.socialGroup
		
		surveyAssigned.enabled = false
		if (!surveyAssigned.save(flush: true)) {
			render(view: "list", model: [surveyAssigned: surveyAssigned])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'surveyAssigned.label', default: 'Survey Assigned'), surveyAssigned.id])
		redirect(action: "list", params: [id: socialGroup.id])
	}

	def enable() {
		println "enable: ${params}"
		
		def surveyAssigned = SurveyAssigned.get(params.id)
		def socialGroup = surveyAssigned.socialGroup
		
		surveyAssigned.enabled = true
		if (!surveyAssigned.save(flush: true)) {
			render(view: "list", model: [surveyAssigned: surveyAssigned])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'surveyAssigned.label', default: 'Survey Assigned'), surveyAssigned.id])
		redirect(action: "list", params: [id: socialGroup.id])
	}
	
	def delete() {
		println "delete: ${params}"
		
		def surveyAssigned = SurveyAssigned.get(params.id)
		def socialGroup = surveyAssigned.socialGroup
		
		if (!surveyAssigned) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'surveyAssigned.label', default: 'Survey Assigned'), params.id])
			redirect(action: "list", params: [id: socialGroup.id])
			return
		}
		
		if (surveyAssigned.answers.size() > 0) {
			flash.message = message(code: 'surveyAssigned.error.surveyApplied.label', args: [message(code: 'surveyAssigned.label', default: 'Survey Assigned'), params.id])
			redirect(action: "list", params: [id: socialGroup.id])
			return
		}

		try {
			surveyAssigned.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'surveyAssigned.label', default: 'Survey Assigned'), params.id])
			redirect(action: "list", params: [id: socialGroup.id])
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'surveyAssigned.label', default: 'Survey Assigned'), params.id])
			redirect(action: "list", id: socialGroup.id)
		}
	}
}

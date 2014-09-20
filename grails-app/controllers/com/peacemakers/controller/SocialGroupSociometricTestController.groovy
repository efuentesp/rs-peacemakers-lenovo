package com.peacemakers.controller

import org.apache.shiro.SecurityUtils;
import org.springframework.dao.DataIntegrityViolationException;

import com.peacemakers.domain.Geography;
import com.peacemakers.domain.SocialGroup;
import com.peacemakers.domain.SociometricCriteria;
import com.peacemakers.domain.SociometricTest;
import com.peacemakers.security.User;


class SocialGroupSociometricTestController {

    def index() {
		redirect(action: "list", params: params)
	}
	
	def list() {
		println "list: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )

		def socialGroupBean = SocialGroup.get(params.id)
		
		def sociometricCriterias = SociometricCriteria.list()
		
		def sociometricTests = SociometricTest.findAll {
			socialGroup == socialGroupBean
		}
		
		[socialGroup: socialGroupBean, sociometricCriterias: sociometricCriterias, sociometricTests: sociometricTests, user: user]
	}
	
	def save() {
		println "save: ${params}"
		
		def sociometricCriteria = SociometricCriteria.get(params.sociometricCriteria)		
		def socialGroup = SocialGroup.get(params.socialGroup)
		
		def sociometricTests = SociometricTest.findAll(max: 1, sort: "sequence", order: "desc") {
			socialGroup.id == params.socialGroup.toLong() && sociometricCriteria.id == params.sociometricCriteria.toLong()
		}
		
		def sequence = 1
		sociometricTests.each { test->
			sequence = test.sequence + 1
		}
		println "sequence: ${sequence}"
		
		def sociometricTest = new SociometricTest(sequence: sequence, socialGroup: socialGroup, sociometricCriteria: sociometricCriteria)
		if (!sociometricTest.save(flush: true)) {
			render(view: "list", model: [sociometricTest: sociometricTest])
			return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'sociometricTest.label', default: 'Sociometric Test'), sociometricTest.id])
		redirect(action: "list", params: [id: params.socialGroup])
	}
	
	def disable() {
		println "disable: ${params}"
		
		def sociometricTest = SociometricTest.get(params.id)
		def socialGroup = sociometricTest.socialGroup
		
		sociometricTest.enabled = false
		if (!sociometricTest.save(flush: true)) {
			render(view: "list", model: [sociometricTest: sociometricTest])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'sociometricTest.label', default: 'Sociometric Test'), sociometricTest.id])
		redirect(action: "list", params: [id: socialGroup.id])
	}

	def enable() {
		println "enable: ${params}"
		
		def sociometricTest = SociometricTest.get(params.id)
		def socialGroup = sociometricTest.socialGroup
		
		sociometricTest.enabled = true
		if (!sociometricTest.save(flush: true)) {
			render(view: "list", model: [sociometricTest: sociometricTest])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'sociometricTest.label', default: 'Sociometric Test'), sociometricTest.id])
		redirect(action: "list", params: [id: socialGroup.id])
	}
	
	def delete() {
		println "delete: ${params}"
		
		def sociometricTest = SociometricTest.get(params.id)
		def socialGroup = sociometricTest.socialGroup
		
		if (!sociometricTest) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'sociometricTest.label', default: 'Sociometric Test'), params.id])
			redirect(action: "list", params: [id: socialGroup.id])
			return
		}
		
		if (sociometricTest.sociometricTestResults.size() > 0) {
			flash.message = message(code: 'sociometricTest.error.testApplied.label', args: [message(code: 'sociometricTest.label', default: 'Sociometric Test'), params.id])
			redirect(action: "list", params: [id: socialGroup.id])
			return
		}

		try {
			sociometricTest.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'sociometricTest.label', default: 'Sociometric Test'), params.id])
			redirect(action: "list", params: [id: socialGroup.id])
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'sociometricTest.label', default: 'Sociometric Test'), params.id])
			redirect(action: "list", id: socialGroup.id)
		}
	}
		
}

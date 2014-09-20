package com.peacemakers.controller

import org.apache.shiro.SecurityUtils;

import com.peacemakers.domain.SocialGroup;
import com.peacemakers.domain.SociometricTest;
import com.peacemakers.security.User;

class SociogramController {

    def index() {
		redirect(action: "list", params: params)
	}
	
	def list() {
		println "list: ${params}"
		
		redirect(controller: "sociometricTestResults", action: "directedGraph", params: params)
		
		// REMOVED: Because no need to use two controllers
//		// Get User signed in
//		def subject = SecurityUtils.subject
//		def user = User.findByUsername( subject.principal )
//		
//		def selectedSocialGroupId = params.id.toLong()
//		
//		def socialGroup = SocialGroup.get(selectedSocialGroupId)
//		
//		// Find all Sociometric Tests assigned to the Social Group
//		def sociometricTests = SociometricTest.findAll(sort:"sequence") {
//			socialGroup.id == selectedSocialGroupId
//		}
//		def sociometricTestArray = []
//		sociometricTests.each { sociometricTest ->
//			//println ">> ${sociometricTest.sociometricCriteria.code}"
//			if (sociometricTest.sociometricCriteria.code in ['classmate_want', 'classmate_guess']) {
//				sociometricTestArray << sociometricTest
//			}
//		}
//		println "sociometricTest: ${sociometricTestArray}"
//		
//		[socialGroup: socialGroup, sociometricTests: sociometricTestArray, user: user, action: params.action]
	}
}

package com.peacemakers.controller

import org.apache.shiro.SecurityUtils;

import com.peacemakers.domain.GroupMember;
import com.peacemakers.domain.SocialGroup;
import com.peacemakers.domain.SociometricCriteriaResponseOption;
import com.peacemakers.domain.SociometricTest;
import com.peacemakers.domain.SociometricTestResult;
import com.peacemakers.domain.SociometricCriteria;
import com.peacemakers.domain.SociometricCriteriaResponse;
import com.peacemakers.domain.SurveyAssigned;
import com.peacemakers.security.User;

class StudentController {
	def SociometricTestGroupMemberService
	
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index() {
		def subject = SecurityUtils.subject
		def userSigned = User.findByUsername( subject.principal )
		
		// Find User's Group Member
		def userSignedId = userSigned.id
		def userGroupMember = GroupMember.find {
			user.id == userSignedId
		}
		
		// Find School
		//TODO: For now, it only takes the language from school
		def school = userGroupMember?.socialGroup?.parent
		println "School: ${school.name} (${school.lang})"
		
		params.lang = school.lang
		
		redirect(action: "main", params: params)
	}
	
    def main() {
		
		// Get User signed
		def subject = SecurityUtils.subject
		def userSigned = User.findByUsername( subject.principal )

		// Find User's Group Member
		def userSignedId = userSigned.id
		def userGroupMember = GroupMember.find {
			user.id == userSignedId
		}
		
		def userSocialGroupId = userGroupMember?.socialGroup.id
		
		// Find Sociometric Tests assigned to the Social Group
		def sociometricTests = SociometricTest.findAll(sort: "sequence", order: "asc") {
			socialGroup.id == userSocialGroupId
		}
		
		def sociometricTestsApplied = []
		sociometricTests.each { s->
			if (s.enabled) {
				def isApplied = SociometricTestGroupMemberService.isSociometricTestTaken(s, userGroupMember)
				if (!isApplied) {
					sociometricTestsApplied << [sociometricTest: s, applied: isApplied]
				}
			}
		}
		
		// Find Surveys assigned to the Social Group
		def surveysAssigned = SurveyAssigned.findAll {
			socialGroup.id == userSocialGroupId
		}
		
		def surveysApplied = []
		surveysAssigned.each { s->
			if (s.enabled) {
				def isApplied = SociometricTestGroupMemberService.isSurveyTaken(s, userGroupMember)
				if (!isApplied) {
					surveysApplied << [surveyAssigned: s, applied: isApplied, score: SociometricTestGroupMemberService.score(s, userGroupMember)]
				}
			}
		}
		
		[	
			user: userSigned,
			groupMember: userGroupMember,
			sociometricTestsApplied: sociometricTestsApplied,
			surveysApplied: surveysApplied
		]
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
		
		// Find all Group Members of the same Social Group
		def userSocialGroupId = userGroupMember?.socialGroup.id
		def groupMembers = GroupMember.findAll {
			socialGroup.id == userSocialGroupId
		}
		
		// Find Sociometric Tests assigned to the Social Group
		//def sociometricTests = SociometricTest.findAll(sort:"sequence") {
		//	socialGroup.id == userSocialGroupId
		//}
		
		// Search for the first SociometricTest not taken by the Group Member
		//def sociometricTest
		//for (s in sociometricTests) {
			//println s
		//	if (!SociometricTestGroupMemberService.isSociometricTestTaken(s, userGroupMember)) {
		//		sociometricTest = s
		//		break
		//	}
		//}
		def sociometricTest = SociometricTest.get(params.id)
		
		// Get Sociometric Criteria Responses from Sociometric Criteria not answered by the Group Member 
		def sociometricCriteriaResponse = sociometricTest?.sociometricCriteria?.sociometricCriteriaResponses
		
		[	groupMemberList: groupMembers,
			sociometricCriteriaResponseList: sociometricCriteriaResponse,
			user: userSigned,
			groupMember: userGroupMember,
			sociometricTest: sociometricTest
		]
	}
	
	def vote() {
		println "vote: ${params}"
		def socialGroup = SocialGroup.get(params.socialGroup)
		def sociometricTest = SociometricTest.get(params.sociometricTest)
		def fromGroupMember = GroupMember.get(params.fromGroupMember)
		def sociometricCriteriaResponse, sociometricCriteriaResponseOption
		def sociometricTestResult
		def toGroupMember
		
		params.vote.each { groupMemberId, vote ->
			if (vote.toInteger() > 0) {
				//println "[${groupMemberId}] => ${vote}"
				toGroupMember = GroupMember.get(groupMemberId)
				sociometricCriteriaResponse = SociometricCriteriaResponse.get(vote)

				//***sociometricTestResult = new SociometricTestResult(socialGroup: socialGroup, sociometricTest: sociometricTest, testDate: new Date(), fromGroupMember: fromGroupMember, toGroupMember: toGroupMember, sociometricCriteriaResponse: sociometricCriteriaResponse).save(failOnError: true)
				sociometricTest.addToSociometricTestResults(new SociometricTestResult(socialGroup: socialGroup, testDate: new Date(), fromGroupMember: fromGroupMember, toGroupMember: toGroupMember, sociometricCriteriaResponse: sociometricCriteriaResponse)).save(failOnError: true)
			}
		}
		
		params.voteSelected.each {groupMemberId, voteOption ->
			if (voteOption != "-1") {
				//println voteOption
				def (vote, option) = voteOption.tokenize('|')
				//println(groupMemberId+" : "+vote+"|"+option)
				toGroupMember = GroupMember.get(groupMemberId)
				sociometricCriteriaResponse = SociometricCriteriaResponse.get(vote)
				sociometricCriteriaResponseOption = SociometricCriteriaResponseOption.get(option)
				//println sociometricCriteriaResponse
				//println sociometricCriteriaResponseOption
				
				sociometricTest.addToSociometricTestResults(new SociometricTestResult(socialGroup: socialGroup, testDate: new Date(), fromGroupMember: fromGroupMember, toGroupMember: toGroupMember, sociometricCriteriaResponse: sociometricCriteriaResponse, sociometricCriteriaResponseOption: sociometricCriteriaResponseOption)).save(failOnError: true)
			}
		}
		
		redirect(action: "main")
	}
	
	def listSociogram() {
		println "list: ${params}"
		
		// Get User signed
		def subject = SecurityUtils.subject
		def userSigned = User.findByUsername( subject.principal )

		// Find User's Group Member
		def userSignedId = userSigned.id
		def userGroupMember = GroupMember.find {
			user.id == userSignedId
		}
		
		// Find all Group Members of the same Social Group
		def userSocialGroupId = userGroupMember?.socialGroup.id
		def groupMembers = GroupMember.findAll {
			socialGroup.id == userSocialGroupId
		}

		def sociometricTest = SociometricTest.get(params.id)
		
		// Get Sociometric Criteria Responses from Sociometric Criteria not answered by the Group Member
		def sociometricCriteriaResponse = sociometricTest?.sociometricCriteria?.sociometricCriteriaResponses
		
		[	groupMemberList: groupMembers,
			sociometricCriteriaResponseList: sociometricCriteriaResponse,
			user: userSigned,
			groupMember: userGroupMember,
			sociometricTest: sociometricTest
		]
	}
	
	def renderPhoto() {
		def groupMemberPhoto = GroupMember.get(params.id)
		if (!groupMemberPhoto || !groupMemberPhoto.photo || !groupMemberPhoto.photoType) {
			response.sendError(404)
			return;
		}
		response.setContentType(groupMemberPhoto.photoType)
		response.setContentLength(groupMemberPhoto.photo.size())
		OutputStream out = response.getOutputStream()
		out.write(groupMemberPhoto.photo)
		out.close()
	}
}

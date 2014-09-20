package com.peacemakers.controller

import grails.converters.JSON;

import java.util.List;

import org.apache.shiro.SecurityUtils;

import com.peacemakers.domain.SocialGroup;
import com.peacemakers.domain.SocialGroupPeriod;
import com.peacemakers.domain.SocialGroupStage;
import com.peacemakers.domain.SocialGroupType;
import com.peacemakers.domain.SociometricTest;
import com.peacemakers.domain.SurveyAssigned;
import com.peacemakers.security.User;

class SchoolAdminController {

    def index() {
		redirect(action: "groupList", params: params)
	}

	def groupList() {
		println "groupList: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		// Find User's School
		//def userSignedId = user.id
		def schoolBean = SocialGroup.find {
			admin == user
		}
		
		if (!schoolBean) {
			schoolBean = SocialGroup.find {
				assistant == user
			}
		}
		
		// Get School
		//def schoolBean = SocialGroup.get(params.school)
		
		// Find all Groups within School
		def groups = SocialGroup.findAll {
			parent == schoolBean
		}
		
		// Get a tree of Stages and Periods from a School
		def stageTree = getSocialGroupTree(groups)

		// Find all Social Groups from a School, Stage and Period selected
		def socialGroupList = []
		if (params.stage && params.period) {
			groups.each { g ->
				if (g.stage.id == params.stage.toLong() && g.period.id == params.period.toLong()) {
					socialGroupList << g
				}
			}
		}
		
		def socialGroupArray = []
		socialGroupList.each { g->
			def socialGroupId = g.id
			// Find all Sociometric Tests assigned to the Social Group
			def sociometricTests = SociometricTest.findAll(sort:"sequence") {
				socialGroup.id == socialGroupId
			}
			def cBullying = 0, cSociogram = 0;
			sociometricTests.each { t->
				switch (t.sociometricCriteria.code) {
					case "bullying":
						cBullying++
						return
					case "classmate_want":
						cSociogram++
						return
				}
			}
			
			def surveys = SurveyAssigned.findAll {
				socialGroup.id == socialGroupId
			}
			def cSurveys = surveys.size()
			
			socialGroupArray << [socialGroup: g, cBullying: cBullying, cSurveys: cSurveys, cSociogram: cSociogram]
		}

		
		[stageTree: stageTree, schoolBean: schoolBean, socialGroupArray: socialGroupArray, user:user, action: 'group']
	}
	
	def groupCreate() {
		println "groupCreate: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def schoolBean = SocialGroup.get(params.school)
		
		def groups = SocialGroup.findAll {
			parent == schoolBean
		}
		
		def stageTree = getSocialGroupTree(groups)
		
		def stageJSON = SocialGroupStage.list().name as JSON
		
		def periodJSON = SocialGroupPeriod.list().name as JSON
		
		[stageTree: stageTree, stageJSON: stageJSON, periodJSON: periodJSON, schoolBean: schoolBean, user:user, action: 'group']
	}
	
	def groupSave() {
		println "groupSave: ${params}"
		
		def stage = SocialGroupStage.findByName(params.stage)
		if (!stage) {
			stage = new SocialGroupStage(name: params.stage).save(failOnError: true)
		}
		def period = SocialGroupPeriod.findByName(params.period)
		if (!period) {
			period = new SocialGroupPeriod(name: params.period).save(failOnError: true)
		}
		def school = SocialGroup.get(params.school)

		// Finds if Group already exist
		def groupName = params.group
		def groupSchool = school
		def groupStage = stage
		def groupPeriod = period
		def groupTypeEnum = SocialGroupType.GROUP
		def existingGroup = SocialGroup.findAll {
			name == groupName && parent == groupSchool && stage == groupStage && period == groupPeriod && groupType == groupTypeEnum
		}
		
		if (!existingGroup) {
				
			def group = new SocialGroup(name: params.group, groupType: SocialGroupType.GROUP, parent: school, stage: stage, period: period)
	
			if (!group.save(flush: true)) {
				render(view: "groupCreate", model: [groupBean: group, action:'group'])
				return
			}
	
			flash.message = message(code: 'default.created.message', args: [message(code: 'socialGroup.groupType.group.label', default: 'Group'), group.id])
			redirect(action: "groupList", params: [school: params.school, period: period.id, stage: stage.id, city: params.city, country: params.country])
		
		} else {
			println "GROUP ALREADY EXISTS !!!!"
			
			flash.message = message(code: 'default.duplicated.message', args: [message(code: 'socialGroup.groupType.group.label', default: 'Group'), existingGroup.id])
			redirect(action: "groupCreate", params: [school: params.school, period: params.period, stage: params.stage, country: params.country, city: params.city])
			return
		}

	}
	
	def groupEdit() {
		println "groupEdit: ${params}"

		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )

		def group = SocialGroup.get(params.id)
		
		def school = SocialGroup.get(group?.parent.id)

		def city = school?.geo.id
		def country = school?.geo?.parent?.parent.id
		
		def schoolBean = SocialGroup.get(school.id)
		
		def groups = SocialGroup.findAll {
			parent == schoolBean
		}
		
		def stageTree = getSocialGroupTree(groups)
		
		def stageJSON = SocialGroupStage.list().name as JSON
		
		def periodJSON = SocialGroupPeriod.list().name as JSON
		
		[stageTree: stageTree, stageJSON: stageJSON, periodJSON: periodJSON, schoolBean: schoolBean, groupBean: group, school: school.id, stage: group.stage.id, period: group.period.id, city: city, country: country, user:user, action: 'group']

	}
	
	def groupUpdate() {
		//println "groupUpdate: ${params}"
	
		def group = SocialGroup.get(params.groupId)
		if (!group) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'socialGroup.groupType.group.label', default: 'Group'), params.groupId])
			//println flash.message
			redirect(action: "groupEdit", params: [groupBean: group, action:'group'])
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (group.version > version) {
				group.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'socialGroup.groupType.school.label', default: 'School')] as Object[],
						  "Another user has updated this School while you were editing")
				render(view: "groupEdit", model: [groupBean: group, action:'group'])
				return
			}
		}

		def stage = SocialGroupStage.findByName(params.stage)
		if (!stage) {
			stage = new SocialGroupStage(name: params.stage).save(failOnError: true)
		}
		def period = SocialGroupPeriod.findByName(params.period)
		if (!period) {
			period = new SocialGroupPeriod(name: params.period).save(failOnError: true)
		}
		
		// Finds if Group already exist
		def groupName = params.group
		def groupSchool = SocialGroup.get(params.school)
		def groupStage = stage
		def groupPeriod = period
		def groupTypeEnum = SocialGroupType.GROUP
		def existingGroup = SocialGroup.findAll {
			name == groupName && parent == groupSchool && stage == groupStage && period == groupPeriod && groupType == groupTypeEnum
		}
		
		if (!existingGroup) {
				
			group.name = params.group
			group?.stage = stage
			group?.period = period
			
			if (!group.save(flush: true)) {
				render(view: "groupCreate", model: [groupBean: group, action:'group'])
				return
			}
	
			flash.message = message(code: 'default.created.message', args: [message(code: 'socialGroup.groupType.group.label', default: 'Group'), group.id])
			redirect(action: "groupList", params: [school: params.school, period: period.id, stage: stage.id, city: params.city, country: params.country])
		
		} else {
			println "GROUP ALREADY EXISTS !!!!"
			
			flash.message = message(code: 'default.duplicated.message', args: [message(code: 'socialGroup.groupType.group.label', default: 'Group'), existingGroup.id])
			redirect(action: "groupEdit", params: [id: params.groupId])
			return
		}

	}
	
	def groupDelete() {
		println "groupDelete: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )

		def group = SocialGroup.get(params.id)
		
		def school = SocialGroup.get(group?.parent.id)

		def city = school?.geo.id
		def country = school?.geo?.parent?.parent.id
		
		def schoolBean = SocialGroup.get(school.id)
		
		def groups = SocialGroup.findAll {
			parent == schoolBean
		}
		
		def stageTree = getSocialGroupTree(groups)
		
		def stageJSON = SocialGroupStage.list().name as JSON
		
		def periodJSON = SocialGroupPeriod.list().name as JSON
		
		[stageTree: stageTree, stageJSON: stageJSON, periodJSON: periodJSON, schoolBean: schoolBean, groupBean: group, school: school.id, stage: group.stage.id, period: group.period.id, city: city, country: country, user:user, action: 'group']

	}
	
	def groupRemove() {
		println "groupRemove: ${params}"

		def group = SocialGroup.get(params.groupId)
		if (!group) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'socialGroup.groupType.group.label', default: 'Group'), params.groupId])
			//println flash.message
			redirect(action: "groupDelete", params: [id: params.groupId])
			return
		}
		
		if (params.version) {
			def version = params.version.toLong()
			if (group.version > version) {
				group.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'socialGroup.groupType.school.label', default: 'School')] as Object[],
						  "Another user has updated this School while you were editing")
				render(view: "groupEdit", model: [groupBean: group, action:'group'])
				return
			}
		}

		try {
			group.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'socialGroup.groupType.group.label', default: 'Group'), params.groupId])
			redirect(action: "groupList", params: [school: params.school, period: group?.period.id, stage: group?.stage.id, city: params.city, country: params.country])
		}
		catch (Exception e) {
			println e
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'socialGroup.groupType.group.label', default: 'Group'), params.groupId])
			//redirect(action: "groupDelete", params: [id: params.groupId])
			redirect(action: "groupList", params: [school: params.school, period: group?.period.id, stage: group?.stage.id, city: params.city, country: params.country])
		}
	}


	private def getSocialGroupTree(List groups) {
		def stages = []
		groups.each { group ->
			if (!stages.contains(group.stage)) {
				stages << group.stage
			}
		}
		
		
		def stageTree = []
		stages.each { s ->
			def periodsArray = []
			def periods = []
			groups.each { g ->
				if (g.stage == s) {
					if (!periods.contains(g.period)) {
						periods << g.period
						periodsArray << [id: g.period.id, name: g.period.name]
					}
				}
			}
			stageTree << [stage: [id: s.id, name: s.name], periods: periodsArray]
		}
		//println stageTree
		
		return stageTree
	}

}

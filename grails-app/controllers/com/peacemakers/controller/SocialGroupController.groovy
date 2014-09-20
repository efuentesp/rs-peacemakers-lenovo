package com.peacemakers.controller

import grails.converters.JSON;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.web.servlet.support.RequestContextUtils as RCU

import org.apache.shiro.SecurityUtils
import org.apache.shiro.crypto.hash.Sha256Hash;

import com.peacemakers.domain.Address;
import com.peacemakers.domain.GeoType;
import com.peacemakers.domain.Geography;
import com.peacemakers.domain.Person;
import com.peacemakers.domain.SocialGroup;
import com.peacemakers.domain.SocialGroupCategory;
import com.peacemakers.domain.SocialGroupPeriod;
import com.peacemakers.domain.SocialGroupStage;
import com.peacemakers.domain.SocialGroupType;
import com.peacemakers.domain.SociometricTest;
import com.peacemakers.domain.SurveyAssigned;
import com.peacemakers.security.Role;
import com.peacemakers.security.User;

class SocialGroupController {
	def SchoolService
	
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		params.lang = user.lang
		
		redirect(action: "schoolList", params: params)
	}
	
	def schoolList() {
		println "schoolList: ${params}"
		
		def lang = RCU.getLocale(request)
		//def lang = session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def socialGroupList, city, country, countrySelectedId=0, citySelectedId=0
		
		if (params.city) {
			
			// Get Country selected
			country = Geography.get(params.country.toLong())
			//countrySelectedId = country.id.toInteger()
			
			// Get City selected
			city = Geography.get(params.city.toLong())
			//citySelectedId = city.id.toInteger()
			
			// Find all Schools from a City
			//socialGroupList = SocialGroup.findAllByGroupType(SocialGroupType.SCHOOL)
			socialGroupList = SocialGroup.findAll {
				geo == city
			}
			
		}
		
		if (params.schoolName) {
			socialGroupList = SocialGroup.findByName(params.schoolName)
			//println socialGroupList
			
			if (socialGroupList) {
				city = socialGroupList.geo
				country = socialGroupList.geo?.parent
			}
		}
		
		// Find all Countries to use in combo-box
		def countries = Geography.findAllByGeoType(GeoType.COUNTRY)
		
		// List of Schools to use in Typehead search
		def schoolList = SocialGroup.findAll {
				groupType == SocialGroupType.SCHOOL
		} 
		def schoolJSON = schoolList.name as JSON
		
		[country: country, city: city, countries: countries, socialGroupList: socialGroupList, schoolJSON: schoolJSON, user: user, lang: lang, action: 'school']
	}
	
	def schoolCreate() {
		println "schoolCreate: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		// Find all Countries to use in combo-box
		def countries = Geography.findAllByGeoType(GeoType.COUNTRY)
		
		// Get City selected
		def geo
		if (params.city) {
			geo = Geography.get(params.city.toLong())
		}
		
		//[countries: countries, geoBean: geo, city: geo.id, country: geo?.parent?.parent.id, user: user, action: 'school']
		[countries: countries, cityBean: geo, user: user, action: 'school']
	}
	
	def schoolEdit() {
		//println "schoolEdit: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		// Find all Countries to use in combo-box
		def countries = Geography.findAllByGeoType(GeoType.COUNTRY)
		
		def school = SocialGroup.get(params.id)
		def geo = Geography.get(school.geo.id)
		if (!school) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'socialGroup.groupType.school.label', default: 'School'), params.id])
            redirect(action: "schoolList")
            return
        }

        [countries: countries, schoolBean:school, geoBean:geo, city: geo.id, country: geo?.parent?.parent.id, user: user, action:'school']
	}
	
	def schoolDelete() {
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		// Find all Countries to use in combo-box
		def countries = Geography.findAllByGeoType(GeoType.COUNTRY)
		
		def school = SocialGroup.get(params.id)
		def geo = Geography.get(school.geo.id)
		if (!school) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'socialGroup.groupType.school.label', default: 'School'), params.id])
			redirect(action: "schoolList")
			return
		}

		[countries: countries, schoolBean: school, geoBean:geo, city: geo.id, country: geo?.parent?.parent.id, user: user, action:'school']
	}
	
	def schoolSave() {
		println "schoolSave ${params}"
		
		def adminRole = Role.findByName('SchoolAdmin')
		def assistantRole = Role.findByName('SchoolAssistant')
		
		// Save School Administrator user
		def adminUser = new User(username: params.user, passwordHash: new Sha256Hash(params.password).toHex(), enabled: true, unencode: params.password)
		adminUser.addToRoles(adminRole)

		if (!adminUser.save(flush: true)) {
			println "Error al crear el usuario del administrador."
			render(view: "schoolCreate", model: [schoolBean: adminUser, action:'school'])
			return
		}
		
		// Save School Assistant user
		def assistantUser = new User(username: params.user_assistant, passwordHash: new Sha256Hash(params.password_assistant).toHex(), enabled: true, unencode: params.password_assistant)
		assistantUser.addToRoles(assistantRole)

		if (!assistantUser.save(flush: true)) {
			println "Error al crear el usuario del asistente."
			render(view: "schoolCreate", model: [schoolBean: adminUser, action:'school'])
			return
		}
				
		// Find City by name
		def city = Geography.findByNameAndGeoType(params.schoolCity, GeoType.CITY)
		
		def geoBean
		if (city) {
			geoBean = city
		} else {
			def country = Geography.get(params.schoolCountry)
			def state = Geography.get(params.state)
			def cityCode = Geography.findAllByGeoType(GeoType.CITY).size()
			//def isoCode = "${state.isoCode}-${cityCode}" 
			geoBean = new Geography(name: params.schoolCity, parent: state, geoType: GeoType.CITY)
			if (!geoBean.save(flush:true)) {
				render(view: "schoolCreate", model: [schoolBean: geoBean, action:'school'])
				return
			}
		}
		
		//def geoBean = Geography.get(params.geo)
		def address = new Address(street:params.schoolStreet)
		def groupCategory
		
		switch (params.groupCategory) {
			case 'PUBLIC':
				groupCategory = SocialGroupCategory.PUBLIC
				break
			case 'PRIVATE':
				groupCategory = SocialGroupCategory.PRIVATE
				break
			default:
				groupCategory = null
		}
					
		def school = new SocialGroup(name: params.schoolName,
									 groupType: SocialGroupType.SCHOOL,
									 groupCategory: groupCategory,
									 geo: geoBean,
									 address: address,
									 admin: adminUser,
									 assistant: assistantUser)
		
		if (!school.save(flush: true)) {
			println "Error al crear el SocialGroup."
			render(view: "schoolCreate", model: [schoolBean: school, action:'school'])
			return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'socialGroup.groupType.school.label', default: 'School'), school.id])
		redirect(action: "schoolList", params: [city: geoBean.id, country: geoBean.parent.id])
		
	}
	
	def schoolUpdate() {
		//println "schoolUpdate: ${params}"
		def assistantRole = Role.findByName('SchoolAssistant')
        def school = SocialGroup.get(params.id)
        if (!school) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'socialGroup.groupType.school.label', default: 'School'), params.id])
			//println flash.message
            redirect(action: "schoolEdit", params: [schoolBean: school, action:'school'])
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (school.version > version) {
                school.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'socialGroup.groupType.school.label', default: 'School')] as Object[],
                          "Another user has updated this School while you were editing")
                render(view: "schoolEdit", model: [schoolBean: school, action:'school'])
                return
            }
        }

		school.name = params.schoolName
		school.address.street = params.schoolStreet
		switch (params.groupCategory) {
			case 'PUBLIC':
				school.groupCategory = SocialGroupCategory.PUBLIC
				break
			case 'PRIVATE':
				school.groupCategory = SocialGroupCategory.PRIVATE
				break
			default:
				groupCategory = null
		}

		if (school.admin && params.user && params.password) {
			def adminUser = User.get(school.admin.id)
			adminUser.username = params.user
			adminUser.unencode = params.password
			adminUser.passwordHash = new Sha256Hash(params.password).toHex()
			if (!adminUser.save(flush: true)) {
				render(view: "schoolEdit", model: [schoolBean: school, action:'school'])
				return
			}
		}
				
		if (school.assistant) {
			def assistantUser = User.get(school.assistant.id)
			assistantUser.username = params.user_assistant
			assistantUser.unencode = params.password_assistant
			assistantUser.passwordHash = new Sha256Hash(params.password_assistant).toHex()
			if (!assistantUser.save(flush: true)) {
				render(view: "schoolEdit", model: [schoolBean: school, action:'school'])
				return
			}
		} else {
			if (params.user && params.password) {
				def assistantUser = new User(username: params.user_assistant, passwordHash: new Sha256Hash(params.password_assistant).toHex(), enabled: true, unencode: params.password_assistant)
				assistantUser.addToRoles(assistantRole)
				if (!assistantUser.save(flush: true)) {
					render(view: "schoolEdit", model: [schoolBean: school, action:'school'])
					return
				}
				school.assistant = assistantUser
			}
		}
		
		if (!school.save(flush: true)) {
			render(view: "schoolEdit", model: [schoolBean: school, action:'school'])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'socialGroup.groupType.school.label', default: 'School'), school.id])
		//println flash.message
        redirect(action: "schoolList", params: [city: params.city, country: params.country])
	}
	
	def schoolRemove() {
		def school = SocialGroup.get(params.id)
		if (!school) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'socialGroup.groupType.school.label', default: 'School'), params.id])
			redirect(action: "schoolList")
			return
		}

		def admin = User.get(school.admin.id)
		
		try {
			school.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'socialGroup.groupType.school.label', default: 'School'), params.id])
			redirect(action: "schoolList", params: [city: params.city, country: params.country])
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'socialGroup.groupType.school.label', default: 'School'), params.id])
			redirect(action: "schoolDelete", id: params.id)
		}
		
		admin.delete(flush: true)
	}
	
	def stageList() {
		//println "stageList: ${params}"
		def socialGroupList = []
		def school = SocialGroup.findAllByGroupType(SocialGroupType.SCHOOL)
		if (params.school) {
			def schoolId = params.school.toLong()
			socialGroupList = SocialGroup.findAll {
				parent.id == schoolId
			}
		}
		[socialGroupList: socialGroupList, schoolList:school, schoolSelected:params.school, action: 'stage']
	}
	
	def periodList() {
		def socialGroupList = SocialGroup.findAllByGroupType(SocialGroupType.PERIOD)
		def school = SocialGroup.findAllByGroupType(SocialGroupType.SCHOOL)
		[socialGroupList: socialGroupList, schoolList:school, schoolSelected:params.school, action: 'period']
	}
	
	// Get all Cities from a State
	def getCitiesByCountry() {
		//println "getCitiesByCountry: ${params}"
		
		if (params.country) {
			def lst = []
			def countrySelectedId = params.country.toLong()
			
			def cities = []
			def allCities = Geography.findAllByGeoType(GeoType.CITY)
			allCities.each { city->
				//println "${city.name} (${city?.parent.name}, ${city?.parent?.parent.name})"
				if (city?.parent?.parent.id == countrySelectedId) {
					cities << city
				}
			}
			
			cities.each { city->
				def parent = Geography.get(city.parent.id)
				lst << [id: city.id, name: city.name, parent: parent.name]
			}
		
			render g.selectWithOptGroup(from: lst, name: "city", optionKey: 'id', optionValue:'name', groupBy: 'parent', required: "", noSelection: ['':'-- Seleccionar --'], class: "span11")
		} else {
			render g.select(name: "city", from: "", disabled: 'true', class: "span11")
		}
		
	}
	
	def groupList() {
		println "groupList: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		// Get School
		def schoolBean = SocialGroup.get(params.school)
		
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
		
		[stageTree: stageTree, schoolBean: schoolBean, socialGroupArray: socialGroupArray, school: params.school, stage: params.stage, period: params.period, city: params.city, country: params.country, user:user, action: 'group']
	}
	
	def groupCreate() {
		//println "groupCreate: ${params}"
		
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
		
		[stageTree: stageTree, stageJSON: stageJSON, periodJSON: periodJSON, schoolBean: schoolBean, school: params.school, stage: params.stage, period: params.period, city: params.city, country: params.country, user:user, action: 'group']
	}
	
	def groupSave() {
		//println "groupSave: ${params}"
		
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
		//println "groupEdit: ${params}"

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
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'socialGroup.groupType.group.label', default: 'Group'), params.groupId])
			redirect(action: "groupDelete", params: [id: params.groupId])
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
	
	// Get all Cities from a State
	def getStatesByCountry() {
		//println "getStatesByCountry: ${params}"
		
		if (params.country) {
			def lst = []
			def countrySelectedId = params.country.toLong()
			
			def country = Geography.get(countrySelectedId)
			
			def allStates = Geography.findAll {
				parent == country
			}
			
			allStates.each { state ->
				lst << [id: state.id, name: state.name]
			}
			//println lst
	
			render g.select(from: lst, name: "schoolState", optionKey: 'id', optionValue:'name', required: "", noSelection: ['':'-- Seleccionar --'], class: "input-medium")
		} else {
			render g.select(name: "state", from: "", disabled: 'true', class: "input-medium")
		}
		
	}
	
	def getCitiesByState() {
		//println "getCitiesByState: ${params}"
		
		if (params.state) {
			def lst = []
			def stateSelectedId = params.state.toLong()
			
			def state = Geography.get(stateSelectedId)
			
			def allCities = Geography.findAll {
				parent == state
			}
			
			allCities.each { city ->
				//lst << [id: city.id, name: city.name]
				lst << city.name
			}
			//println lst
	
			render g.textField(name: 'schoolCity', class: "input-medium", required: "", autocomplete: 'off', 'data-items': '4', 'data-provide': 'typeahead', 'data-source': lst as JSON)
			//println g.select(from: lst, name: "schoolCity", optionKey: 'id', optionValue:'name', required: "", noSelection: ['':'-- Seleccionar --'], class: "input-medium")
		} else {
			render g.select(name: "state", from: "", disabled: 'true', class: "input-medium")
		}

	}
	
}

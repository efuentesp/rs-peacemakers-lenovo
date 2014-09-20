package com.peacemakers.controller

import java.nio.charset.Charset;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.grails.plugins.imagetools.ImageTool;
import org.springframework.dao.DataIntegrityViolationException;

import java.text.Normalizer;

import com.ibm.icu.text.CharsetDetector;
import com.ibm.icu.text.CharsetMatch;
import com.peacemakers.domain.GenderType;
import com.peacemakers.domain.GroupMember;
import com.peacemakers.domain.Person;
import com.peacemakers.domain.SocialGroup;
import com.peacemakers.domain.SocialGroupType;
import com.peacemakers.domain.SociometricTestResult;
import com.peacemakers.domain.SurveyAnswer;
import com.peacemakers.security.Role;
import com.peacemakers.security.User;

import grails.converters.JSON;
import groovy.io.FileType;

class GroupMemberController {
	def SocialGroupService
	def GroupMemberService
	def antUtilsService

	static allowedMethods = [save: "POST", update: "POST", show: "POST"]

    def index() {
		redirect(action: "list", params: params)
	}
	
	private def getSocialGroupTree() {
		def socialGroupTree = SocialGroupService.getSocialGroupTree(0)
		return socialGroupTree
	}
	
	def list() {
		println "list: ${params}"
		
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def socialGroupId
		if (params.id) {
			socialGroupId = params.id.toLong()
		} else {
			socialGroupId = 0.toLong()
		}
		
		def socialGroup = SocialGroup.get(socialGroupId)
		
		def groupMembers = GroupMember.findAll(sort:"person") {
			socialGroup.id == socialGroupId
		}
		
		def groupMemberList = []
		groupMembers.each { member->
			def sociometricTestResultFrom = SociometricTestResult.findAllByFromGroupMember(member)
			def sociometricTestResultTo = SociometricTestResult.findAllByToGroupMember(member)
			def surveyAnswer = SurveyAnswer.findAllByGroupMember(member)
			def hasResults = false
			if (sociometricTestResultFrom.size()>0 || sociometricTestResultTo.size()>0 || surveyAnswer.size()>0) {
				hasResults = true
			}
			groupMemberList << [ id: member.id, groupMember: member, person: member.person, user: member.user, hasResults: hasResults ]
		}
		
		[socialGroupSelected: socialGroup, groupMemberList: groupMemberList, user: user]
	}
	
	def create() {
		println "create: ${params}"
		
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def socialGroupId
		if (params.id) {
			socialGroupId = params.id.toLong()
		} else {
			socialGroupId = 0.toLong()
		}
		
		def socialGroup = SocialGroup.get(socialGroupId)
		
		[socialGroupSelected:socialGroup, user:user]
	}
	
	def createZip() {
		println "createZip: ${params}"
		
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def socialGroupId
		if (params.id) {
			socialGroupId = params.id.toLong()
		} else {
			socialGroupId = 0.toLong()
		}
		
		def socialGroup = SocialGroup.get(socialGroupId)
		if (!socialGroup) {
			socialGroup.errors.each {
				println it
			}
		}
		
		[socialGroupSelected:socialGroup, user:user]
	}
	
	def edit() {
		println "edit: ${params}"
		
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def groupMember = GroupMember.get(params.id)
		
		// Unknown Photo
		def webRootDir = servletContext.getRealPath("/")
		def unknownPhoto = "${webRootDir}fileupload/img/unknown-person.jpg"
		
		def restURI = (request.getContextPath()) ? request.getContextPath()+"/groupMember/renderPhoto/0" : "/groupMember/renderPhoto/0"
		
		[groupMemberBean:groupMember, restURI: restURI, user:user]
	}
	
	def delete() {
		println "delete: ${params}"
		
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def groupMember = GroupMember.get(params.id)
		
		[groupMemberBean:groupMember, user:user]
	}

	def save() {
		println "save: ${params}"
		
		def photo = request.getFile('photoUpload')
		
		def okcontents = ['image/png', 'image/jpeg', 'image/gif']
		if (! okcontents.contains(photo.getContentType())) {
			flash.message = "Photo must be one of: ${okcontents}"
			render(view:'create')
			return;
		}
		
		def socialGroup = SocialGroup.get(params.socialGroup.toLong())
		if (!socialGroup) {
			socialGroup.errors.each {
				println it
			}
		}
		def gender
		switch (params.gender) {
			case 'M':
				gender = GenderType.MALE
				break
			case 'F':
				gender = GenderType.FEMALE
				break
			default:
				gender = null
		}
		def birthday = (params.birthdate) ? new Date().parse("yyyy-MM-dd", params.birthdate) : null
		def person = new Person(firstName:params.firstName, firstSurname:params.firstSurname, secondSurname:params.secondSurname, gender:gender, birthday:birthday)
		if (!person.save(flush: true)) {
			person.errors.each {
				println it
			}
		}
		
		//def userName = getUserByName(params.firstName, params.firstSurname, params.secondSurname)
		def userName = createUserName(person)
		
		def groupMember = new GroupMember(person:person, user:userName)
		
		def imageTool = new ImageTool()
		imageTool.load(photo.getBytes())
		//imageTool.saveOriginal()
		imageTool.thumbnail(180)
		groupMember.photo = imageTool.getBytes("JPEG")
		
		//groupMember.photo = photo.getBytes()
		//groupMember.photoType = photo.getContentType()
		
		log.info("File uploaded: " + groupMember.photoType)
			
		if (!socialGroup.addToGroupMembers(groupMember).save(flush: true)) {
			socialGroup.errors.each {
				println it
			} 
			render(view: "create", model:[socialGroupSelected:socialGroup, groupMemberBean:groupMember])
			return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'groupMember.label', default: 'GroupMember'), groupMember.id])
		redirect(action: "list", id:"${socialGroup.id}")
	}
	
	def saveZip() {
		println "saveZip: ${params}"

		def userDir

		def acceptContentType = ['application/zip', 'application/x-zip-compressed', 'application/octet-stream']
		def acceptContentTypeCSV = ['text/csv', 'application/vnd.ms-excel']
		//def studentRole = Role.findByAuthority('ROLE_STUDENT') ?: new Role(authority: 'ROLE_STUDENT').save(failOnError: true)
		
		def csvUploadedFile = request.getFile('csvFile')
		def uploadedFile = request.getFile('zipFile')
		
		CharsetDetector cd = new CharsetDetector()
		cd.setText(csvUploadedFile.getInputStream())
		CharsetMatch cm = cd.detect()
		
		def charset
		if (cm != null) {
			//println "Reader: ${cm.getReader()}"
			//println "Charset: ${cm.getName()}"
			charset = cm.getName()
		} else {
			println "*** UnsupportedCharsetException ***"
			flash.message = message(code: 'groupMember.typeMismatch.csv.file', args: [message(code: 'socialGroup.label', default: 'Social group'), params.socialGroup])
			redirect(action: "createZip", id: params.socialGroup)
		}
		
		def socialGroup = SocialGroup.get(params.socialGroup)
		
		def groupMemberArray = []
		
		println "Content type (CSV): ${csvUploadedFile.contentType}"
		println "Content type (ZIP): ${uploadedFile.contentType}"
		
		if(!csvUploadedFile.empty && acceptContentTypeCSV.contains(csvUploadedFile.contentType)) {
			
			//def webRootDir = servletContext.getRealPath("/")
			def webRootDir = System.getProperty("java.io.tmpdir")
			userDir = new File(webRootDir, "/zipFiles/${socialGroup.id}/")
			userDir.mkdirs()
			
			def newFilename = csvUploadedFile.originalFilename.replaceAll(~/ /, "")
			println "New filename: ${newFilename}"
			
			def uploadedCsvFile = new File(userDir, csvUploadedFile.originalFilename)
			//uploadedCsvFile.renameTo(new File(userDir, newFilename))
			csvUploadedFile.transferTo(uploadedCsvFile)
			
			//String oldFilename = "old.txt"
			//String newFilename = "new.txt"
			//new File(oldFilename).renameTo(new File(newFilename))
			
			//CharsetToolkit toolkit = new CharsetToolkit(uploadedCsvFile)
			//Charset guessedCharset = toolkit.getDefaultCharset()
			//println "CHARSET: ${guessedCharset}"
			
			/*
			def command = """file -I """ + uploadedCsvFile
			def proc = command.execute()
			proc.waitFor()
			println "return code: ${proc.exitValue()}"
			println "stderr: ${proc.err.text}"
			//println "stdout: ${proc.in.text}"
			def stdout = "${proc.in.text}"
			def out = stdout.split('=') */
			//def charset = 'UTF-8'
			/*
			if (out.size() > 1) {
				charset = "${out[1].toUpperCase().trim()}"
			} */
			println "Charset: ${charset}"
			
			//def fileText = uploadedCsvFile.getText('ISO-8859-1').replaceAll(';', ',')
			def fileText = uploadedCsvFile.getText(charset).replaceAll(';', ',')
			//uploadedCsvFile.write(fileText, 'UTF-8')
			uploadedCsvFile.write(fileText, charset)
	
			def i = 0
			//uploadedCsvFile.eachCsvLine { tokens->
			//uploadedCsvFile.toCsvReader(['charset':'UTF-8']).eachLine { tokens ->
			uploadedCsvFile.toCsvReader(['charset': charset]).eachLine { tokens ->
				if (tokens.size() >= 2 && tokens.size() <= 3 && tokens[0] != '' && tokens[1] != '') {
					def firstName = '** Sin nombre **'
					if (tokens[0] != '') {
						firstName = tokens[0]
					}
					def firstSurname = '** Sin apellido **'
					if (tokens[1] != '') {
						firstSurname = tokens[1]
					}
					def secondSurname = ''
					if (tokens.size() == 3 && tokens[2] != '') {
						secondSurname = tokens[2]
					}
					//println tokens
					i++
					groupMemberArray << [index: i, firstName: firstName, firstSurname: firstSurname, secondSurname: secondSurname]
				}
			}
			
		} else {
			flash.message = message(code: 'groupMember.typeMismatch.csv.file', args: [message(code: 'socialGroup.label', default: 'Social group'), params.socialGroup])
			//redirect(action: "createZip", id: params.socialGroup)
		}
		
		if (groupMemberArray) {
			if(!uploadedFile.empty && acceptContentType.contains(uploadedFile.contentType)) {
				
				//println "Class: ${uploadedFile.class}"
				//println "Name: ${uploadedFile.name}"
				//println "OriginalFileName: ${uploadedFile.originalFilename}"
				//println "Size: ${uploadedFile.size}"
				//println "ContentType: ${uploadedFile.contentType}"
				
				println "TMPDIR: " + System.getProperty("java.io.tmpdir")
				
				//def webRootDir = servletContext.getRealPath("/")
				def webRootDir = System.getProperty("java.io.tmpdir")
				userDir = new File(webRootDir, "/zipFiles/${socialGroup.id}/")
				userDir.mkdirs()
				def uploadedZipFile = new File(userDir, uploadedFile.originalFilename)
				uploadedFile.transferTo(uploadedZipFile)
				println "Uploaded directory: ${uploadedZipFile.toString()}"
				println "User Dir: ${userDir.toString()}"
				
				unzip(uploadedZipFile, userDir)
			
				addBulkGroupMembers(userDir, socialGroup, groupMemberArray)
			
				userDir.deleteDir()
				
				//flash.message = message(code: 'default.created.message', args: [message(code: 'socialGroup.label', default: 'Social Group'), params.socialGroup])
				redirect(action: "list", id: params.socialGroup)
			} else {
				flash.message = message(code: 'groupMember.typeMismatch.zip.file', args: [message(code: 'socialGroup.label', default: 'Social group'), params.socialGroup])
				//redirect(action: "createZip", id: params.socialGroup)
			}
		}
		
		if (flash.message) {
			redirect(action: "createZip", id: params.socialGroup)
		}
		
	}
	
	private def unzip(uploadedZipFile, userDir) {
		def acceptContentTypeCSV = ['text/csv', 'application/vnd.ms-excel']
		try {
			antUtilsService.unzip(uploadedZipFile.toString(), userDir.toString(), "flatten", true)

			// Remove 0's from the beginning of the name file
			def dir = new File(userDir.toString())
			dir.eachFileRecurse (FileType.FILES) { file ->
				file.name.replaceAll('JPG', 'jpg')
				println "${file.path} ${file.name} => ${file.name.replaceAll(/^0*/, '')}"
				String oldName = file
				String newName = file.name.replaceAll(/^0*/, '')
				//new File(oldName).renameTo(new File(newName)) 
			}
			dir.eachFileRecurse (FileType.FILES) { file ->
				println file
			}
			
		} catch (org.grails.plugins.grailsant.UnzipException e) {
			println e.message
			println e.fileName
		}
	}

	private def addBulkGroupMembers(userDir, socialGroup, groupMemberArray) {
		groupMemberArray.each { gm ->
			def person = new Person(nationalIdNumber: null, firstName: gm.firstName, firstSurname: gm.firstSurname, secondSurname: gm.secondSurname, birthday: null, gender: null)
			if (!person.save(flush: true)) {
				person.errors.each {
					println it
				}
			}
			
			def userName = createUserName(person)
			
			def fileJPG = new File("${userDir}/${gm.index}.jpg")
			def file
			if (fileJPG.exists()) {
				file = "${userDir}/${gm.index}.jpg"
			}
			else {
				file = "${userDir}/${gm.index}.JPG"
			}
			
			def imageTool = new ImageTool()
			try{
				imageTool.load(file)
			}
			catch (java.io.FileNotFoundException e) {
				println "Error: ${e}"
				def webRootDir = servletContext.getRealPath("/")
				imageTool.load("${webRootDir}/fileupload/img/unknown-person.jpg")
			}

			imageTool.thumbnail(180)

			def groupMember = new GroupMember(person:person, photo: imageTool.getBytes("JPEG"), user:userName)
			
			socialGroup.addToGroupMembers(groupMember).save(failOnError: true)
		}
	}
	
	def update() {
		//println "Update(): ${params}"
		
		def photo, imageTool
		
		if (!request.getFile('photoUpload').empty) {
			
			photo = request.getFile('photoUpload')
			
			imageTool = new ImageTool()
			imageTool.load(photo.getBytes())
			//imageTool.saveOriginal()
			imageTool.thumbnail(180)
			
			def okcontents = ['image/png', 'image/jpeg', 'image/gif']
			if (! okcontents.contains(photo.getContentType())) {
				flash.message = "Photo must be one of: ${okcontents}"
				render(view:'edit')
				return;
			}
		} else {
			if (params.unknownPhoto == 'yes') {
				//println "Load Unknown Photo!!"
				imageTool = new ImageTool()
				def webRootDir = servletContext.getRealPath("/")
				imageTool.load("${webRootDir}/fileupload/img/unknown-person.jpg")
				imageTool.thumbnail(180)
			}
		}
		
		def socialGroup = SocialGroup.get(params.socialGroup.toLong())
		if (!socialGroup) {
			socialGroup.errors.each {
				println it
			}
		}
		
		def groupMember = GroupMember.get(params.id)
		def person = Person.get(groupMember?.person.id)

		if (params.version) {
			def version = params.version.toLong()
			if (groupMember.version > version) {
				groupMember.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'groupMember.label', default: 'Group Member')] as Object[],
						  "Another user has updated this Group Member while you were editing")
				render(view: "edit", model: [countryBean: country, action:'country'])
				return
			}
		}
		
		def gender
		switch (params.gender) {
			case 'M':
				gender = GenderType.MALE
				break
			case 'F':
				gender = GenderType.FEMALE
				break
			default:
				gender = null
		}
		
		// TODO: Use date previously selected
		def birthday = (params.birthdate) ? new Date().parse("yyyy-MM-dd", params.birthdate) : null
		
		person.firstName = params.firstName
		person.firstSurname = params.firstSurname
		person.secondSurname = params.secondSurname
		person.gender = gender
		person.birthday = birthday

		if (!person.save(flush: true)) {
			person.errors.each {
				println it
			}
		}

		if (photo || params.unknownPhoto == 'yes') {
			groupMember.photo = imageTool.getBytes("JPEG")
			//groupMember.photo = photo.getBytes()
			//groupMember.photoType = photo.getContentType()
			//log.info("File uploaded: " + groupMember.photoType)
		}
		
		if (!groupMember.save(flush: true)) {
			render(view: "edit", model:[socialGroupSelected:socialGroup, groupMemberBean:groupMember])
			return
		}

		flash.message = message(code: 'default.edited.message', args: [message(code: 'groupMember.label', default: 'GroupMember'), groupMember.id])
		redirect(action: "list", id:"${socialGroup.id}")
	}
	
	def remove() {
		println "remove: ${params}"
		def groupMember = GroupMember.get(params.id)
		def messages = GroupMemberService.delete(params.id)

		redirect(action: "list", id:groupMember?.socialGroup.id)
/*		
		def groupMember = GroupMember.get(params.id)
		if (!groupMember) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'groupMember.label', default: 'GroupMember'), params.id])
			redirect(action: "list")
			return
		}
		
		def user = groupMember.user
		def userRole = UserRole.findByUser(user)

		// Try to delete Group Member
		try {
			groupMember.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'groupMember.label', default: 'GroupMember'), params.id])
			redirect(action: "list", id:groupMember?.socialGroup.id)
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'groupMember.label', default: 'GroupMember'), params.id])
			redirect(action: "delete", id: params.id)
		}
		
		// Try to delete User-Role relationship
		try {
			userRole.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'userRole.label', default: 'User-Role'), params.id])
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'userRole.label', default: 'User-Role'), params.id])
		}
		
		// Try to delete User
		try {
			user.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
		}
*/
	}
	
	def bulkDelete() {
		println "bulkDelete: ${params}"

		def membersToDelete = []
		if (!params.delete.getClass().isArray()) {
			membersToDelete << params.delete
			//println "is a String: ${membersToDelete}"
		} else {
			params.delete.each { member ->
				membersToDelete << member
			}
			//println ("is an Array: ${membersToDelete}")
		}
		
		membersToDelete.each { memberId ->
			def messages = GroupMemberService.delete(memberId)

			/*			
			def groupMember = GroupMember.get(memberId)
			
			def user = groupMember.user
			def userRole = UserRole.findByUser(user)
						
			// try to delete Group Member
			try {
				groupMember.delete(flush: true)
				// TODO: Delete orphan users
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'groupMember.label', default: 'GroupMember'), params.id])
				//redirect(action: "list", id: params.socialGroup)
			}
			catch (DataIntegrityViolationException e) {
				flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'groupMember.label', default: 'GroupMember'), params.id])
				//redirect(action: "list", id: params.socialGroup)
			}
			
			// Try to delete User-Role relationship
			try {
				userRole.delete(flush: true)
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'userRole.label', default: 'User-Role'), params.id])
			}
			catch (DataIntegrityViolationException e) {
				flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'userRole.label', default: 'User-Role'), params.id])
			}
			
			// Try to delete User
			try {
				user.delete(flush: true)
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
			}
			catch (DataIntegrityViolationException e) {
				flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
			}
			*/
			
		}
		redirect(action: "list", id: params.socialGroup)
	}
	
	
	def renderPhoto() {
		// Unknown Photo
		def imageTool = new ImageTool()
		def webRootDir = servletContext.getRealPath("/")
		imageTool.load("${webRootDir}/fileupload/img/unknown-person.jpg")
		imageTool.thumbnail(180)
		
		def groupMemberPhoto = GroupMember.get(params.id)
		if (!groupMemberPhoto || !groupMemberPhoto.photo || !groupMemberPhoto.photoType) {
			//response.sendError(404)
			response.contentType = 'image/jpeg'
			response.outputStream << imageTool.getBytes("JPEG")
			response.outputStream.flush()
			return;
		}
		response.setContentType(groupMemberPhoto.photoType)
		response.setContentLength(groupMemberPhoto.photo.size())
		OutputStream out = response.getOutputStream()
		out.write(groupMemberPhoto.photo)
		out.close()
	}
	
	/*
	private def getUserByName(String firstName, String firstSurname, String secondSurname) {

		def studentRole = Role.findByName('Student')
		
		def userId = firstName.toLowerCase().replaceAll(~/ /, "") + '.' + firstSurname.toLowerCase().replaceAll(~/ /, "")
		def password = firstName.toLowerCase().replaceAll(~/ /, "")
		
		//println "   User: ${userId}"
		
		def userName = User.findByUsername(userId) ?: new User(	username: userId,
																enabled: true,
																passwordHash: new Sha256Hash(password).toHex(),
																unencode: password)
																.save(failOnError: true)
		
		return userName
	}
	*/
	
	private def createUserName(Person person) {
		
		def studentRole = Role.findByName('Student')
		
		def firstName = person.firstName.split()
		def firstSurname = person.firstSurname.split()
		
		def userId = firstName[0].toLowerCase().replaceAll(~/ /, "") + person.id
		userId = userId.replaceAll("\\W", "")
		def password = firstSurname[0].toLowerCase().replaceAll(~/ /, "")
		password = password.replaceAll("\\W", "")
		
		//println "   User: ${userId}"

		def userName = User.findByUsername(userId)
		if (!userName) {
			userName = new User(	username: removeAccents(userId),
									enabled: true,
									passwordHash: new Sha256Hash(removeAccents(password)).toHex(),
									unencode: removeAccents(password))
			userName.addToRoles(studentRole)
			userName.save(failOnError: true)
		}
		
		return userName
	}
		
	def tree() {
		def socialGroupTree = SocialGroupService.getSocialGroupTree(0)
		
		render socialGroupTree as JSON
	}
	
	private String removeAccents(String text) {
		//return Normalizer.decompose(text, false, 0).replaceAll("\\p{InCombiningDiacriticalMarks}+", "")
		return Normalizer.normalize(text, Normalizer.Form.NFD).replaceAll("\\p{InCombiningDiacriticalMarks}+", "")
	}
}
	


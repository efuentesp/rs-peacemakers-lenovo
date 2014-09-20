package com.peacemakers.service

import org.springframework.dao.DataIntegrityViolationException;

import com.peacemakers.domain.GroupMember;

class GroupMemberService {

    def delete(String memberId) {
		//println "Group Member delete: ${memberId}"
		def messages = []
		def groupMember = GroupMember.get(memberId)
		println groupMember
		if (!groupMember) {
			//messages << message(code: 'default.not.found.message', args: [message(code: 'groupMember.label', default: 'GroupMember'), params.id])
			messages << "default.not.found.message"
			return messages
		}
		
		def user = groupMember.user

		// Try to delete Group Member
		try {
			groupMember.delete(flush: true)
			//messages << message(code: 'default.deleted.message', args: [message(code: 'groupMember.label', default: 'GroupMember'), params.id])
			messages << "default.deleted.message"
			return messages
		}
		catch (DataIntegrityViolationException e) {
			//messages << message(code: 'default.not.deleted.message', args: [message(code: 'groupMember.label', default: 'GroupMember'), params.id])
			messages << "default.not.deleted.message"
			return messages
		}
		
		// Try to delete User
		try {
			user.delete(flush: true)
			//messages = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
			messages << "default.deleted.message"
			return messages
		}
		catch (DataIntegrityViolationException e) {
			//messages = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
			messages << "default.not.deleted.message"
			return messages
		}
    }
}

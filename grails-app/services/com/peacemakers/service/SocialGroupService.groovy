package com.peacemakers.service

import org.springframework.dao.DataIntegrityViolationException

import com.peacemakers.domain.SocialGroup
import com.peacemakers.domain.GroupMember
import com.peacemakers.domain.SurveyAnswer
import com.peacemakers.domain.SurveyAssigned
import com.peacemakers.domain.SociometricTest
import com.peacemakers.domain.SociometricTestResult
import com.peacemakers.security.User

class SocialGroupService {
  def GroupMemberService

  def delete(Long groupId) {
    //println "Social Groupdelete: ${groupId}"
    def messages = []
    def socialGroup = SocialGroup.get(groupId)
    println socialGroup
    if (!socialGroup) {
      //messages << message(code: 'default.not.found.message', args: [message(code: 'socialGroup.label', default: 'GroupMember'), params.id])
      messages << "default.not.found.message"
      return messages
    }

    SociometricTestResult.executeUpdate("delete SociometricTestResult r where r.socialGroup = :socialGroup", [socialGroup: socialGroup])
    SociometricTest.executeUpdate("delete SociometricTest t where t.socialGroup = :socialGroup", [socialGroup: socialGroup])

    socialGroup.groupMembers.each { m ->
      if (m) {
        m.user.delete()
        SurveyAnswer.executeUpdate("delete SurveyAnswer sa where sa.groupMember = :groupMember", [groupMember: m])
      }
    }

    SurveyAssigned.findAllBySocialGroup(socialGroup).each { s->
      s.delete()
    }
    //SurveyAssigned.executeUpdate("delete SurveyAssigned sa where sa.socialGroup = :socialGroup", [socialGroup: socialGroup])

    GroupMember.executeUpdate("delete GroupMember m where m.socialGroup = :socialGroup", [socialGroup: socialGroup])

    if (messages.size() == 0) {
      try {
        //socialGroup.delete()
        SocialGroup.executeUpdate("delete SocialGroup g where g.id = :id", [id: socialGroup.id])
      }
      catch (Exception e) {
        messages << e.message
      }
    }
    return messages
  }

}

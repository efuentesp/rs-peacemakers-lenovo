package com.peacemakers.service

import org.codehaus.groovy.grails.plugins.web.taglib.ValidationTagLib;

import com.peacemakers.domain.GroupMember;
import com.peacemakers.domain.SocialGroup;
import com.peacemakers.domain.SociometricCriteria;
import com.peacemakers.domain.SociometricTest;
import com.peacemakers.domain.SociometricTestResult;
import com.peacemakers.domain.SurveyAssigned;

class SociometricTestResultsService {
	def SurveyService

    def getSummaryByGroupMember(SociometricTest test, SocialGroup group, Integer maxPercentage = 30) {

		//def maxPercentage = 30
		
		// Get the Sociometric Criteria from a Sociometric Test
		//def sociometricCriteria = SociometricCriteria.get(test.id)
		def sociometricCriteria = test.sociometricCriteria
		
		// Find all Sociometric Criteria Responses
		def criteriaResponsesArray = []
		sociometricCriteria?.sociometricCriteriaResponses.each { response->
			//criteriaResponsesArray << response.id.toLong()
			criteriaResponsesArray << response
		}
		
		def groupMemberArray = []
		def groupMembersCount = group?.groupMembers.size()	// Total of Group Members in a Social Group
		
		// Count responses by Group Member and compute percentage
		group?.groupMembers.each { groupMember->
			def groupMembersResults = []
			criteriaResponsesArray.each { criteriaResponse->
				def query = SociometricTestResult.where {
					toGroupMember == groupMember && sociometricCriteriaResponse == criteriaResponse && sociometricTest == test
				}
				def result = query.list()
				//println "***" + result
				def responseOptions = [:]
				result.each { r->
					responseOptions[r.sociometricCriteriaResponseOption] = responseOptions[r.sociometricCriteriaResponseOption] ? responseOptions[r.sociometricCriteriaResponseOption] + 1 : 1
					//responseOptions["total"] = responseOptions["total"] ? responseOptions["total"] + 1 : 1
					//println "***" + r + " : " + r.sociometricCriteriaResponseOption
				}

				//println "--" + options
				//println " >>> " + responseOptions
				def resultsCount = result.size()
				if (resultsCount > 0) {
					
					def options = []
					responseOptions.each { key, val ->
						//println "[" + key + "] => " + val
						def percentage = 100 * (val / resultsCount)
						if (percentage >= 30 && key) {
							options << [ responseOption: key, count: val, question: key.question, percentage: percentage ]
						}
					}
					
					def percentage = 100 * ( resultsCount / groupMembersCount )
					if (percentage > maxPercentage) {
						groupMembersResults << [criteriaResponse: criteriaResponse, count: resultsCount, percentage: percentage, responseOptions: options]
					}
				}
			}
			if (groupMembersResults.size() > 0) {
				groupMemberArray << [groupMember: groupMember, results: groupMembersResults]
			}
		}
		//println "+++ " + groupMemberArray
		
		//println "Count responses..."
		// Count responses by Criteria Response
		def criteriaResponseResults = [], dataArray = []
		criteriaResponsesArray.each { criteriaResponse ->
			//def criteriaResponseId = criteriaResponse
			def criteriaResponseCount = 0
			groupMemberArray.each { member->
				//println member
				member.results.each { result ->
					if (result.criteriaResponse == criteriaResponse) {
						criteriaResponseCount++
					}
				}
			}
			def percentage = 100 * ( criteriaResponseCount / groupMembersCount )
			criteriaResponseResults << [criteriaResponse: criteriaResponse, count: criteriaResponseCount, percentage: percentage]
		}
		
		return [detail: groupMemberArray, summary: criteriaResponseResults]
    }
	
	def buildGraph(Long sociometricTestId, String type, Map sociometricResults, def bullying=null) {
		println ("+++ buildGraph: ${sociometricResults}")
		
		def maxPercentage = 30
		
		def g = new ValidationTagLib()
		
		// Build sociometric test result
		def results = []
		//println "g: ${sociometricResults}"
		sociometricResults.sociometricTestResults.each { c->
			//println "c: ${c}"
			if (c.criteria.code == "bullying") {
				def t = c.tests[c.tests.size()-1]
				println("t="+t)
				if (bullying) {
					c.tests.each { x->
						if (x.test.id == bullying.toLong()) {
							t = x
						}
					}
				}
				//c.tests.each { t->
					//println "t: ${t.test}"
					t.results.each { m->
						//println "m: ${m}"
						def maxResult = m.results.max { it.percentage }
						results << [id: m.groupMember.id, result: [criteriaResponse: g.message(code: maxResult.criteriaResponse.question), color: maxResult.criteriaResponse.rgbHex, percentage:maxResult.percentage]]
					}
					//println "results: ${results}"
				//}
			}
		}
		
		// Get Sociometric Test
		def sociometricTest = SociometricTest.get(sociometricTestId)
		
		// Find all Group Members from a Social Group
		def socialGroupId = sociometricTest.socialGroup.id
		
		// Find all Surveys assigned to the Social Group
		def surveysAssigned = SurveyAssigned.findAll(sort:"sequence") {
			socialGroup.id == socialGroupId
		}
		
		// Build 'Evaluaci—n por Competencias' results
		def competenceSurveyArray = []
		surveysAssigned.each { s->
			if (s.survey.id in [2.toLong()]) {
				competenceSurveyArray << s
			}
		}
		
		def surveyGroupMemberTotal = []
		def competenceSurvey = competenceSurveyArray.max { it.id } // Get last Survey
		if (competenceSurvey) {
			surveyGroupMemberTotal = SurveyService.getSummaryByGroupMember(competenceSurvey, sociometricTest.socialGroup)
			//println "   >>> ${competenceSurvey.survey.id} ${surveyGroupMemberTotal}"
		}

		// Build 'Bullymetric' results
		def bullymetricSurveyArray = []
		surveysAssigned.each { s->
			if (s.survey.id in [5.toLong(), 6.toLong(), 7.toLong()]) {
				bullymetricSurveyArray << s
			}
		}
		
		def surveyBullymetricGroupMemberTotal = []
		def bullymetricSurvey = bullymetricSurveyArray.max { it.id } // Get last Survey
		if (bullymetricSurveyArray) {
			surveyBullymetricGroupMemberTotal = SurveyService.getSummaryByGroupMember(bullymetricSurvey, sociometricTest.socialGroup)
			//println "   >>> ${bullymetricSurvey.survey.id} ${surveyBullymetricGroupMemberTotal}"
		}
		
		// Build 'Cuenta Conmigo' results
		def cuentaConmigoSurveyArray = []
		surveysAssigned.each { s->
			if (s.survey.id in [8.toLong()]) {
				cuentaConmigoSurveyArray << s
			}
		}

		def surveyCuentaConmigoGroupMemberTotal = []
		def cuentaConmigoSurvey = cuentaConmigoSurveyArray.max { it.id } // Get last Survey
		if (cuentaConmigoSurveyArray) {
			surveyCuentaConmigoGroupMemberTotal = SurveyService.buildCuentaConmigoResults(cuentaConmigoSurvey, sociometricTest.socialGroup)
			//println "   >>> ${cuentaConmigoSurvey.survey.id} ${surveyCuentaConmigoGroupMemberTotal}"
		}

				
		def groupMembers = GroupMember.findAll {
			socialGroup.id == socialGroupId
		}
		def i = 1
		def groupMemberArray = []
		groupMembers.each { groupMember ->
			def memberResult = results.find {
				it.id.toLong() == groupMember.id.toLong()
			}
			//println ">> memberResult: ${groupMember} == ${memberResult}"
			def competencyTestIndex = surveyGroupMemberTotal.findIndexOf {
				it.groupMember == groupMember
			}
			def bullymetricTestIndex = surveyBullymetricGroupMemberTotal.findIndexOf {
				it.groupMember == groupMember
			}
			def cuentaconmigoTestIndex = surveyCuentaConmigoGroupMemberTotal.findIndexOf {
				it.groupMember == groupMember
			}
			//println "---> ${groupMember} ${surveyGroupMemberTotal[competencyTestIndex]}"
			groupMemberArray << [id: groupMember.id,
								name: groupMember.getFullName(),
								firstName: groupMember.person.firstName,
								lastName: groupMember.person.firstSurname,
								result: memberResult ? memberResult.result : [],
								surveyBullymetric: surveyBullymetricGroupMemberTotal ? surveyBullymetricGroupMemberTotal[bullymetricTestIndex].bullymetric : [neap: 0, igap:0, imap: 0],
								surveyCompetency: surveyGroupMemberTotal ? surveyGroupMemberTotal[competencyTestIndex].competency : [f1: 0, f2:0, f3: 0, f4: 0],
								surveyCuentaconmigo: surveyCuentaConmigoGroupMemberTotal? surveyCuentaConmigoGroupMemberTotal[cuentaconmigoTestIndex].cuentaconmigo : [sumCongruencia: 0, descriptionCongruencia: '', sumEmpatia: 0, descriptionEmpatia: '', sumAPI: 0, descriptionAPI: ''],
								display: true]
		}

		// Find all Sociometric Test Results from a Social Group which Sociometric Criteria is Classmate
		//def sociometricTestResults = sociometricTest.sociometricTestResults
		
		def sociometricTestResults = SociometricTestResult.findAll(sort:"fromGroupMember") {
			sociometricTest.id == sociometricTestId
		}
		//println sociometricTest
		//println sociometricTestResultsx
		
		// Create a matrix
		def from, to, test
		def sociometricTestResultsArray = new Object[groupMemberArray.size()][groupMemberArray.size()]
		sociometricTestResults.each { result ->
			if (result) {
				//println "Result: ${result} [${result?.fromGroupMember}][${result?.toGroupMember}] = ${result.sociometricCriteriaResponse.question}"
				from = groupMemberArray.findIndexOf {
					it.id.toLong() == result?.fromGroupMember.id.toLong()
				}
				to = groupMemberArray.findIndexOf {
					it.id.toLong() == result?.toGroupMember.id.toLong()
				}
				
				//println ">>>>>>> [${from}][${to}]=${result.sociometricCriteriaResponse.question}"
				sociometricTestResultsArray[from][to]=result.sociometricCriteriaResponse.question
			}
		}

		// Generates the response
		def linkArray=[]
		for (int source=0; source < groupMemberArray.size(); source++) {
			for (int target=0; target < groupMemberArray.size(); target++) {
				if (sociometricTestResultsArray[source][target] == type) {
					linkArray << [source: source, target: target, type: sociometricTestResultsArray[source][target], display: true]
				}
			}
		}
		
		//println linkArray
		
		def datax = [ nodes: groupMemberArray, links: linkArray ]
		//println datax

		return datax
	}
	
}

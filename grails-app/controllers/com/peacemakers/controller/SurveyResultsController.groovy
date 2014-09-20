package com.peacemakers.controller

import org.apache.shiro.SecurityUtils;

import com.peacemakers.domain.SocialGroup;
import com.peacemakers.domain.SociometricTest;
import com.peacemakers.domain.SurveyAnswerChoice;
import com.peacemakers.domain.SurveyAssigned;
import com.peacemakers.domain.SurveyQuestion;
import com.peacemakers.security.User;
import com.peacemakers.service.SurveyService;

class SurveyResultsController {
	def SurveyService
	def SociometricTestResultsService
	
	def list() {
		println "list: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def selectedSocialGroupId = params.id.toLong()
		
		def socialGroup = SocialGroup.get(selectedSocialGroupId)
		
		// Find all Surveys assigned to the Social Group
		def surveysAssigned = SurveyAssigned.findAll(sort:"sequence") {
			socialGroup.id == selectedSocialGroupId
		}
		
		def surveyArray = []
		def questionArray = []
		surveysAssigned.each { surveyAssigned ->
			def surveyGroupMemberTotal = getSummaryByGroupMember(surveyAssigned, socialGroup)
			println "   >>> ${surveyAssigned.survey.id} ${surveyGroupMemberTotal}"
			
			def total = 0
			def answered = 0
			surveyGroupMemberTotal.each { member ->
				if (member.percentage > 0) {
					answered++
				}
				total += member.percentage
			}
			def socialGroupTotalResult = [percentage: total/surveyGroupMemberTotal.size(), size: answered]
			
			surveyArray << [surveyAssigned: surveyAssigned, surveyResults: surveyGroupMemberTotal, socialGroupTotalResult: socialGroupTotalResult]
			
			def surveyQuestion = getSummaryByQuestion(surveyAssigned)
			questionArray << [surveyAssigned: surveyAssigned, surveyResults: surveyQuestion]
		}
		
		//println ">>> ${surveyArray}"
		
		[socialGroup: socialGroup, surveys: surveyArray, questions: questionArray, user: user]
	}
	
	def getSummaryByGroupMember(SurveyAssigned surveyAssigned, SocialGroup socialGroup) {
		
		// Sociometric Test reslts
		def sociometricTestResults = getSociometricTestResults(socialGroup, 30)
		
		def totalPoints = 0
		surveyAssigned.survey.questions.each { question->
			question.choices.each { choice->
				//println choice
				totalPoints += choice.points
			}
		}
		
		// Survey results
		def items = 0
		switch (surveyAssigned.survey.id) {
			// BullymŽtrica
			case 4:
				surveyAssigned.survey.questions.each { question->
					if (!(question.sequence in [1, 52])) {
						items++
					}
				}
				break
			// BullymŽtrica Alumno-Maestro
			case 5:
			case 6:
			case 7:
				surveyAssigned.survey.questions.each { question->
					if (!(question.sequence in [1, 36])) {
						items++
					}
				}
				break
			// Others
			default:
				surveyAssigned.survey.questions.each { question->
					items++
				}
		}
		
		def groupMemberArray = []
		surveyAssigned.socialGroup.groupMembers.each { groupMember->
			def criteriaArray = []
			sociometricTestResults.each { criteria ->
				//println "Criteria: ${criteria.criteria}"
				def testArray = []
				criteria.tests.each { test ->
					//println "   Test: ${test.test}"
					def resultArray = []
					test.results.each { result ->
						//println "      Result: ${result.groupMember}"
						if (result.groupMember == groupMember) {
							result.results.each { r ->
								//println "         Vote: ${r.criteriaResponse.question}"
								resultArray << [criteriaResponse: r.criteriaResponse, percentage: r.percentage]
							}
						}
					}
					if (resultArray) {
						testArray << [test: test.test, results: resultArray]
					}
				}
				if (testArray) {
					criteriaArray << [criteria: criteria.criteria, tests: testArray]
				}
			}

			// BullymŽtrica
			def bullymetrics_count = 0
			def surveyPoints = 0
			def bullymetrica_neap = 0 // Nœmero total de estrategia de acoso
			def bullymetrica_igap = 0 // Indice global de acoso PSI
			def bullymetrica_imap = 0 // Indice medio de intensidad
			switch (surveyAssigned.survey.id) {
				// BullymŽtrica
				case 4:
					surveyAssigned.answers.each { answer->
						if (!(answer.question.sequence in [1, 52])) {
							if (answer.groupMember == groupMember) {
								bullymetrics_count++
								surveyPoints += answer.choiceSelected.points
								//println "${answer.choiceSelected.id} ${answer.choiceSelected.points}"
								if (answer.choiceSelected.points > 0) {
									bullymetrica_neap++
								}
							}
						}
					}
					if (items > 0) {
						bullymetrica_igap = surveyPoints / items
					}
					if (bullymetrica_neap > 0) {
						bullymetrica_imap = surveyPoints / bullymetrica_neap
					}
					break
				// BullymŽtrica Alumno-Maestro
				case 5:
				case 6:
				case 7: 
					surveyAssigned.answers.each { answer->
						if (!(answer.question.sequence in [1, 36])) {
							if (answer.groupMember == groupMember) {
								bullymetrics_count++
								surveyPoints += answer.choiceSelected.points
								if (answer.choiceSelected.points > 0) {
									bullymetrica_neap++
								}
							}
						}
					}
					if (items > 0) {
						bullymetrica_igap = surveyPoints / items
					}
					if (bullymetrica_neap > 0) {
						bullymetrica_imap = surveyPoints / bullymetrica_neap
					}
					break
				default:
					//println "Default"
					surveyAssigned.answers.each { answer->
						if (answer.groupMember == groupMember) {
							surveyPoints += answer.choiceSelected.points
						}
					}
			}
			def bullymetric = [neap: bullymetrica_neap, igap: bullymetrica_igap, imap: bullymetrica_imap, count: bullymetrics_count]
			//println bullymetric
			
			// 4 Factors (Evaluaci—n por Competencias)
			def f1 = 0
			def f2 = 0
			def f3 = 0
			def f4 = 0
			def answers = []
			// Evaluaci—n por Competencias
			if (surveyAssigned.survey.id == 2) {
				surveyAssigned.answers.each { answer->
					if (answer.groupMember == groupMember) {
						answers << answer.choiceSelected.points
						//answers << answer.choiceSelected.sequence
						//println "(${answer.choiceSelected.id}) ${answer.choiceSelected.sequence} ${answer.choiceSelected.points}"
					}
				}
			}
			//println answers
			answers[0] = (!answers[1]) ? 0 : answers[0]
			answers[1] = (!answers[1]) ? 0 : answers[1]
			answers[2] = (!answers[1]) ? 0 : answers[2]
			answers[3] = (!answers[1]) ? 0 : answers[3]
			answers[4] = (!answers[1]) ? 0 : answers[4]
			answers[5] = (!answers[5]) ? 0 : answers[5]
			answers[6] = (!answers[1]) ? 0 : answers[6]
			answers[7] = (!answers[1]) ? 0 : answers[7]
			answers[8] = (!answers[1]) ? 0 : answers[8]
			answers[9] = (!answers[1]) ? 0 : answers[9]
			
			f1 = ((4*answers[1] + 2*answers[5])*10)/30
			f2 = ((answers[0] + answers[4] + answers[9])*10)/15
			f3 = ((4*answers[3] + 2*answers[7])*10)/30
			f4 = ((3*answers[2] + 3*answers[6] + 3*answers[8])*10)/45
			
			//println "${f1} ${f2} ${f3} ${f4}"
			def competency = [f1: f1, f2: f2, f3: f3, f4: f4]
						
			groupMemberArray << [groupMember: groupMember, points: surveyPoints, items: items, bullymetric: bullymetric, competency: competency, percentage: (surveyPoints/totalPoints)*100, sociometricTestResults: criteriaArray]
		}
		
		return groupMemberArray
	}
	
	def getSummaryByQuestion(SurveyAssigned surveyAssigned) {
		
		def totalSocialGroup = surveyAssigned.socialGroup.groupMembers.size()
		
		def questionArray = []
		def q = SurveyQuestion.findAllBySurvey(surveyAssigned.survey)
		//surveyAssigned.survey.questions.each { question ->
		q.each { question ->
			def questionTotal = 0
			surveyAssigned.answers.each { answer->
				if (answer.question == question) {
					questionTotal += answer.choiceSelected.points
				}
			}
			questionArray << [question: question, points: questionTotal, percentage: (questionTotal/totalSocialGroup)*100]
		}
		return questionArray
	}
	
	def getSociometricTestResults(SocialGroup socialGroup, int maxPercentage) {
		
		def selectedSocialGroupId = socialGroup.id
		
		// Find all Sociometric Tests assigned to the Social Group
		def sociometricTests = SociometricTest.findAll(sort: "sociometricCriteria") {
			socialGroup.id == selectedSocialGroupId
		}
		
		def sociometricCriteriaArray = []
		sociometricTests.each { test->
			if (!(test.sociometricCriteria in sociometricCriteriaArray)) {
				sociometricCriteriaArray << test.sociometricCriteria
			}
		}
		
		def testResults = []
		sociometricCriteriaArray.each { criteria->
			//println "Sociometric Criteria => ${criteria}"
			def sociometricCriteriaId = criteria.id
			sociometricTests = SociometricTest.findAll {
				sociometricCriteria.id == sociometricCriteriaId && socialGroup.id == selectedSocialGroupId
			}
			def testArray = []
			sociometricTests.each { test->
				//println "    Sociometric Test => ${test}"
				def socialGroupResults = SociometricTestResultsService.getSummaryByGroupMember(test, socialGroup, maxPercentage)
				//println "       Sociometric Test Results => ${socialGroupResults.detail}"
				testArray << [test: test, results: socialGroupResults.detail]
			}
			testResults << [criteria: criteria, tests: testArray]
		}
		//println ">> Test results : ${testResults}"
		return testResults
	}
}

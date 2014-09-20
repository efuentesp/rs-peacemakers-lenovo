package com.peacemakers.service

import com.peacemakers.domain.GroupMember;
import com.peacemakers.domain.SocialGroup;
import com.peacemakers.domain.SociometricTest;
import com.peacemakers.domain.Survey;
import com.peacemakers.domain.SurveyAnswer;
import com.peacemakers.domain.SurveyAnswerChoice;
import com.peacemakers.domain.SurveyAssigned;
import com.peacemakers.domain.SurveyResultDescription;

class SurveyService {

    def getSummaryByQuestion(SurveyAssigned surveyAssigned) {

		def groupMemberArray = []
		surveyAssigned.socialGroup.groupMembers.each { groupMember->
			println "groupMember : ${groupMember}"
			def surveyPoints = 0
			surveyAssigned.answers.each { answer->
				if (answer.groupMember == surveyAssigned.socialGroup.groupMembers) {
					println "   ${answer}"
					surveyPoints += choiceSelected.points
				}
			}
			groupMemberArray << [groupMember: groupMember, points: surveyPoints]
		}
		
		return groupMemberArray
    }
	
	def getSummaryByGroupMember(SurveyAssigned surveyAssigned, SocialGroup socialGroup) {
		println "getSummaryByGroupMember(${surveyAssigned}, ${socialGroup})"
		
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
			def maxValueAnswer = 5
			def f1 = 0, maxF1 = 0, pF1 = 0
			def f2 = 0, maxF2 = 0, pF2 = 0
			def f3 = 0, maxF3 = 0, pF3 = 0
			def f4 = 0, maxF4 = 0, pF4 = 0
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
			
			maxF1 = ((4*maxValueAnswer + 2*maxValueAnswer)*10)/30
			maxF2 = ((maxValueAnswer + maxValueAnswer + maxValueAnswer)*10)/15
			maxF3 = ((4*maxValueAnswer + 2*maxValueAnswer)*10)/30
			maxF4 = ((3*maxValueAnswer + 3*maxValueAnswer + 3*maxValueAnswer)*10)/45
			
			pF1 = (100 * f1) / maxF1
			pF2 = (100 * f2) / maxF2
			pF3 = (100 * f3) / maxF3
			pF4 = (100 * f4) / maxF4
			
			//println "${f1} ${f2} ${f3} ${f4}"
			def competency = [f1: pF1, f2: pF2, f3: pF3, f4: pF4]
						
			groupMemberArray << [groupMember: groupMember, points: surveyPoints, items: items, bullymetric: bullymetric, competency: competency, percentage: (surveyPoints/totalPoints)*100]
		}
		
		return groupMemberArray
	}
	
	def buildCuentaConmigoResults(SurveyAssigned surveyAssigned, SocialGroup socialGroup) {
		def groupMemberArray = []
		surveyAssigned.socialGroup.groupMembers.each { groupMember->
			def compute = computeCuentaConmigoResults(surveyAssigned.id, groupMember.id)
			groupMemberArray << [groupMember: groupMember, cuentaconmigo: compute]
		}
		
		return groupMemberArray
	}
	
	def computeCuentaConmigoResults(surveyAssignedId, groupMemberId) {	
		println "computeResults: ${surveyAssignedId} ${groupMemberId}"
		def surveyAssigned = SurveyAssigned.get(surveyAssignedId)
		def groupMember = GroupMember.get(groupMemberId)
		//println "${surveyAssigned}  ${groupMember}"
		surveyAssignedId =surveyAssigned.id
		groupMemberId = groupMember.id
		def surveyAnswer = SurveyAnswer.findAll {
			surveyApplied.id == surveyAssignedId && groupMember.id == groupMemberId
		}
		//println ">>> " + surveyAnswer.size()
		
		def congruencia_afirmativa = [4, 5, 9, 12, 15, 19, 20, 22, 28, 29, 36, 38, 45, 49, 52, 55, 67, 71, 77, 79, 82]
		def congruencia_negativa = [1, 8, 10, 11, 25, 32, 34, 40, 41, 43, 54, 61, 63, 64, 65, 68, 76, 80]
		def empatia_afirmativa = [3, 13, 18, 19, 23, 24, 30, 31, 35, 39, 44, 48, 50, 51, 69, 71, 72, 77, 84]
		def empatia_negativa = [2, 6, 10, 11, 16, 26, 37, 43, 57, 58, 59, 60, 73, 74, 78, 81]
		def api_afirmativa = [5, 7, 9, 15, 17, 19, 21, 27, 28, 33, 35, 36, 42, 45, 46, 49, 50, 53, 55, 66, 70, 71, 77]
		def api_negativa = [4, 10, 12, 14, 16, 25, 29, 47, 56, 57, 58, 59, 60, 62, 63, 68, 75, 78, 81, 83]
		
		def description_congruencia, sum_congruencia, short_description_congruencia
		def description_empatia, sum_empatia, short_description_empatia
		def description_api, sum_api, short_description_api
		
		def sum_congruencia_afirmativa = 0
		def sum_congruencia_negativa = 0
		def sum_empatia_afirmativa = 0
		def sum_empatia_negativa = 0
		def sum_api_afirmativa = 0
		def sum_api_negativa = 0

		surveyAnswer.each { answer ->
			//println answer
			//println answer.question.survey.id
			if (answer.question.survey.id == 8.toLong()) { // Survey 'Cuenta Conmigo'
				def answerChoice = SurveyAnswerChoice.get(answer.choiceSelected.id)
				if (answerChoice.question.sequence in congruencia_afirmativa) {
					//println "(" + answerChoice.question.sequence + ") " + sum_congruencia_afirmativa + " + " + answerChoice.points + " (" + answerChoice.description + ")"
					sum_congruencia_afirmativa += answerChoice.points
				}
				if (answerChoice.question.sequence in congruencia_negativa) {
					//println "(" + answerChoice.question.sequence + ") " + sum_congruencia_negativa + " - " + answerChoice.points
					sum_congruencia_negativa += answerChoice.points
				}
				if (answerChoice.question.sequence in empatia_afirmativa) {
					sum_empatia_afirmativa += answerChoice.points
				}
				if (answerChoice.question.sequence in empatia_negativa) {
					sum_empatia_negativa += answerChoice.points
				}
				if (answerChoice.question.sequence in api_afirmativa) {
					sum_api_afirmativa += answerChoice.points
				}
				if (answerChoice.question.sequence in api_negativa) {
					sum_api_negativa += answerChoice.points
				}
				//println("${answerChoice.question.sequence}. ${answerChoice.question.description} ${answerChoice.description} (${answerChoice.points})")
			}
		}

		def descriptionsCongruencia = SurveyResultDescription.findAllByCode('CUENTACONMIGO_CONGRUENCIA')
		sum_congruencia = sum_congruencia_afirmativa + sum_congruencia_negativa
		description_congruencia = '** Does not exist description for this range **'
		short_description_congruencia = ''
		descriptionsCongruencia.each { d ->
			if (sum_congruencia.toLong() >= d.minVal && sum_congruencia.toLong() <= d.maxVal) {
				description_congruencia = d.description
				short_description_congruencia = d.shortDescription
			}
		}
		
		def descriptionsEmpatia = SurveyResultDescription.findAllByCode('CUENTACONMIGO_EMPATIA')
		sum_empatia = sum_empatia_afirmativa + sum_empatia_negativa
		description_empatia = '** Does not exist description for this range **'
		short_description_empatia = ''
		descriptionsEmpatia.each { d ->
			if (sum_empatia.toLong() >= d.minVal && sum_empatia.toLong() <= d.maxVal) {
				description_empatia = d.description
				short_description_empatia = d.shortDescription
			}
		}

		def descriptionsAPI = SurveyResultDescription.findAllByCode('CUENTACONMIGO_API')
		sum_api = sum_api_afirmativa + sum_api_negativa
		description_api = '** Does not exist description for this range **'
		short_description_api = ''
		descriptionsAPI.each { d ->
			if (sum_api.toLong() >= d.minVal && sum_api.toLong() <= d.maxVal) {
				description_api = d.description
				short_description_api = d.shortDescription
			}
		}
					
		//println sum_congruencia_afirmativa
		//println sum_congruencia_negativa
		//println description_congruencia
		//println sum_empatia_afirmativa
		//println sum_empatia_negativa
		//println description_empatia
		//println sum_api_afirmativa
		//println sum_api_negativa
		//println description_api
		
		return ([sumCongruencia: sum_congruencia, sumEmpatia: sum_empatia, sumAPI: sum_api,
				descriptionCongruencia: description_congruencia, descriptionEmpatia: description_empatia, descriptionAPI: description_api,
				shortDescriptionCongruencia: short_description_congruencia, shortDescriptionEmpatia: short_description_empatia, shortDescriptionAPI: short_description_api])
	}
		

}

package com.peacemakers.domain

import java.text.Normalizer;

class Survey {
	
	static hasMany = [questions: SurveyQuestion]
	
	//String code
	String name

    static constraints = {
		//code(unique: true)
		questions(nullable: true)
    }
	
	def getCode() {
		return Normalizer.normalize(name, Normalizer.Form.NFD).replaceAll("\\p{InCombiningDiacriticalMarks}+", "").toLowerCase().replaceAll(~/ /, "_")
	}
}

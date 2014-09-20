package com.peacemakers.controller

import org.springframework.dao.DataIntegrityViolationException;

import com.peacemakers.domain.GeoType;
import com.peacemakers.domain.Geography;

class GeographyController {
	
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
		redirect(action: "countryList", params: params)
	}
	
	def countryList() {
		def geoList = Geography.findAllByGeoType(GeoType.COUNTRY)
		[geoList: geoList, action: 'country']
	}
	
	def countryCreate() {
		[action:'country']
	}
	
	def countryEdit() {
		def country = Geography.get(params.id)
		if (!country) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'geography.geoType.country.label', default: 'Country'), params.id])
            redirect(action: "countryList")
            return
        }

        [countryBean: country, action:'country']
	}
	
	def countryDelete() {
		def country = Geography.get(params.id)
		if (!country) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'geography.geoType.country.label', default: 'Country'), params.id])
			redirect(action: "countryList")
			return
		}

		[countryBean: country, action:'country']
	}
	
	def countrySave() {
		//println params
		def country = new Geography(isoCode:params.isoCode, name:params.name, geoType:GeoType.COUNTRY)
		if (!country.save(flush: true)) {
			render(view: "countryCreate", model: [countryBean: country, action:'country'])
			return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'geography.geoType.country.label', default: 'Country'), country.id])
		redirect(action: "countryList", id: country.id)
	}
	
	def countryUpdate() {
		//println params
        def country = Geography.get(params.id)
        if (!country) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'geography.geoType.country.label', default: 'Country'), params.id])
            redirect(action: "countryList")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (country.version > version) {
                country.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'geography.geoType.country.label', default: 'Country')] as Object[],
                          "Another user has updated this Country while you were editing")
                render(view: "countryEdit", model: [countryBean: country, action:'country'])
                return
            }
        }

        country.properties = params

        if (!country.save(flush: true)) {
            render(view: "countryEdit", model: [countryBean: country, action:'country'])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'geography.geoType.country.label', default: 'Country'), country.id])
        redirect(action: "countryList", id: country.id)
	}
	
	def countryRemove() {
		def country = Geography.get(params.id)
		if (!country) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'geography.geoType.country.label', default: 'Country'), params.id])
			redirect(action: "countryList")
			return
		}

		try {
			country.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'geography.geoType.country.label', default: 'Country'), params.id])
			redirect(action: "countryList")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'geography.geoType.country.label', default: 'Country'), params.id])
			redirect(action: "countryDelete", id: params.id)
		}
	}
	
	def subdivisionList() {
		//println params
		//def geoList = Geography.findAllByGeoType(GeoType.STATE)
		def geoList = []
		def country = Geography.findAllByGeoType(GeoType.COUNTRY)
		if (params.country) {
		def countryId = params.country.toLong()
		geoList = Geography.findAll {
			parent.id == countryId
		}
		}
		[geoList: geoList, countryList:country, countrySelected:params.country, action: 'subdivision']
	}
	
	def cityList() {
		def geoList = Geography.findAllByGeoType(GeoType.CITY)
		def country = Geography.findAllByGeoType(GeoType.COUNTRY)
		[geoList: geoList, countryList:country, countrySelected:params.country, action: 'city']
	}
	
	def geoName() {
		withHttp(uri:"http://api.geonames.org/") {
			def json = get(path : '/search', query : [name:'san martin', country: 'MX', lang: 'es', style: 'full', type: 'xml', maxRows: 10, username: 'efuentesp'])
			//def allNodes = json.depthFirst().collect{ it }
			json.geoname.each {
				println "${it.name} (${it.geonameId}), State: (${it.adminCode1.'@ISO3166-2'.text()}) ${it.adminCode1}, Country: (${it.countryCode}) ${it.countryName}"
				def isoCodeStr = "${it.countryCode}-${it.adminCode1.'@ISO3166-2'.text()}"
				println isoCodeStr
				def state = Geography.findAllByIsoCode(isoCodeStr)
				println state.name
			}
		}
	}
}

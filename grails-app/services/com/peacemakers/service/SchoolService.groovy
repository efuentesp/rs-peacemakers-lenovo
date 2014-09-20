package com.peacemakers.service

import com.peacemakers.domain.Address;
import com.peacemakers.domain.Geography;
import com.peacemakers.domain.GeoType;
import com.peacemakers.domain.SocialGroup;
import com.peacemakers.domain.SocialGroupCategory;
import com.peacemakers.domain.SocialGroupType;
import com.peacemakers.security.Role;
import com.peacemakers.security.User;


class SchoolException extends RuntimeException {
	String messageCode
	SocialGroup school
}

class UserException extends RuntimeException {
	String messageCode
	User user
}

class GeoException extends RuntimeException {
	String messageCode
	Geography geo
}
	
class SchoolService {

    def create(Map school, Map admin) {
		def messages = []
		
		def adminRole = Role.findByAuthority('ROLE_ADMIN_SCHOOL') ?: new Role(authority: 'ROLE_ADMIN_SCHOOL').save(failOnError: true)
		
		def adminUser = new User(username: admin.user,
								 enabled: true,
								 password: admin.password,
								 unencode: admin.password)

		if (adminUser.hasErrors() || !adminUser.save(flush: true)) {
			messages = adminUser.errors
			throw new UserException(messageCode: "service.school.create.user.error", user: adminUser)
			return messages
		}

		if (!adminUser.authorities.contains(adminRole)) {
			UserRole.create adminUser, adminRole, true
		}
				
		// Find City by name
		def city = Geography.findByNameAndGeoType(school.city, GeoType.CITY)
		
		def geoBean
		if (city) {
			geoBean = city
		} else {
			def country = Geography.get(school.country)
			def state = Geography.get(school.state)
			def cityCode = Geography.findAllByGeoType(GeoType.CITY).size()
			geoBean = new Geography(name: school.city, parent: state, geoType: GeoType.CITY)
			if (geoBean.hasErrors() || !geoBean.save(flush:true)) {
				messages = geoBean.errors
				throw new GeoException(messageCode: "service.school.create.geo.city.error", geo: geoBean)
				return messages
			}
		}
		
		def address = new Address(street: school.street)
		def groupCategory
		
		switch (school.groupCategory) {
			case 'PUBLIC':
				groupCategory = SocialGroupCategory.PUBLIC
				break
			case 'PRIVATE':
				groupCategory = SocialGroupCategory.PRIVATE
				break
			default:
				groupCategory = null
		}
					
		def schoolBean = new SocialGroup(name: school.name,
									 groupType: SocialGroupType.SCHOOL,
									 groupCategory: groupCategory,
									 geo: geoBean,
									 address: address,
									 admin: adminUser)
		
		if (schoolBean.hasErrors() || !schoolBean.save(flush: true)) {
			messages = schoolBean.errors
			throw new SchoolException(messageCode: "service.school.create.error", school: schoolBean)
			return messages
		}

		return messages
		
    }
}

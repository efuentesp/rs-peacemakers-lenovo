package com.peacemakers.domain

private enum GeoType {
	COUNTRY ('Pais'),
	STATE ('Estado'),
	CITY ('Ciudad')
	
	//final static String id
	String name
	
	GeoType(String name) {
		this.name = name
	}
}

class Geography {
	
	static belongsTo = [parent:Geography]
	
	String isoCode
	String abbreviation
	String name
	Geography parent
	GeoType geoType
	byte[] flag

    static constraints = {
		isoCode (nullable: true, unique: true, size: 2..12, matches: "[A-Z-]+")
		abbreviation (nullable: true, size: 2..8, matches: "[A-Za-z.]+")
		name (blank: false, size: 2..25)
		parent (nullable: true)
		geoType (nullable: false)
		flag (nullable: true)
    }
	
	static mapping = {
		sort "name"
	}
}

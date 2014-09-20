package com.peacemakers.domain.custom.graph

class Link {
	Long id
	Double capacity
	Double weight
	
	public Link(Long id, Double weight, Double capacity) {
		this.id = id
		this.weight = weight
		this.capacity = capacity
	}
	public String toString() { // Always good for debugging
		return "E" + id
	}
}

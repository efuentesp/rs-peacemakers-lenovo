package com.peacemakers.domain.custom.graph

class Node  {
	Long id
	String firstName
	String lastName
	
	public Node(Long id, String firstName, String lastName) {
		this.id = id
		this.firstName = firstName
		this.lastName = lastName
	}
	
	public String toString() {
		return "V" + id
	}
}

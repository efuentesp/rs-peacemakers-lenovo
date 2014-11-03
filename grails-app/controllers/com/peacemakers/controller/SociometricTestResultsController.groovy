package com.peacemakers.controller

import org.apache.shiro.SecurityUtils;

import com.peacemakers.domain.GroupMember;
import com.peacemakers.domain.Person;
import com.peacemakers.domain.SocialGroup;
import com.peacemakers.domain.SociometricCriteria;
import com.peacemakers.domain.SociometricCriteriaResponse;
import com.peacemakers.domain.SociometricTest;
import com.peacemakers.domain.SociometricTestResult;
import com.peacemakers.security.User;

//import com.sun.j3d.utils.scenegraph.io.state.javax.media.j3d.LinkState;

import edu.uci.ics.jung.algorithms.shortestpath.DijkstraShortestPath;
import edu.uci.ics.jung.algorithms.filters.KNeighborhoodFilter;
import edu.uci.ics.jung.graph.Graph;
import edu.uci.ics.jung.graph.DirectedSparseMultigraph;
import edu.uci.ics.jung.graph.util.EdgeType;

import com.peacemakers.domain.custom.graph.Node;
import com.peacemakers.domain.custom.graph.Link;

import grails.converters.JSON;

class SociometricTestResultsController {
	def SocialGroupService
	def SociometricTestResultsService
	
	def index() {
		redirect(action: "matrixChart", params: params)
	}
	
	def matrixChart() {
		println "matrixChart: ${params}"
		//println "Context Path: ${ request.getContextPath() }"
		//println "URI: ${ request.getRequestURI() }"
		//println "Server Name: ${request.getServerName()}"
		//println "Server Port: ${request.getServerPort()}"
		//println "${request.forwardURI}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def selectedSocialGroupId = params.id.toLong()
		
		def socialGroup = SocialGroup.get(selectedSocialGroupId)
		
		// Find all Sociometric Tests assigned to the Social Group
		def sociometricTests = SociometricTest.findAll(sort:"sequence") {
			socialGroup.id == selectedSocialGroupId
		}
		def sociometricTestArray = []
		sociometricTests.each { sociometricTest ->
			if (sociometricTest.sociometricCriteria.code in ['bullying']) {
				sociometricTestArray << sociometricTest
			}
		}
		//println "sociometricTest: ${sociometricTestArray}"
		
		def restURI = request.forwardURI.replaceFirst('matrixChart', 'matrix')
		
		[socialGroup: socialGroup, sociometricTests: sociometricTestArray, restURI: restURI, user: user, action: params.action]
		
	}

	def matrix() {
		// TODO: Separate Sociometric Tests for Criteria do not mix them
		
		println "matrix: ${params}"
		
		// Find all Group Members from a Social Group
		def socialGroupId = params.id.toLong()
		def groupMembers = GroupMember.findAll {
			socialGroup.id == socialGroupId
		}
		def i = 1
		def groupMemberArray = []
		groupMembers.each { groupMember ->
			groupMemberArray << [id: "${groupMember.id}", seq: "A${i++}", fullname: "${groupMember.getFullName()}"]
		}
		
		// Find all Sociometric Tests assigned to the Social Group
		def sociometricTests = SociometricTest.findAll(sort:"sequence") {
			socialGroup.id == socialGroupId
		}
		def sociometricTestArray = []
		sociometricTests.each { sociometricTest ->
			if (sociometricTest.sociometricCriteria.code in ['bullying']) {
				sociometricTestArray << sociometricTest
			}
		}
		
		//println "sociometricTest: ${sociometricTestArray}"

		// Find all Sociometric Test Results from a Social Group
		def query = SociometricTestResult.where {
			socialGroup.id == socialGroupId && sociometricTest in sociometricTestArray
		}
		def sociometricTestResults = query.list()
		
		// Create a matrix
		def from, to, test
		def sociometricTestResultsArray = new Object[groupMemberArray.size()][groupMemberArray.size()][sociometricTestArray.size()]
		sociometricTestResults.each { result ->
			from = groupMemberArray.findIndexOf {
				it.id.toLong() == result?.fromGroupMember.id.toLong()
			}
			to = groupMemberArray.findIndexOf {
				it.id.toLong() == result?.toGroupMember.id.toLong()
			}
			test = sociometricTestArray.findIndexOf {
				it.id.toLong() == result?.sociometricTest.id.toLong()
			}
			
			sociometricTestResultsArray[to][from][test]=result.sociometricCriteriaResponse.color
		}

		// Generates the response
		def tArray = []
		for (int t=0; t < sociometricTestArray.size(); t++) {
			//println "t=${t}"
			def yArray=[]
			for (int y=0; y < groupMemberArray.size(); y++) {
				//println "   y=${y}"
				def xArray=[]
				for (int x=0; x < groupMemberArray.size(); x++) {
					def result = (sociometricTestResultsArray[y][x][t]) ? sociometricTestResultsArray[y][x][t] : 'tile_default' 
					xArray << [test: result]
					//println "      x=${x} => ${sociometricTestResultsArray[y][x][t]}"
				}
				yArray << xArray
			}
			
			tArray << [name: "${g.message(code: 'sociometricTest.list.header', default:'Test')} ${sociometricTestArray[t].sequence}", tiles: yArray]
		}
		
		//println tArray
		
		def data = [ headers: groupMemberArray, tests: tArray ]
		
		render data as JSON
	}
	
	def barChart() {
		println "barChart: ${params}"
		
		def json = barChartJSON(params)
		//println json
			
		[socialGroup: json.socialGroup, sociometricTestResults: json.sociometricTestResults, user: json.user, maxPercentage: json.maxPercentage, action: params.action]
	}
	
	def barChartJSON(params) {
		println "barChartJSON: ${params}"
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def socialGroupId = params.id.toLong()
		
		def socialGroup = SocialGroup.get(socialGroupId)
		
		// Find all Sociometric Tests assigned to the Social Group
		def sociometricTests = SociometricTest.findAll(sort: "sequence") {
			socialGroup.id == socialGroupId
		}
		
		def sociometricCriteriaArray = []
		sociometricTests.each { test->
			if (test.sociometricCriteria.code in ['bullying']) {
				if (!(test.sociometricCriteria in sociometricCriteriaArray)) {
					sociometricCriteriaArray << test.sociometricCriteria
				}
			}
		}
		
		def maxPercentage = 30
		if (params.maxPercentage) {
			maxPercentage = params.maxPercentage.toInteger()
		} else {
			maxPercentage = 30
		}
		
		def testResults = []
		sociometricCriteriaArray.each { criteria->
			//println "Sociometric Criteria => ${criteria}"
			def sociometricCriteriaId = criteria.id
			sociometricTests = SociometricTest.findAll {
				sociometricCriteria.id == sociometricCriteriaId && socialGroup.id == socialGroupId
			}
			
			// Find all Sociometric Criteria Responses
			def criteriaResponsesArray = []
			criteria?.sociometricCriteriaResponses.each { response->
				criteriaResponsesArray << response
			}
			
			def testArray = [], testMatrix = [][]
			sociometricTests.each { test->
				//println "    Sociometric Test => ${test}"
				def socialGroupResults = SociometricTestResultsService.getSummaryByGroupMember(test, socialGroup, maxPercentage.toInteger())
				//println "       Sociometric Test Results => ${socialGroupResults.detail}"
				def criteriaResponseArray = []
				criteriaResponsesArray.each { resp ->
					def resultArray = []
					socialGroupResults.detail.each { result ->
						//println "${resp} == ${result.results[0].criteriaResponse}"
						if (result.results[0].criteriaResponse == resp) {
							//println result
							resultArray << result
						}
					}
					if (resultArray.size() > 0) {
						criteriaResponseArray << [criteriaResponse: resp, testResult: resultArray]
					}
				}
				//println "@@" + criteriaResponseArray
				testArray << [test: test, results: socialGroupResults.detail, criteriaResponses: criteriaResponseArray]
			}
			testResults << [criteria: criteria, tests: testArray]
		}
		//println ">> Test results : ${testResults}"
		
		def json = [socialGroup: socialGroup, sociometricTestResults: testResults, user: user, maxPercentage: maxPercentage]

		return json
	}
		
	def jqPlotBarChart() {
		println "jqPlotbarChart: ${params}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )
		
		def socialGroupId = params.id.toLong()
		
		def socialGroup = SocialGroup.get(socialGroupId)
		
		// Find all Sociometric Tests assigned to the Social Group
		def sociometricTests = SociometricTest.findAll(sort: "sociometricCriteria") {
			socialGroup.id == socialGroupId
		}
		
		def sociometricCriteriaArray = []
		sociometricTests.each { test->
			if (test.sociometricCriteria.code in ['bullying']) {
				if (!(test.sociometricCriteria in sociometricCriteriaArray)) {
					sociometricCriteriaArray << test.sociometricCriteria
				}
			}
		}
		
		//def restURI = request.forwardURI.replaceFirst('jqPlotBarChart', 'piejson')
		def restURI = request.getContextPath() + '/sociometricTestResults/piejson'
		//println "${restURI}"
		
		[socialGroup: socialGroup, sociometricCriterias: sociometricCriteriaArray, maxPercentage: params.maxPercentage, restURI: restURI, user: user, action: params.action]
	}
	
	def piejson() {
		println "piejson: ${params}"
		
		def criteriaId = params.criteria.toLong()
		def groupId = params.group.toLong()
		
		def sociometricCriteria = SociometricCriteria.get(criteriaId)
		def socialGroup = SocialGroup.get(groupId)
		
		def sociometricTests = SociometricTest.findAll {
			socialGroup.id == groupId && sociometricCriteria.id == criteriaId 
		}
		
		def criteriaResponses = []
		sociometricCriteria.sociometricCriteriaResponses.each{ criteriaResponse->
			criteriaResponses << [ id: criteriaResponse.id ]
		}
		//println "series: ${series}"

		def maxPercentage = 30
		if (params.maxPercentage) {
			maxPercentage = params.maxPercentage.toInteger()
		} else {
			maxPercentage = 30
		}
				
		def ticks = [],
			matrix = new Object[criteriaResponses.size()][sociometricTests.size()],
			percentage = new Object[criteriaResponses.size()][sociometricTests.size()],
			t = 0
		sociometricTests.each { test ->
			def socialGroupResults = SociometricTestResultsService.getSummaryByGroupMember(test, socialGroup, maxPercentage)
			//println "++++ test: ${test}, socialGroup: ${socialGroup}"
			socialGroupResults.summary.each { result->
				//println result
				def criteriaResponse = criteriaResponses.findIndexOf {
					it.id.toLong() == result.criteriaResponse.id.toLong()
				}
				matrix[criteriaResponse][t] = result.count
				percentage[criteriaResponse][t] = g.formatNumber(number: result.percentage, type: "number", maxFractionDigits: "1") + '%'
				//println "CriteriaResponse index: ${criteriaResponse}"
			}
			//println "Social Group Results: ${socialGroupResults}"
			ticks << g.message(code: 'sociometricTest.list.header', default: 'Test') + ' ' + test.sequence
			t++
		}
		//println "matrix: ${matrix}"
		//println "ticks: ${ticks}"

		def series = [], res=0
		sociometricCriteria.sociometricCriteriaResponses.each{ criteriaResponse->
			series << [ label: g.message(code: criteriaResponse.question, default: criteriaResponse.question),
						pointLabels: [labels: percentage[res]],
						color: criteriaResponse.rgbHex
					  ]
			//println ":: ${percentage[res]}"
			res++
		}
		//println "series: ${series}"
		
				
		def title = [text: sociometricCriteria.name, show: true]
		
		def r = [ 	title: title,
			size: socialGroup.groupMembers.size(),
			data: matrix,
			ticks: ticks,
			series: series
		]
		
		/*
		def r = [ 	title: sociometricCriteria.name,
					size: 5,
					data: [ [4, 3, 5], [3, 6, 2], [5, 2, 3], [4, 3, 4] ],
					ticks: ['1st', '2nd', '3th'],
					series: [
						            [label: 'Victima', color:'#FDD200'],
						            [label: 'Rechazado', color: '#304CE3'],
						            [label: 'Peacemaker', color: '#F77A00'],
						            [label: 'Agresor', color: '#CB002D']
						    ]
				] */
		
		//println ">> Results to Chart: ${r as JSON}"
		
		render r as JSON
	}
	
	def directedGraph() {
		println "directedGraph: ${params}"
		//println "Context Path: ${ request.getContextPath() }"
		//println "URI: ${ request.getRequestURI() }"
		//println "Server Name: ${request.getServerName()}"
		//println "Server Port: ${request.getServerPort()}"
		
		// Get User signed in
		def subject = SecurityUtils.subject
		def user = User.findByUsername( subject.principal )

		// Get Social Group
		def selectedSocialGroupId = params.id.toLong()
		
		def socialGroup = SocialGroup.get(selectedSocialGroupId)
				
		// Get Sociometric Test
		//def test = SociometricTest.get(params.id.toLong())
		
		// Get Social Group
		//def socialGroup = test.socialGroup
		
		// Set URI to call Ajax retrieve of directed graph data & URL to get photos
		def restURI = request.forwardURI.replaceFirst('directedGraph', 'graph')
		restURI = restURI.replaceFirst(params.id, '') // Remove last part of URI to build it in javascript
		def photoURL = (request.getContextPath()) ? request.getContextPath()+"/groupMember/renderPhoto/" : "/groupMember/renderPhoto/"
		
		//def selectedSocialGroupId = socialGroup.id
		// Find all Sociometric Tests assigned to the Social Group
		def sociometricTests = SociometricTest.findAll(sort:"sequence") {
			socialGroup.id == selectedSocialGroupId
		}
		def sociometricTestArray = [], bullyingArray = []
		sociometricTests.each { sociometricTest ->
			//println ">> ${sociometricTest.sociometricCriteria.code}"
			if (sociometricTest.sociometricCriteria.code in ['classmate_want', 'classmate_guess']) {
				sociometricTestArray << sociometricTest
			}
			if (sociometricTest.sociometricCriteria.code in ['bullying']) {
				bullyingArray << sociometricTest
			}
		}
		
		def students = []
		socialGroup.groupMembers.each { m->
			if (m) {
				students << m.getFullName()
			}
		}

		[socialGroup: socialGroup, sociometricTests: sociometricTestArray, bullyingArray: bullyingArray, restURI: restURI, photoURL: photoURL, user: user, students: students as JSON, action: params.action]
		
	}
	
	def graph() {
		println "graph(): ${params}"
		
		def sociometricTest = SociometricTest.get(params.id.toLong()) 
		def inParams = [id : sociometricTest.socialGroup.id]
		def json = barChartJSON(inParams)
		
		def datax = SociometricTestResultsService.buildGraph(params.id.toLong(), params.type, json, params.bullying)
		//println ">> datax = " + datax
		
		render datax as JSON
	}

	def graphx() {
		println "graph(): ${params}"
		
		/*
		 if (params.selected) {
			 def dataJson = JSON.parse(params.selected)
			 dataJson.each { data -> println data }
		 }*/
		
		Graph g = new DirectedSparseMultigraph<Node, Link>()

		def datax = SociometricTestResultsService.buildGraph(params.id.toLong(), params.type)

		def verticesSelected = []
		//def verticesSelected = [4551.toLong(), 4566.toLong(), 4555.toLong()]
		if (params.selected) {
			def dataJson = JSON.parse(params.selected)
			dataJson.each { data ->
				//println data
				verticesSelected << data.toLong()
			}
		}
		else {
			render datax as JSON
		}
		println verticesSelected

					
		def vertex = []	
		datax.nodes.each { v ->
			vertex << new Node(v.id.toLong(), v.firstName, v.lastName)
		}
		
		def edge = []
		datax.links.eachWithIndex { e, i ->
			g.addEdge(new Link(i, 0, 0), vertex[e.source], vertex[e.target])
		}
		
		Graph f = new DirectedSparseMultigraph<Node, Link>()
		//def g1 = new KNeighborhoodFilter<Node, Link>(vertex[0], 1, KNeighborhoodFilter.EdgeType.IN)
		
		
		def vertices = g.getVertices()
		
		def vx = []
		vertices.each { v->
			if (v.id in verticesSelected) {
				vx << v
			}
		}
		
		def i=0
		vx.each { v->
			def predecessors = g.getPredecessors(v)
			predecessors.each { p->
				f.addEdge(new Link(i++, 0, 0), p, v)
			}
		}
		
		def vArray = []
		def fv = f.getVertices()
		fv.each { v ->
			vArray << [id: v.id, name: v.firstName + " " + v.lastName, firstName: v.firstName, lastName: v.lastName, display:true]
		}
		
		def eArray = []
		def fe = f.getEdges()
		fe.each { e ->
			def from = vArray.findIndexOf {
				it.id.toLong() == f.getSource(e).id.toLong()
			}
			def to = vArray.findIndexOf {
				it.id.toLong() == f.getDest(e).id.toLong()
			}
			eArray << [source: from, target: to, type: null, display: true]
		}
		
		def data = [ nodes: vArray, links: eArray ]
		
		render data as JSON
		
		/*
		// Create some MyNode objects to use as vertices
		def n1 = new Node(1)
		def n2 = new Node(2)
		def n3 = new Node(3)
		def n4 = new Node(4)
		def n5 = new Node(5)
		
		// Add some directed edges along with the vertices to the graph
		g.addEdge(new Link(1, 2.0, 48),n1, n2, EdgeType.DIRECTED); // This method
		g.addEdge(new Link(2, 2.0, 48),n2, n3, EdgeType.DIRECTED);
		g.addEdge(new Link(3, 3.0, 192), n3, n5, EdgeType.DIRECTED);
		g.addEdge(new Link(4, 2.0, 48), n5, n4, EdgeType.DIRECTED); // or we can use
		g.addEdge(new Link(5, 2.0, 48), n4, n2); // In a directed graph the
		g.addEdge(new Link(6, 2.0, 48), n3, n1); // first node is the source
		g.addEdge(new Link(7, 10.0, 48), n2, n5);// and the second the destination
		*/
		
		//println("The graph g = " + g.toString())
		
		//println("The graph f = " + f.toString())
		
		/*
		def alg = new DijkstraShortestPath(g);
		def l = alg.getPath(n1, n4);
		println("The shortest unweighted path from" + n1 + " to " + n4 + " is:");
		println(l.toString());
		*/
	}
	
	def printPreview() {
		println "Print Preview"
		
		
	}
	
	def socialGroupDetailResults() {
		println "socialGroupResults: ${params}"
		
		// Find Sociometric Criteria
		def sociometricTestId = params.id.toLong()
		def sociometricTest = SociometricTest.get(sociometricTestId)
		def socialGroup = SocialGroup.get(sociometricTest?.socialGroup.id)
		
		def socialGroupResults = SociometricTestResultsService.getSummaryByGroupMember(sociometricTest, socialGroup)
			
		render socialGroupResults.detail as JSON

	}

	def socialGroupSummaryResults() {
		println "socialGroupResults: ${params}"
		
		// Find Sociometric Criteria
		def sociometricTestId = params.id.toLong()
		def sociometricTest = SociometricTest.get(sociometricTestId)
		def socialGroup = SocialGroup.get(sociometricTest?.socialGroup.id)
		
		def socialGroupResults = SociometricTestResultsService.getSummaryByGroupMember(sociometricTest, socialGroup)
			
		render socialGroupResults.summary as JSON

	}
	
}

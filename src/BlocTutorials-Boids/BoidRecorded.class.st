Class {
	#name : #BoidRecorded,
	#superclass : #Object,
	#instVars : [
		'current',
		'data',
		'index'
	],
	#category : #'BlocTutorials-Boids-Model'
}

{ #category : #accessing }
BoidRecorded >> color [
	
	^ current at: 1
]

{ #category : #accessing }
BoidRecorded >> extent [

	^ current at: 2
]

{ #category : #initialization }
BoidRecorded >> initialize [

	super initialize.
	index := 0.
	data := OrderedCollection new.
	
]

{ #category : #accessing }
BoidRecorded >> move [
	
	index := index + 1.
	index > data size ifTrue: [ index := 1 ].
	current := data at: index.
]

{ #category : #accessing }
BoidRecorded >> position [

	^ current at: 3
]

{ #category : #accessing }
BoidRecorded >> radius [

	^ current at: 4
	

]

{ #category : #accessing }
BoidRecorded >> updateFrom: aBoid [ 

	| value |
	
	value := {aBoid color. aBoid extent. aBoid position. aBoid radius. aBoid velocity. aBoid velocityLimit}.

	current ifNil: [ 
		current := value.
		index := 1 ].

	data add: value.
]

{ #category : #accessing }
BoidRecorded >> velocity [ 

	^ current at: 5
	

]

{ #category : #accessing }
BoidRecorded >> velocityLimit [ 

	^ current at: 6
	

]

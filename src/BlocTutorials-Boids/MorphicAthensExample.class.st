"
I provide a SkyMorph with a window and a toolbar.

To see in action, do:
MorphicAthensExample new.
"
Class {
	#name : #MorphicAthensExample,
	#superclass : #Object,
	#instVars : [
		'window',
		'toolbar',
		'simulationMorph'
	],
	#category : #'BlocTutorials-Boids-UI-MorphicAthens'
}

{ #category : #'initialize-release' }
MorphicAthensExample >> initialExtent [
	^ 510@560
]

{ #category : #'initialize-release' }
MorphicAthensExample >> initialize [
	super initialize.
	self installToolbar.
	self installSky.
	self window openInWorld
]

{ #category : #'initialize-release' }
MorphicAthensExample >> installSky [
	self window 
		addMorph: self simulationMorph
		fullFrame: (LayoutFrame identity topOffset: self toolbar minExtent y).
]

{ #category : #'initialize-release' }
MorphicAthensExample >> installToolbar [
	self window 
		addMorph: self toolbar
		fullFrame: ((0@0 corner: 1@0) asLayoutFrame bottomOffset: self toolbar minExtent y).
]

{ #category : #accessing }
MorphicAthensExample >> simulationMorph [
	^ simulationMorph ifNil: [ 
		  simulationMorph := BoidsSimulationMorph new ]
]

{ #category : #accessing }
MorphicAthensExample >> toolbar [
	^ toolbar ifNil: [ | tools |
		tools := self window newToolbar: {
			self window 
				newButtonFor: self simulationMorph
				getState: nil
				action: #startStepping
				arguments: nil
				getEnabled: nil
				label: 'Start '
				help: 'Let the boids fly' translated. 
			self window 
				newButtonFor: self simulationMorph
				getState: nil
				action: #stopStepping
				arguments: nil
				getEnabled: nil
				label: 'Stop '
				help: 'Freeze the boids' translated.
			self window
				newCheckboxFor: self simulationMorph model
				getSelected: #isCircling
				setSelected: #toggleCircling
				label: 'Circle around center'
				help: 'toggle circling' translated.
		}.
		toolbar := self window newToolDockingBar addMorph: tools]
]

{ #category : #accessing }
MorphicAthensExample >> window [
 	^ window ifNil: [
		window := StandardWindow labelled: 'Boids in Morphic+Athens'.
		window model: self.
		window announcer
			when: WindowResizing 
			do: [:ann | self simulationMorph extent: ann newSize].
		window]
]

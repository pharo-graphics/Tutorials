"
I'm a Spec2 interface for a BoidsSkyElement, with actions to live play with the simulation.

"
Class {
	#name : #BoidsSkyPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'toolbar',
		'skyPresenter',
		'toggleCirclingButton',
		'startButton',
		'stopButton',
		'stepButton',
		'boidsSkyElement'
	],
	#category : #'BlocTutorials-Boids-UI-Spec'
}

{ #category : #layout }
BoidsSkyPresenter class >> defaultLayout [

	^ SpBoxLayout newVertical
		add: #skyPresenter;
		yourself
]

{ #category : #examples }
BoidsSkyPresenter class >> exampleBloc1 [

	| app model presenter |
	app := SpApplication new
		       useBackend: #Morphic;
		       yourself.

	model := BoidsCustomDrawSkyElement new.
	presenter := self newApplication: app model: model.
	presenter open
]

{ #category : #examples }
BoidsSkyPresenter class >> exampleBloc2 [

	| app model presenter |
	app := SpApplication new
		       useBackend: #Morphic;
		       yourself.

	model := BoidsSkyUsingGeometryElement new.
	presenter := self newApplication: app model: model.
	presenter open
]

{ #category : #examples }
BoidsSkyPresenter class >> exampleBloc3 [

	| app model presenter |
	app := SpApplication new
		       useBackend: #Morphic;
		       yourself.

	model := BoidCustomGeometrySkyElement new.
	presenter := self newApplication: app model: model.
	presenter open
]

{ #category : #actions }
BoidsSkyPresenter >> doInspectSimulation [

	boidsSkyElement simulation inspect
]

{ #category : #actions }
BoidsSkyPresenter >> doStart [

	boidsSkyElement ensureStepping.
	self refreshToolbar
]

{ #category : #actions }
BoidsSkyPresenter >> doStep [

	boidsSkyElement move
	"No need to refresh toolbar in this case"
]

{ #category : #actions }
BoidsSkyPresenter >> doStop [

	boidsSkyElement ensureNotStepping.
	self refreshToolbar
]

{ #category : #actions }
BoidsSkyPresenter >> doToggleCircling [

	boidsSkyElement simulation toggleCircling.
	self refreshToolbar
]

{ #category : #initialization }
BoidsSkyPresenter >> initializePresenters [

	super initializePresenters.

	skyPresenter := self instantiate: SpBlSpaceInMorphPresenter.
	skyPresenter space root addChild: boidsSkyElement.
	
	self initializeToolbar.
	self refreshToolbar
]

{ #category : #initialization }
BoidsSkyPresenter >> initializeToolbar [

	toolbar := self newToolbar.

	toolbar addItem: (stopButton := self newToolbarButton
		action: [ self doStop ];
		label: 'Stop';
		help: 'Freeze the boids' translated;
		icon: (self iconNamed: #testRed);
		yourself).

	toolbar addItem: (startButton := self newToolbarButton
		action: [ self doStart ];
		label: 'Start';
		help: 'Let the boids fly' translated;
		icon: (self iconNamed: #testGreen);
		yourself).

	toolbar addItem: (stepButton := self newToolbarButton
		action: [ self doStep ];
		label: 'Step';
		help: 'Do one step' translated;
		icon: (self iconNamed: #smallRedo); "smallRedo testNotRun"
		yourself).

	toolbar addItem: (toggleCirclingButton := self newToolbarButton
		action: [ self doToggleCircling ];
		help: 'Toggle circling' translated;
		icon: (self iconNamed: #smallUpdate);
		yourself).

	toolbar addItem: (self newToolbarButton
		action: [ self doInspectSimulation ];
		help: 'Inspect' translated;
		icon: (self iconNamed: #smallInspectIt);
		yourself).

]

{ #category : #initialization }
BoidsSkyPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		centered;
		title: 'Boids';
		initialExtent: 510 @ 560;
		toolbar: toolbar
]

{ #category : #initialization }
BoidsSkyPresenter >> refreshToolbar [

	| isCircling |
	isCircling := boidsSkyElement simulation isNotNil
		and: [ boidsSkyElement simulation isCircling ].

	toggleCirclingButton label: 
		(isCircling
			ifTrue: [ 'Circling ON' ]
			ifFalse: [ 'Circling OFF' ]).

	startButton enabled: boidsSkyElement isStepping not.
	stepButton enabled: boidsSkyElement isStepping not.
	stopButton enabled: boidsSkyElement isStepping
]

{ #category : #initialization }
BoidsSkyPresenter >> setModelBeforeInitialization: aBoidsSkyElement [

	boidsSkyElement := aBoidsSkyElement.
	
	boidsSkyElement
		addEventHandlerOn: BlElementExtentChangedEvent
		doOnce: [ self refreshToolbar ]
]

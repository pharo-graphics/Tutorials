Class {
	#name : 'BaselineOfReorderingExamples',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfReorderingExamples',
	#package : 'BaselineOfReorderingExamples'
}

{ #category : 'baselines' }
BaselineOfReorderingExamples >> baseline: spec [
	<baseline>

	spec for: #common do: [ 
		spec
			baseline: 'Bloc'
			with: [ spec repository: 'github://pharo-graphics/bloc:dev-1.0/src' ].
		spec
			package: #'Bloc-Examples-Reordering' with: [
				spec requires: #( #'Bloc' ) ];
			package: #'Bloc-Examples-Reordering-Tests' with: [
				spec requires: #( #'Bloc-Examples-Reordering' ) ]
		]
]

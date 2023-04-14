Class {
	#name : #BaselineOfReorderingExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfReorderingExamples
}

{ #category : #baselines }
BaselineOfReorderingExamples >> baseline: spec [
	<baseline>

	spec for: #common do: [ 
		spec
			baseline: 'BlocPac'
			with: [ spec repository: 'github://pharo-graphics/bloc-pac:dev-1.0/src' ].
		spec
			package: #'Bloc-Examples-Reordering' with: [
				spec requires: #( #'BlocPac' ) ];
			package: #'Bloc-Examples-Reordering-Tests' with: [
				spec requires: #( #'Bloc-Examples-Reordering' ) ]
		]
]

"
I'm an example of drawing boids simulation by overriding canvas drawing hooks.

See an example on class side.
"
Class {
	#name : #BoidsCustomDrawSkyElement,
	#superclass : #BoidsSkyElement,
	#category : #'BlocTutorials-Boids-UI-Bloc'
}

{ #category : #examples }
BoidsCustomDrawSkyElement class >> exampleOpenInNewSpace [

	^ self new openInNewSpace
]

{ #category : #'drawing - Alexandrie' }
BoidsCustomDrawSkyElement >> aeDrawGeometryOn: aeCanvas [

	super aeDrawGeometryOn: aeCanvas.
	
	simulation boids do: [ :each |
		aeCanvas restoreContextAfter: [
			self aeDrawOn: aeCanvas bodyOf: each.
			self aeDrawOn: aeCanvas velocityOf: each ] ].

]

{ #category : #'drawing - Alexandrie' }
BoidsCustomDrawSkyElement >> aeDrawOn: aeCanvas bodyOf: aBoid [

	aeCanvas 
		pathFactory: [ :cairoContext |
			cairoContext
				circleCenterX: aBoid position x
				y: aBoid position y
				radius: aBoid radius ];
		setBackgroundWith: [
			aeCanvas setSourceColor: aBoid color ];
		setOutskirtsCentered;
		setBorderBlock: [
			aeCanvas setSourceColor: aBoid color muchDarker.
			aeCanvas setBorderWidth: 1 ];
		drawFigure

]

{ #category : #'drawing - Alexandrie' }
BoidsCustomDrawSkyElement >> aeDrawOn: aeCanvas velocityOf: aBoid [

	aeCanvas
		pathFactory: [ :cairoContext |
			cairoContext
				moveTo: aBoid position;
				relativeLineTo: aBoid velocity negated ];
		setBackgroundOff;
		setOutskirtsCentered;
		setBorderBlock: [
			aeCanvas
				setSourceColor: aBoid color muchDarker;
				setBorderWidth: 1 ];
		drawFigure

]

{ #category : #initialization }
BoidsCustomDrawSkyElement >> boidWasAddedToSimulation: aBoid [

	self
		invalidate;
		requestLayout
]

instance creation
open
	<example>
	| space |
	space := BlSpace new.
	space extent: 420@420.
	space root addChild: (MgElementExamples>>#grid:for:) gtExampleValue.
	space show
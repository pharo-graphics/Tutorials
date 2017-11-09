drawing
drawCommonOn: aCanvas
	aCanvas fill
		paint: self backgroundPaint;
		path: self boundsInLocal;
		draw
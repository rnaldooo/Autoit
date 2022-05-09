void resizeEvent(QResizeEvent *) {
;### Tidy Error: If/ElseIf statement without a then..
If (size() ! = qApp - > desktop() - > size()) {
	 / / Widget is Not the correct size, so Do the fullscreen magic
	enableFullscreen();
	}
	}
	void focusInEvent(QFocusEvent *) {
	 / / Always Do it here, no matter the size.
	enableFullscreen();
	}
	void enableFullscreen() {
	 / / Make sure size is correct
	setFixedSize(qApp - > desktop() - > size());
	 / / This call is needed because showFullScreen won't work
	 / / correctly If the widget already considers itself To be fullscreen.
	showNormal();
	 / / This is needed because showNormal() forcefully changes the window
	 / / style To WSTyle_TopLevel.
	reparent(0, WStyle_Customize | WStyle_NoBorder, QPoint(0, 0));
	 / / Enable fullscreen.
	showFullScreen();
	};### Tidy Error -> if is never closed in your script.

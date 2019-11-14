#INCLUDE 'TOTVS.CH'

User Function DkQuery()

	Local oDlg := GetDialog()





	oDlg:Activate()

Return

Static Function GetDialog( oDlg, nTop, nLeft, nBottom, nRight, cCaption, lPixel )

	Local oDialog := Nil
	Local oSize   := FwDefSize():New( .F. )

	oSize:Process()

	Default nTop     := oSize:aWindSize[1]
	Default nLeft    := oSize:aWindSize[2]
	Default nBottom  := oSize:aWindSize[3]
	Default nRight   := oSize:aWindSize[4]
	Default cCaption := ''
	Default lPixel   := .T.

	oDialog := MsDialog():New(;
	/* nTop */         nTop ,;
	/* nLeft */       nLeft ,;
	/* nBottom */   nBottom ,;
	/* nRight */     nRight ,;
	/* cCaption */ cCaption ,;
	/* uParam6 */           ,;
	/* uParam7 */           ,;
	/* uParam8 */           ,;
	/* uParam9 */           ,;
	/* nClrText */          ,;
	/* nClrBack */          ,;
	/* uParam12 */          ,;
	/* oWnd */              ,;
	/* lPixel */     lPixel ,;
	/* uParam15 */          ,;
	/* uParam16 */          ,;
	/* uParam17 */          ,;
	/* lTransparent */       )

Return oDialog
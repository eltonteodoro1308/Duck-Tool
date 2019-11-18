#INCLUDE 'TOTVS.CH'

User Function DkQuery()

	Private oDialog   := Nil
	Private oMultiGet := Nil
	Private oSize     := FwDefSize():New( .F. )

	oSize:AddObject ( 'MEMO', 90, 90, .T., .T. )

	oSize:Process()

	BuildDialog()
	BuildMemo()

	oDialog:Activate()

Return

Static Function BuildDialog()

	oDialog := MsDialog():New(;
	/* nTop */     oSize:aWindSize[1] ,;
	/* nLeft */    oSize:aWindSize[2] ,;
	/* nBottom */  oSize:aWindSize[3] ,;
	/* nRight */   oSize:aWindSize[4] ,;
	/* cCaption */                 '' ,;
	/* uParam6 */                     ,;
	/* uParam7 */                     ,;
	/* uParam8 */                     ,;
	/* uParam9 */                     ,;
	/* nClrText */                    ,;
	/* nClrBack */                    ,;
	/* uParam12 */                    ,;
	/* oWnd */                        ,;
	/* lPixel */                  .T. ,;
	/* uParam15 */                    ,;
	/* uParam16 */                    ,;
	/* uParam17 */                    ,;
	/* lTransparent */                 )

Return

Static Function BuildMemo()

	oMultiGet := TMultiGet():New(;
	/* nRow */    oSize:GetDimension( 'MEMO', 'LININI' ) ,;
	/* nCol */    oSize:GetDimension( 'MEMO', 'COLINI' ) ,;
	/* bSetGet */                                        ,;
	/* oWnd */                                   oDialog ,;
	/* nWidth */  oSize:GetDimension( 'MEMO', 'COLEND' ) ,;
	/* nHeight */ oSize:GetDimension( 'MEMO', 'LINEND' ) ,;
	/* oFont */       TFont():New( 'Courier new',,-16, ) ,;
	/* uParam8 */                                        ,;
	/* uParam9 */                                        ,;
	/* uParam10 */                                       ,;
	/* uParam11 */                                       ,;
	/* lPixel */                                     .T. ,;
	/* uParam13 */                                       ,;
	/* uParam14 */                                       ,;
	/* bWhen */                                          ,;
	/* uParam16 */                                       ,;
	/* uParam17 */                                       ,;
	/* lReadOnly */                                      ,;
	/* bValid */                                         ,;
	/* uParam20 */                                       ,;
	/* uParam21 */                                       ,;
	/* lNoBorder */                                      ,;
	/* lVScroll */                                   .T. ,;
	/* cLabelText */                                     ,;
	/* nLabelPos */                                      ,;
	/* oLabelFont */                                     ,;
	/* nLabelColor */                                     )

Return
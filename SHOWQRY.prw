#INCLUDE 'TOTVS.CH'

User function SHOWQRY()

	Local oMsDialog  := GetDialog()
	Local cTrab      := ''
	Local cQuery     := 'SELECT ** FROM SX5990'
	Local oBrGetDDB  := Nil
	Local oTempTable := FWTemporaryTable():New()
	Local cTempTable := ''
	Local aStruct    := Nil
	Local nX         := 0

	ErrorBlock( {|oErro| VerErro( oErro ) } )

	cTrab :=  MPSysOpenQuery( cQuery )

	aStruct := aClone( ( cTrab )->( DbStruct() ) )

	aSize( aStruct, Len( aStruct ) - 2 )

	oTempTable:SetFields( aStruct )
	oTempTable:Create()

	cTempTable := oTempTable:GetAlias( )

	(cTrab)->( DbGoTop() )

	Do While (cTrab)->( ! Eof() )

		RecLock( cTempTable, .T. )

		For nX := 1 To Len( aStruct )

			( cTempTable )->&( aStruct[ nX, 1 ] ) := ( cTrab )->&( aStruct[ nX, 1 ] )

		Next nX

		( cTempTable )->( MsUnlock() )

		(cTrab)->( DbSkip() )

	End Do

	//cTrab->( DbCloseArea() )

	oBrGetDDB  := GetBrowse( oMsDialog, cTempTable )

	oMsDialog:Activate(,,,.T.,,,{||oBrGetDDB:GoTop(),.T.})

	oTempTable:Delete()

Return

Static Function GetDialog()

	Local oDialog := MsDialog():New(;
	/* nTop */         000,;
	/* nLeft */        000,;
	/* nBottom */      500,;
	/* nRight */       500,;
	/* cCaption */     '' ,;
	/* uParam6 */         ,;
	/* uParam7 */         ,;
	/* uParam8 */         ,;
	/* uParam9 */         ,;
	/* nClrText */        ,;
	/* nClrBack */        ,;
	/* uParam12 */        ,;
	/* oWnd */            ,;
	/* lPixel */          ,;
	/* uParam15 */        ,;
	/* uParam16 */        ,;
	/* uParam17 */        ,;
	/* lTransparent */     )


Return oDialog

Static Function GetBrowse( oMsDialog, cTrab )

	Local nX        := 0
	Local oBrGetDDB := BrGetDDB():new(;
	/* nRow */       000,;
	/* nCol */       000,;
	/* nWidth */     450,;
	/* nHeight */    300,;
	/* bLine */      ,;
	/* aHeaders */   ,;
	/* aColSizes */  ,;
	/* oWnd */       oMsDialog,;
	/* cField */     ,;
	/* uVal1 */      ,;
	/* uVal2 */      ,;
	/* bChange */    ,;
	/* bLDblClick */ ,;
	/* bRClick */    ,;
	/* oFont */      ,;
	/* oCursor */    ,;
	/* nClrFore */   ,;
	/* nClrBack */   ,;
	/* cMsg */       ,;
	/* uParam1 */    ,;
	/* cAlias */     cTrab,;
	/* lPixel */     ,;
	/* bWhen */      ,;
	/* uParam2 */    ,;
	/* bValid */     ,;
	/* uParam3 */    ,;
	/* uParam4 */     )

	For nX := 1 To ( cTrab )->( FCount() )

		oBrGetDDB:addColumn( GetColumn( cTrab, ( cTrab )->( FieldName( nX ) ) ) )

	Next nX

Return oBrGetDDB

Static Function GetColumn( cTrab, cColumn )

Return TCColumn():New(;
/* cTitulo */     cColumn,;
/* bData */       &('{||("' + Alltrim( cTrab ) + '")->' + AllTrim( cColumn ) + ' }'),;
/* cPicture */    ,;
/* uParam4 */     ,;
/* uParam5 */     ,;
/* cAlinhamento */,;
/* nLargura */    ,;
/* lBitmap */     ,;
/* lEdit */       ,;
/* uParam10 */    ,;
/* bValid */      ,;
/* uParam12 */    ,;
/* uParam13 */    ,;
/* uParam14 */     )

Static Function VerErro( oErro )

	AutoGrLog( oErro:Description )

	MostraErro()

Return
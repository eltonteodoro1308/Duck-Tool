#INCLUDE 'TOTVS.CH'
#INCLUDE 'VKEY.CH'

User Function DkQuery()

	Local oSize     := Nil
	Local oDialog   := Nil
	Local oMultiGet := Nil
	Local cMultiGet := ''
	Local oMultiBtn := Nil
	Local aMultiBtn := {}
	Local nX        := 0

	oSize := FwDefSize():New( .F. )
	oSize:AddObject ( 'MULTIBTN', 000, 025, .T., .F. )
	oSize:AddObject ( 'MULTIGET', 000, 000, .T., .T. )
	oSize:Process()

	oDialog := MsDialog():New(;
	/* nTop         */ oSize:aWindSize[ 1 ] ,;
	/* nLeft        */ oSize:aWindSize[ 2 ] ,;
	/* nBottom      */ oSize:aWindSize[ 3 ] ,;
	/* nRight       */ oSize:aWindSize[ 4 ] ,;
	/* cCaption     */                   '' ,;
	/* uParam6      */                      ,;
	/* uParam7      */                      ,;
	/* uParam8      */                      ,;
	/* uParam9      */                      ,;
	/* nClrText     */                      ,;
	/* nClrBack     */                      ,;
	/* uParam12     */                      ,;
	/* oWnd         */                      ,;
	/* lPixel       */                  .T. ,;
	/* uParam15     */                      ,;
	/* uParam16     */                      ,;
	/* uParam17     */                      ,;
	/* lTransparent */                       )

	oMultiGet := TMultiGet():New(;
	/* nRow        */               oSize:GetDimension( 'MULTIGET', 'LININI' ) ,;
	/* nCol        */               oSize:GetDimension( 'MULTIGET', 'COLINI' ) ,;
	/* bSetGet     */ { | U | If( PCount() == 0, cMultiGet, cMultiGet := U ) } ,;
	/* oWnd        */                                                  oDialog ,;
	/* nWidth      */                oSize:GetDimension( 'MULTIGET', 'XSIZE' ) ,;
	/* nHeight     */                oSize:GetDimension( 'MULTIGET', 'YSIZE' ) ,;
	/* oFont       */                       TFont():New( 'Courier new',,-14, ) ,;
	/* uParam8     */                                                          ,;
	/* uParam9     */                                                          ,;
	/* uParam10    */                                                          ,;
	/* uParam11    */                                                          ,;
	/* lPixel      */                                                      .T. ,;
	/* uParam13    */                                                          ,;
	/* uParam14    */                                                          ,;
	/* bWhen       */                                                          ,;
	/* uParam16    */                                                          ,;
	/* uParam17    */                                                          ,;
	/* lReadOnly   */                                                          ,;
	/* bValid      */                                                          ,;
	/* uParam20    */                                                          ,;
	/* uParam21    */                                                          ,;
	/* lNoBorder   */                                                          ,;
	/* lVScroll    */                                                      .T. ,;
	/* cLabelText  */                                                          ,;
	/* nLabelPos   */                                                          ,;
	/* oLabelFont  */                                                          ,;
	/* nLabelColor */                                                           )

	oMultiBtn := TMultiBtn():New(;
	/* nRow        */    oSize:GetDimension( 'MULTIBTN', 'LININI' ) ,;
	/* nCol        */    oSize:GetDimension( 'MULTIBTN', 'COLINI' ) ,;
	/* cCaption    */                                            '' ,;
	/* oWnd        */                                       oDialog ,;
	/* bAction     */ { | oObj, nItem | Eval( aMultiBtn[ nItem, 3 ] ) } ,;
	/* nWidth      */     oSize:GetDimension( 'MULTIBTN', 'XSIZE' ) ,;
	/* nHeight     */     oSize:GetDimension( 'MULTIBTN', 'YSIZE' ) ,;
	/* cimgName    */                                        'FORM' ,;
	/* nOri        */                                             0 ,;
	/* cMsg        */                                            '' ,;
	/* nBtnPerLine */                                            10  )

	oMultiBtn:SetFonts( 'Courier new', 10,'Courier new', 10 )

	//	aAdd( aMultiBtn, { '<F1> Help'      , VK_F1, { || ExecF1() } } )
	//	aAdd( aMultiBtn, { '<F2> Abrir'     , VK_F2, { || ExecF2() } } )
	//	aAdd( aMultiBtn, { '<F3> Salvar'    , VK_F3, { || ExecF3() } } )
	//	aAdd( aMultiBtn, { '<F4> CSV'       , VK_F4, { || ExecF4() } } )
	aAdd( aMultiBtn, { '<F5> Executar'  , VK_F5, { || ExecF5( cMultiGet ) } } )
	//	aAdd( aMultiBtn, { '<F6> Par�metros', VK_F6, { || ExecF6() } } )
	//	aAdd( aMultiBtn, { '<F7> Hist�rico' , VK_F7, { || ExecF7() } } )

	For nX := 1 To Len( aMultiBtn )

		oMultiBtn:AddButton( aMultiBtn[ nX, 1 ] )

		SetKey ( aMultiBtn[ nX, 2 ], aMultiBtn[ nX, 3 ] )

	Next nX

	oDialog:Activate()

	For nX := 1 To Len( aMultiBtn )

		SetKey ( aMultiBtn[ nX, 2 ], {||} )

	Next nX

Return

Static Function ExecF5( cQuery )

	Local oSize     := Nil
	Local oDialog   := Nil
	Local oMultiGet := Nil
	Local cMultiGet := ''
	Local oMultiBtn := Nil
	Local aMultiBtn := {}
	Local nX        := 0
	Local cErro     := ''
	Local bError    := ErrorBlock( { | oErro | cErro := oErro:Description } )
	Local cTrab     := ''
	Local oBrowse   := Nil
	Local aBrowse   := {}
	Local aHeaders  := {}
	Local bLine     := Nil

	MsgRun ( 'Banco de Dados Processando a Query ...', 'Aguarde ...', { | | cTrab := MpSysOpenQuery( cQuery ) } )

	oSize := FwDefSize():New( .F. )
	oSize:AddObject ( 'MULTIBTN', 000, 025, .T., .F. )
	oSize:AddObject ( 'RESULT'  , 000, 000, .T., .T. )
	oSize:Process()

	oDialog := MsDialog():New(;
	/* nTop         */ oSize:aWindSize[ 1 ] ,;
	/* nLeft        */ oSize:aWindSize[ 2 ] ,;
	/* nBottom      */ oSize:aWindSize[ 3 ] ,;
	/* nRight       */ oSize:aWindSize[ 4 ] ,;
	/* cCaption     */                   '' ,;
	/* uParam6      */                      ,;
	/* uParam7      */                      ,;
	/* uParam8      */                      ,;
	/* uParam9      */                      ,;
	/* nClrText     */                      ,;
	/* nClrBack     */                      ,;
	/* uParam12     */                      ,;
	/* oWnd         */                      ,;
	/* lPixel       */                  .T. ,;
	/* uParam15     */                      ,;
	/* uParam16     */                      ,;
	/* uParam17     */                      ,;
	/* lTransparent */                       )

	If ! Empty( cErro )

		cMultiGet := cErro

		oMultiGet := TMultiGet():New(;
		/* nRow        */                 oSize:GetDimension( 'RESULT', 'LININI' ) ,;
		/* nCol        */                 oSize:GetDimension( 'RESULT', 'COLINI' ) ,;
		/* bSetGet     */ { | U | If( PCount() == 0, cMultiGet, cMultiGet := U ) } ,;
		/* oWnd        */                                                  oDialog ,;
		/* nWidth      */                  oSize:GetDimension( 'RESULT', 'XSIZE' ) ,;
		/* nHeight     */                  oSize:GetDimension( 'RESULT', 'YSIZE' ) ,;
		/* oFont       */                       TFont():New( 'Courier new',,-14, ) ,;
		/* uParam8     */                                                          ,;
		/* uParam9     */                                                          ,;
		/* uParam10    */                                                          ,;
		/* uParam11    */                                                          ,;
		/* lPixel      */                                                      .T. ,;
		/* uParam13    */                                                          ,;
		/* uParam14    */                                                          ,;
		/* bWhen       */                                                          ,;
		/* uParam16    */                                                          ,;
		/* uParam17    */                                                          ,;
		/* lReadOnly   */                                                      .T. ,;
		/* bValid      */                                                          ,;
		/* uParam20    */                                                          ,;
		/* uParam21    */                                                          ,;
		/* lNoBorder   */                                                          ,;
		/* lVScroll    */                                                      .T. ,;
		/* cLabelText  */                                                          ,;
		/* nLabelPos   */                                                          ,;
		/* oLabelFont  */                                                          ,;
		/* nLabelColor */                                                           )

		cErro := ''

	Else

		oBrowse := TWBrowse():New(;
		/* nRow       */ oSize:GetDimension( 'RESULT', 'LININI' ) ,;
		/* nCol       */ oSize:GetDimension( 'RESULT', 'COLINI' ) ,;
		/* nWidth     */  oSize:GetDimension( 'RESULT', 'XSIZE' ) ,;
		/* nHeight    */  oSize:GetDimension( 'RESULT', 'YSIZE' ) ,;
		/* bLine      */                                          ,;
		/* aHeaders   */                                 aHeaders ,;
		/* aColSizes  */                                          ,;
		/* oDlg       */                                  oDialog ,;
		/* cField     */                                          ,;
		/* uValue1    */                                          ,;
		/* uValue2    */                                          ,;
		/* bChange    */                                          ,;
		/* bLDblClick */                                          ,;
		/* bRClick    */                                          ,;
		/* oFont      */       TFont():New( 'Courier new',,-14, ) ,;
		/* oCursor    */                                          ,;
		/* nClrFore   */                                          ,;
		/* nClrBack   */                                          ,;
		/* cMsg       */                                          ,;
		/* uParam20   */                                          ,;
		/* cAlias     */                                          ,;
		/* lPixel     */                                      .T. ,;
		/* bWhen      */                                          ,;
		/* uParam24   */                                          ,;
		/* bValid     */                                          ,;
		/* lHScroll   */                                      .T. ,;
		/* lVScroll   */                                      .T.  )

		MsgRun ( 'Montando Browse de Exibi��o ...', 'Aguarde ...', { | | BrowseF5( cTrab, aBrowse, oBrowse ) } )

		oBrowse:SetArray( aBrowse )

		bLine := '{||{'

		For nX := 1 To ( cTrab )->( FCount() )

			aAdd( aHeaders, ( cTrab )->( FieldName( nX ) ) )

			bLine += 'aBrowse[ oBrowse:nAt, ' + cValToChar( nX ) + ']'

			If nX < ( cTrab )->( FCount() )

				bLine += ','

			End If

		Next nX

		bLine += '}}'

		bLine := &( bLine )

		oBrowse:bLine := bLine

	End If

	oDialog:Activate()

	If Select( cTrab ) > 0

		( cTrab )->( DbCloseArea() )

	End If

	ErrorBlock( bError )

Return

Static Function BrowseF5( cTrab, aBrowse, oBrowse )

	Local aAux := {}
	Local nX   := nX

	( cTrab )->( DbGoTop() )

	Do While ! ( cTrab )->( Eof() )

		For nX := 1 To ( cTrab )->( FCount() )

			aAdd( aAux, ( cTrab )->&( FieldName( nX ) ) )

		Next nX

		aAdd( aBrowse, aClone( aAux ) )

		aSize( aAux, 0 )

		( cTrab )->( DbSkip() )

	End Do

Return

//	AutoGrLog( cMultiGet )
//
//	MostraErro()
//	If y = 1
//
//		cMultiGet := "Lorem ipsum fames cras dictumst non mollis id, taciti vel semper commodo interdum ad, eros rhoncus sapien curabitur pulvinar dictumst. neque non luctus vehicula imperdiet conubia netus quis torquent cubilia, vulputate quisque varius torquent posuere etiam maecenas integer. congue quisque volutpat lorem est erat dui posuere, malesuada aliquet etiam velit eget varius neque nisi, lacus tellus enim consequat tincidunt pellentesque. nisl ad at vehicula cursus duis himenaeos, nunc nostra maecenas euismod nibh, lorem per sociosqu himenaeos ullamcorper. nibh curabitur netus vivamus neque quisque venenatis blandit urna per odio, porttitor eleifend etiam porta massa sit nunc arcu. "
//
//	elseif y = 2
//
//		oMultiGet:SetFont( TFont():New( 'Consolas',,-18, ) )
//
//	endif
//
//	oMultiGet:Refresh()


#INCLUDE 'TOTVS.CH'
#INCLUDE 'VKEY.CH'

User Function DkQuery()

	Local oDefSize  := FwDefSize():New( .F. )
	Local nRow      := 0
	Local nCol      := 0
	Local nWidth    := 0
	Local nHeight   := 0
	Local oDlgMain  := Nil
	Local oMultiGet := Nil
	Local cMultiGet := ''
	Local oFont     := TFont():New( 'Courier new',,-14, )
	Local oMultiBtn := Nil
	Local aMultiBtn := {}
	Local bMultiBtn := { | oObj, nItem | Eval( aMultiBtn[ nItem, 3 ] ) }
	Local nX        := 0

	oDefSize:AddObject ( 'MULTIBTN', 000, 025, .T., .F. )
	oDefSize:AddObject ( 'MULTIGET', 000, 000, .T., .T. )
	oDefSize:Process()

	nRow    := oDefSize:aWindSize[ 1 ]
	nCol    := oDefSize:aWindSize[ 2 ]
	nWidth  := oDefSize:aWindSize[ 3 ]
	nHeight := oDefSize:aWindSize[ 4 ]

	DEFINE MSDIALOG oDlgMain TITLE '' FROM nRow, nCol TO nWidth, nHeight PIXEL

	nRow    := oDefSize:GetDimension( 'MULTIGET', 'LININI' )
	nCol    := oDefSize:GetDimension( 'MULTIGET', 'COLINI' )
	nWidth  := oDefSize:GetDimension( 'MULTIGET', 'XSIZE'  )
	nHeight := oDefSize:GetDimension( 'MULTIGET', 'YSIZE'  )

	@ nRow, nCol GET oMultiGet VAR cMultiGet OF oDlgMain MULTILINE SIZE nWidth, nHeight FONT oFont HSCROLL PIXEL

	nRow    := oDefSize:GetDimension( 'MULTIBTN', 'LININI' )
	nCol    := oDefSize:GetDimension( 'MULTIBTN', 'COLINI' )
	nWidth  := oDefSize:GetDimension( 'MULTIBTN', 'XSIZE'  )
	nHeight := oDefSize:GetDimension( 'MULTIBTN', 'YSIZE'  )

	oMultiBtn := TMultiBtn():New(;
	/* nRow        */      nRow ,;
	/* nCol        */      nCol ,;
	/* cCaption    */        '' ,;
	/* oWnd        */  oDlgMain ,;
	/* bAction     */ bMultiBtn ,;
	/* nWidth      */    nWidth ,;
	/* nHeight     */   nHeight ,;
	/* cimgName    */    'FORM' ,;
	/* nOri        */         0 ,;
	/* cMsg        */        '' ,;
	/* nBtnPerLine */        10  )

	oMultiBtn:SetFonts( 'Courier new', 10,'Courier new', 10 )

	//	aAdd( aMultiBtn, { '<F1> Help'      , VK_F1, { || ExecF1() } } )
	//	aAdd( aMultiBtn, { '<F2> Abrir'     , VK_F2, { || ExecF2() } } )
	//	aAdd( aMultiBtn, { '<F3> Salvar'    , VK_F3, { || ExecF3() } } )
	//	aAdd( aMultiBtn, { '<F4> CSV'       , VK_F4, { || ExecF4() } } )
	aAdd( aMultiBtn, { '<F5> Executar'  , VK_F5, { || ExecF5( cMultiGet ) } } )
	//	aAdd( aMultiBtn, { '<F6> Parâmetros', VK_F6, { || ExecF6() } } )
	//	aAdd( aMultiBtn, { '<F7> Histórico' , VK_F7, { || ExecF7() } } )

	For nX := 1 To Len( aMultiBtn )

		oMultiBtn:AddButton( aMultiBtn[ nX, 1 ] )

		SetKey ( aMultiBtn[ nX, 2 ], aMultiBtn[ nX, 3 ] )

	Next nX

	ACTIVATE DIALOG oDlgMain CENTERED

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

		MsgRun ( 'Montando Browse de Exibição ...', 'Aguarde ...', { | | BrowseF5( cTrab, aBrowse, oBrowse ) } )

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

Static Function GeraPlan()

	Local cFile     := GetTempPath( .T. ) + GetNextAlias() + '.csv'
	Local nHandle   := FCreate( cFile )
	Local cBuffer   := ''
	Local cAux      := ''
	Local nQtdBytes := 0
	Local nX        := 0

	If nHandle # -1

		//-- Gera Cabeçalho do arquivo
		For nX := 1 To ( cTrab )->( FCount() )

			cBuffer += ( cTrab )->( FieldName( nX ) )

			If nX < ( cTrab )->( FCount() )

				cBuffer += ";"

			End If

		Next nX

		cBuffer += CRLF

		nQtdBytes := Len( cBuffer )

		FSeek(nHandle, 0, FS_END)

		FWrite( nHandle, cBuffer, nQtdBytes )

		cBuffer := ''

		//-- Gera dados do arquivo
		( cTrab )->( DbGoTop() )

		Do While ! ( cTrab )->( Eof() )

			For nX := 1 To ( cTrab )->( FCount() )

				If ValType( ( cTrab )->&( FieldName( nX ) ) ) == 'N'

					cAux := cValTochar( ( cTrab )->&( FieldName( nX ) ) )

					cAux := StrTran( cAux, '.', ',' )

					cBuffer += '"'
					cBuffer += cAux
					cBuffer +=  '"'

				Else

					cBuffer += '="'
					cBuffer +=  cValTochar( ( cTrab )->&( FieldName( nX ) ) )
					cBuffer +=  '"'

				End If

				If nX < ( cTrab )->( FCount() )

					cBuffer += ";"

				End If

			Next nX

			cBuffer += CRLF

			nQtdBytes := Len( cBuffer )

			FSeek(nHandle, 0, FS_END)

			FWrite( nHandle, cBuffer, nQtdBytes )

			cBuffer := ''

			( cTrab )->( DbSkip() )

		End Do

	Else

	End If

	FClose( nHandle )

	ShellExecute( 'Open', cFile, '', '', 1 )

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


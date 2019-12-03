#INCLUDE 'TOTVS.CH'
#INCLUDE 'FILEIO.CH'

User Function DkQuery()

	Local oDfSzDlg := FwDefSize():New( .F. )
	Local oDfSzBtn := FwDefSize():New( .F. )
	Local nRow     := 0
	Local nCol     := 0
	Local nWidth   := 0
	Local nHeight  := 0
	Local oDlg     := Nil
	Local oBtnQry  := Nil
	Local oBtnEnd  := Nil
	Local oGet     := Nil
	Local cGet     := ''
	Local oFontGet := TFont():New( 'Courier new',,-14, )
	Local oFontBtn := TFont():New( 'Courier new',,-12, )

	oDfSzDlg:AddObject ( 'oBtn', 000, 015, .T., .F. )
	oDfSzDlg:AddObject ( 'oGet', 000, 000, .T., .T. )
	oDfSzDlg:Process()

	oDfSzBtn:AddObject ( 'oBtnQry', 050, 015, .F., .F. )
	oDfSzBtn:AddObject ( 'oBtnEnd', 050, 015, .F., .F. )
	oDfSzBtn:lLateral := .T.
	oDfSzBtn:Process()

	nRow    := oDfSzDlg:aWindSize[ 1 ]
	nCol    := oDfSzDlg:aWindSize[ 2 ]
	nWidth  := oDfSzDlg:aWindSize[ 3 ]
	nHeight := oDfSzDlg:aWindSize[ 4 ]

	DEFINE MSDIALOG oDlg TITLE '' FROM nRow, nCol TO nWidth, nHeight PIXEL

	nRow    := oDfSzBtn:GetDimension( 'oBtnQry', 'LININI' )
	nCol    := oDfSzBtn:GetDimension( 'oBtnQry', 'COLINI' )
	nWidth  := oDfSzBtn:GetDimension( 'oBtnQry', 'XSIZE'  )
	nHeight := oDfSzBtn:GetDimension( 'oBtnQry', 'YSIZE'  )

	@ nRow, nCol BUTTON oBtnQry PROMPT 'QUERY'	SIZE nWidth, nHeight OF oDlg FONT oFontBtn ACTION {|| ProcQry( cGet ) } PIXEL

	nRow    := oDfSzBtn:GetDimension( 'oBtnEnd', 'LININI' )
	nCol    := oDfSzBtn:GetDimension( 'oBtnEnd', 'COLINI' )
	nWidth  := oDfSzBtn:GetDimension( 'oBtnEnd', 'XSIZE'  )
	nHeight := oDfSzBtn:GetDimension( 'oBtnEnd', 'YSIZE'  )

	@ nRow, nCol BUTTON oBtnEnd PROMPT 'FECHAR' SIZE nWidth, nHeight OF oDlg FONT oFontBtn ACTION {|| oDlg:End() } PIXEL

	nRow    := oDfSzDlg:GetDimension( 'oGet', 'LININI' )
	nCol    := oDfSzDlg:GetDimension( 'oGet', 'COLINI' )
	nWidth  := oDfSzDlg:GetDimension( 'oGet', 'XSIZE'  )
	nHeight := oDfSzDlg:GetDimension( 'oGet', 'YSIZE'  )

	@ nRow,	nCol GET oGet VAR cGet OF oDlg MULTILINE SIZE nWidth, nHeight FONT oFontGet HSCROLL PIXEL

	ACTIVATE DIALOG oDlg CENTERED

Return

Static Function ProcQry( cQuery )

	Local cErro  := ''
	Local bError := ErrorBlock( { | oErro | cErro := oErro:Description } )

	Private cTrab  := ''

	MsgRun ( 'Banco de Dados Processando a Query ...', 'Aguarde ...', { | | cTrab := MpSysOpenQuery( cQuery ) } )

	If ! Empty( cErro )

		AutoGrLog( cErro )
		MostraErro()

	Else

		MsgRun ( 'Montando Browse de Exibição ...', 'Aguarde ...', { | | ShowBrw() } )

	End If

	ErrorBlock( bError )

Return

Static Function ShowBrw()

	Local oDfSzDlg := FwDefSize():New( .F. )
	Local oDfSzBtn := FwDefSize():New( .F. )
	Local nRow     := 0
	Local nCol     := 0
	Local nWidth   := 0
	Local nHeight  := 0
	Local oDlg     := Nil
	Local oBtnCsv  := Nil
	Local oBtnEnd  := Nil
	Local oGet     := Nil
	Local cGet     := ''
	Local oBrowse   := Nil
	Local aBrowse   := {}
	Local aAux      := {}
	Local aHeaders  := {}
	Local bLine     := Nil
	Local oFontGet := TFont():New( 'Courier new',,-14, )
	Local oFontBtn := TFont():New( 'Courier new',,-12, )
	Local oFontBrw := TFont():New( 'Courier new',,-12, )
	Local nX        := 0

	oDfSzDlg:AddObject ( 'oBtn'   , 000, 015, .T., .F. )
	oDfSzDlg:AddObject ( 'oBrowse', 000, 000, .T., .T. )
	oDfSzDlg:Process()

	oDfSzBtn:AddObject ( 'oBtnCsv', 050, 015, .F., .F. )
	oDfSzBtn:AddObject ( 'oBtnEnd', 050, 015, .F., .F. )
	oDfSzBtn:lLateral := .T.
	oDfSzBtn:Process()

	nRow    := oDfSzDlg:aWindSize[ 1 ]
	nCol    := oDfSzDlg:aWindSize[ 2 ]
	nWidth  := oDfSzDlg:aWindSize[ 3 ]
	nHeight := oDfSzDlg:aWindSize[ 4 ]

	DEFINE MSDIALOG oDlg TITLE '' FROM nRow, nCol TO nWidth, nHeight PIXEL

	nRow    := oDfSzBtn:GetDimension( 'oBtnCsv', 'LININI' )
	nCol    := oDfSzBtn:GetDimension( 'oBtnCsv', 'COLINI' )
	nWidth  := oDfSzBtn:GetDimension( 'oBtnCsv', 'XSIZE'  )
	nHeight := oDfSzBtn:GetDimension( 'oBtnCsv', 'YSIZE'  )

	@ nRow, nCol BUTTON oBtnCsv PROMPT 'CSV' SIZE nWidth, nHeight OF oDlg FONT oFontBtn;
	ACTION {|| MsgRun ( 'Gerando Arquivo ...', 'Aguarde ...', { | | ProcCsv() } ) } PIXEL


	nRow    := oDfSzBtn:GetDimension( 'oBtnEnd', 'LININI' )
	nCol    := oDfSzBtn:GetDimension( 'oBtnEnd', 'COLINI' )
	nWidth  := oDfSzBtn:GetDimension( 'oBtnEnd', 'XSIZE'  )
	nHeight := oDfSzBtn:GetDimension( 'oBtnEnd', 'YSIZE'  )

	@ nRow, nCol BUTTON oBtnEnd PROMPT 'FECHAR' SIZE nWidth, nHeight OF oDlg FONT oFontBtn ACTION {|| oDlg:End() } PIXEL

	( cTrab )->( DbGoTop() )

	Do While ! ( cTrab )->( Eof() )

		For nX := 1 To ( cTrab )->( FCount() )

			aAdd( aAux, ( cTrab )->&( FieldName( nX ) ) )

		Next nX

		aAdd( aBrowse, aClone( aAux ) )

		aSize( aAux, 0 )

		( cTrab )->( DbSkip() )

	End Do

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

	oBrowse := TWBrowse():New(;
	/* nRow       */ oDfSzDlg:GetDimension( 'oBrowse', 'LININI' ) ,;
	/* nCol       */ oDfSzDlg:GetDimension( 'oBrowse', 'COLINI' ) ,;
	/* nWidth     */ oDfSzDlg:GetDimension( 'oBrowse', 'XSIZE'  ) ,;
	/* nHeight    */ oDfSzDlg:GetDimension( 'oBrowse', 'YSIZE'  ) ,;
	/* bLine      */                                              ,;
	/* aHeaders   */                                     aHeaders ,;
	/* aColSizes  */                                              ,;
	/* oDlg       */                                         oDlg ,;
	/* cField     */                                              ,;
	/* uValue1    */                                              ,;
	/* uValue2    */                                              ,;
	/* bChange    */                                              ,;
	/* bLDblClick */                                              ,;
	/* bRClick    */                                              ,;
	/* oFont      */                                     oFontBrw ,;
	/* oCursor    */                                              ,;
	/* nClrFore   */                                              ,;
	/* nClrBack   */                                              ,;
	/* cMsg       */                                              ,;
	/* uParam20   */                                              ,;
	/* cAlias     */                                              ,;
	/* lPixel     */                                          .T. ,;
	/* bWhen      */                                              ,;
	/* uParam24   */                                              ,;
	/* bValid     */                                              ,;
	/* lHScroll   */                                          .T. ,;
	/* lVScroll   */                                          .T.  )

	oBrowse:SetArray( aBrowse )
	oBrowse:bLine := bLine

	oDlg:Activate()

	If Select( cTrab ) > 0

		( cTrab )->( DbCloseArea() )

	End If

Return

Static Function ProcCsv()

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

Static Function DefKey( cTela )

	Default cTela := ''

	If cTela := ''

	ElseIf cTela := 'Help'

	ElseIf cTela := 'Abrir'

	ElseIf cTela := ''

	ElseIf cTela := ''

		SetKey( VK_F1, { || } )
		SetKey( VK_F2, { || } )
		SetKey( VK_F3, { || } )
		SetKey( VK_F4, { || } )
		SetKey( VK_F5, { || } )
		SetKey( VK_F6, { || } )
		SetKey( VK_F7, { || } )

		//	aAdd( aMultiBtn, { '<F1> Help'      , VK_F1, { || ExecF1() } } )
		//	aAdd( aMultiBtn, { '<F2> Abrir'     , VK_F2, { || ExecF2() } } )
		//	aAdd( aMultiBtn, { '<F3> Salvar'    , VK_F3, { || ExecF3() } } )
		//	aAdd( aMultiBtn, { '<F4> CSV'       , VK_F4, { || ExecF4() } } )
		//  aAdd( aMultiBtn, { '<F5> Executar'  , VK_F5, { || ExecF5( cMultiGet ) } } )
		//	aAdd( aMultiBtn, { '<F6> Parâmetros', VK_F6, { || ExecF6() } } )
		//	aAdd( aMultiBtn, { '<F7> Histórico' , VK_F7, { || ExecF7() } } )
		//	aAdd( aMultiBtn, { '<F8> Script' , VK_F7, { || ExecF7() } } )

	End If

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

/*
Static Function F550SldC(cTable,cCodigo,cLoja,cDC)

Local cQuery	:= ""
Local nValor	:= 0

DEFAULT cTable	:= ""
DEFAULT cCodigo := ""
DEFAULT cLoja	:= ""

If !Empty(cCodigo)

	If oPreparC == nil
		cQuery 	:= "SELECT SUM(ABS(VALOR)) VLRX FROM "+ cTable +" "
		cQuery 	+= "WHERE CODIGO = ? AND"
		cQuery 	+= " LOJA = ? AND"
		cQuery 	+= " DATAEM < '" + DTOS(MV_PAR01) + "' AND "
		cQuery 	+= " DC = ? "

		cQuery 	:= ChangeQuery(cQuery)
		oPreparC:= FWPreparedStatement():New(cQuery)
	Endif

	oPreparC:SetString(1,cCodigo)
	oPreparC:SetString(2,cLoja)
	oPreparC:SetString(3,cDC)
		
	cQuery := oPreparC:GetFixQuery()

	nValor := ABS(MpSysExecScalar(cQuery,"VLRX"))

Endif

Return nValor
*/

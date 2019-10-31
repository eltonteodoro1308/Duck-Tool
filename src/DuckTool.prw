#INCLUDE 'TOTVS.CH'
#INCLUDE 'VKEY.CH'

User Function DuckTool()

	MsApp():New('SIGAESP')
	oApp:CreateEnv()
	oApp:cStartProg := 'U_DuckMenu'
	__lInternet := .T.
	oApp:Activate()

Return

User Function DuckMenu()

	Local oDlg       := Nil

	DEFINE DIALOG oDlg TITLE 'DUCK TOOL' FROM 000, 000 TO 500, 500 PIXEL

	@000, 000 LISTBOX oList Fields HEADER '' SIZE  250, 230 OF oDlg PIXEL

	oList:aHeaders := { '', 'Programa' }

	aList := {;
		{LoadBitmap( GetResources(),'ENGRENAGEM'),'Executar',{|| Executar()          }},;
		{LoadBitmap( GetResources(),'BMPTABLE'  ),'Query'   ,{|| Query()             }},;
		{LoadBitmap( GetResources(),'FOLDER5'   ),'Explorer',{|| Alert( 'Explorer' ) }}}

	oList:SetArray( aList )


	oList:bLine := {|| {;
		aList[oList:nAt,1],;
		aList[oList:nAt,2];
		}}

	oList:bLDblClick := { || Eval( aList[ oList:nAt,3 ] ) }

	DEFINE SBUTTON oSButton2 FROM 235, 220 TYPE 02 OF oDlg ENABLE ACTION {|| oDlg:End() }

	ACTIVATE DIALOG oDlg CENTERED

Return

Static Function Executar()

	Local oGet1
	Local cGet1 := MemoRead( '\system\bufexec.txt' )
	//	Local oSButton1
	//	Local oSButton2
	Local otMultiBtn
	Local aBcode := {}

	Static oDlg

	cGet1 := cGet1 + Space( 1048575 - Len( cGet1 ) )

	DEFINE MSDIALOG oDlg TITLE 'Executar' FROM 000, 000  TO 150, 1000 COLORS 0, 16777215 PIXEL

	@ 035, 005 MSGET oGet1 VAR cGet1 SIZE 490, 010 OF oDlg COLORS 0, 16777215 PIXEL
	//	DEFINE SBUTTON oSButton1 FROM 035, 005 TYPE 01 OF oDlg ENABLE ACTION Eval( {|| Execute( cGet1 ) } )
	//	DEFINE SBUTTON oSButton2 FROM 035, 035 TYPE 02 OF oDlg ENABLE ACTION oDlg:End()

	otMultiBtn := tMultiBtn():New( 01,01,'Titulo',oDlg,,200,150, 'Fundo',0,'Mensagem',3 )

	oTMultiBtn:AddButton('Executar')
	oTMultiBtn:AddButton('Histórico')
	oTMultiBtn:AddButton('Cancelar')

	oTMultiBtn:bAction := { |X,Y| VarInfo('X',X,,.F.,.T.),VarInfo('Y',Y,,.F.,.T.),Eval( aBcode[ Y ] ) }

	aAdd( aBcode, {||Execute( cGet1 ) } )
	aAdd( aBcode, {||Alert('') } )
	aAdd( aBcode, {||oDlg:End() } )

	ACTIVATE MSDIALOG oDlg CENTERED

Return

Static Function Execute( cGet1 )

	Local cBlc  := '{||' + AllTrim( cGet1 ) + '}'
	Local bBlc  := &( cBlc )
	Local bErro := ErrorBlock( {|oErro| VerErro( oErro ) } )

	MemoWrite( '\system\bufexec.txt', cGet1 )

	Eval( bBlc )

Return

Static Function VerErro( oErro )

	ApMsgStop( oErro:Description, 'Erro na Execução da Fórmula Digitada' )

Return

Static Function Query()

	Local oBtnCsv
	Local oBtnOk
	Local oBtnSair
	Local oFont      := TFont():New("Consolas",,020)
	Local oQueryEdit
	Local cQueryEdit := MemoRead( 'query.sql' )
	Local oDlg
	Local lOpened := .F.

	SetKey(  VK_F5 , {|| If( lOpened,ExecQuery( cQueryEdit ), nil ) } )

	DEFINE MSDIALOG oDlg TITLE "" FROM 000, 000  TO 600, 1200 COLORS 0, 16777215 PIXEL

	@ 005, 005 GET oQueryEdit VAR cQueryEdit OF oDlg MULTILINE SIZE 590, 275 COLORS 0, 16777215 FONT oFont HSCROLL PIXEL

	@ 285, 005 BUTTON oBtnOk   PROMPT "Ok <F5>"   SIZE 035, 015 OF oDlg ACTION {|| ExecQuery( cQueryEdit ) } PIXEL
	@ 285, 045 BUTTON oBtnCsv  PROMPT "CSV"  SIZE 035, 015 OF oDlg ACTION {|| ExpToCsv(  cQueryEdit )      } PIXEL
	@ 285, 085 BUTTON oBtnSair PROMPT "Sair" SIZE 035, 015 OF oDlg ACTION {|| oDlg:End()                   } PIXEL

	ACTIVATE MSDIALOG oDlg CENTERED

	SetKey(  VK_F5 , Nil )

Return

Static Function  ExecQuery( cQueryEdit )

	Local cAlias  := ''
	Local aHeader := {}
	Local aData   := {}
	Local aAux    := {}
	Local nX      := 0

	MemoWrite( 'query.sql', cQueryEdit )

	If TcSqlExec(cQueryEdit) < 0

		ShowResult( TcSqlError() )

	Else

		cAlias := MpSysOpenQuery( cQueryEdit )

		For nX := 1 To ( cAlias )->( FCount() )

			aAdd( aHeader,  ( cAlias )->( FieldName( nX ) ) )

		Next nX

		( cAlias )->( DbGotop() )

		Do While  ! ( cAlias )->( Eof() )

			For nX := 1 To ( cAlias )->( FCount() )

				aAdd( aAux, ( cAlias )->( FieldGet( nX )) )

			Next nX

			aAdd( aData, aClone( aAux ) )

			aSize( aAux, 0 )

			( cAlias )->( DbSkip() )

		End Do

		ShowResult( { aHeader, aData } )

	End If

Return

Static Function ShowResult( xParam )

	Local oBtnSair
	Local oFont      := TFont():New("Consolas",,020)
	Local oQueryEdit
	Local cQueryEdit := xParam
	Local oDlg
	Local oList
	Local cList := ''
	Local aList

	SetKey( VK_ESCAPE, {|| oDlg:End() }  )

	DEFINE MSDIALOG oDlg TITLE "" FROM 000, 000  TO 600, 1200 COLORS 0, 16777215 PIXEL

	If ValType( xParam ) = 'C'

		@ 005, 005 GET oQueryEdit VAR cQueryEdit OF oDlg MULTILINE SIZE 590, 275 COLORS 0, 16777215 FONT oFont HSCROLL PIXEL

	ElseIf ValType( xParam ) = 'A'

		@ 005, 005 LISTBOX oList Fields HEADER '' SIZE  590, 275 OF oDlg PIXEL

		oList:aHeaders := xParam[1]

		aList := aClone( xParam[2] )

		oList:SetArray( aList )

		cList := '{|| {'

		For nX := 1 To Len( xParam[1] )

			cList += 'aList[oList:nAt,' + cValToChar( nX ) + ']'

			If nX < Len( xParam[1] )

				cList += ','

			End If

		Next nX

		cList += '}}'

		oList:bLine := &cList

	End If

	@ 285, 005 BUTTON oBtnSair   PROMPT "Sair <ESC>"   SIZE 035, 015 OF oDlg ACTION {|| oDlg:End() } PIXEL

	ACTIVATE MSDIALOG oDlg CENTERED

	SetKey( VK_ESCAPE, Nil  )

Return

Static Function ExpToCsv( cQueryEdit )

	ConOut( cQueryEdit )

Return
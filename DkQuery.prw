#INCLUDE 'TOTVS.CH'
#INCLUDE 'VKEY.CH'

User Function DkQuery()

	Local oSize     := Nil
	Local oDialog   := Nil
	Local oMultiGet := Nil
	Local oMultiBtn := Nil
	Local nX        := 0

	Private aMultiBtn := {}
	Private cMultiGet := ''

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
	aAdd( aMultiBtn, { '<F4> CSV'       , VK_F4, { || ExecF4() } } )
	aAdd( aMultiBtn, { '<F5> Executar'  , VK_F5, { || ExecF5() } } )
	//	aAdd( aMultiBtn, { '<F6> Parâmetros', VK_F6, { || ExecF6() } } )
	//	aAdd( aMultiBtn, { '<F7> Histórico' , VK_F7, { || ExecF7() } } )

	For nX := 1 To Len( aMultiBtn )

		oMultiBtn:AddButton( aMultiBtn[ nX, 1 ] )

		SetKey ( aMultiBtn[ nX, 2 ], aMultiBtn[ nX, 3 ] )

	Next nX

	oDialog:Activate()

	For nX := 1 To Len( aMultiBtn )

		SetKey ( aMultiBtn[ nX, 2 ], Nil )

	Next nX

Return

Static Function ExecF4()

	Alert( ProcName() )

Return

Static Function ExecF5()

	AutoGrLog( cMultiGet )

	MostraErro()

Return

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


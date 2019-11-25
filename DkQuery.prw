#INCLUDE 'TOTVS.CH'
#INCLUDE 'VKEY.CH'

User Function DkQuery()

	Local nX := 0

	Private oDialog   := Nil
	Private oMultiGet := Nil
	Private cMultiGet := ''
	Private oMultiBtn := Nil
	Private aButton   := {}
	Private oSize     := FwDefSize():New( .F. )

	aAdd( aButton, { 'Abrir <F2>'     , VK_F2, { || Alert( '2' ) } } )
	aAdd( aButton, { 'Salvar <F3>'    , VK_F3, { || Alert( '3' ) } } )
	aAdd( aButton, { 'CSV <F4>'       , VK_F4, { || Alert( '4' ) } } )
	aAdd( aButton, { 'Executar <F5>'  , VK_F5, { || Alert( '5' ) } } )
	aAdd( aButton, { 'Parâmetros <F6>', VK_F6, { || Alert( '6' ) } } )
	aAdd( aButton, { 'Histórico <F7>' , VK_F7, { || Alert( '7' ) } } )

	oSize:AddObject ( 'MULTIBTN' , 000, 025, .T., .F. )
	oSize:AddObject ( 'MEMO'     , 000, 000, .T., .T. )

	oSize:Process()

	BldDialog()
	BldMltBtn()
	BldMltGet()

	For nX := 1 To Len( aButton )

		oMultiBtn:AddButton( aButton[ nX, 1 ] )

		SetKey ( aButton[ nX, 2 ], aButton[ nX, 3 ] )

	Next nX

	oDialog:Activate()

Return

Static Function BldDialog()

	oDialog := MsDialog():New(;
	/* nTop         */ oSize:aWindSize[1] ,;
	/* nLeft        */ oSize:aWindSize[2] ,;
	/* nBottom      */ oSize:aWindSize[3] ,;
	/* nRight       */ oSize:aWindSize[4] ,;
	/* cCaption     */                 '' ,;
	/* uParam6      */                    ,;
	/* uParam7      */                    ,;
	/* uParam8      */                    ,;
	/* uParam9      */                    ,;
	/* nClrText     */                    ,;
	/* nClrBack     */                    ,;
	/* uParam12     */                    ,;
	/* oWnd         */                    ,;
	/* lPixel       */                .T. ,;
	/* uParam15     */                    ,;
	/* uParam16     */                    ,;
	/* uParam17     */                    ,;
	/* lTransparent */                     )

Return

Static Function BldMltBtn()

	oMultiBtn := TMultiBtn():New(;
	/* nRow        */  oSize:GetDimension( 'MULTIBTN', 'LININI' ) ,;
	/* nCol        */  oSize:GetDimension( 'MULTIBTN', 'COLINI' ) ,;
	/* cCaption    */                                          '' ,;
	/* oWnd        */                                     oDialog ,;
	/* bAction     */  { | X, Y | MltBtnExec( X, Y ) },;
	/* nWidth      */  oSize:GetDimension( 'MULTIBTN', 'XSIZE' )  ,;
	/* nHeight     */  oSize:GetDimension( 'MULTIBTN', 'YSIZE' )  ,;
	/* cimgName    */                                       'FORM',;
	/* nOri        */                                           0 ,;
	/* cMsg        */                                           '',;
	/* nBtnPerLine */                                           10 )

	oMultiBtn:SetFonts( 'Courier new', 12,'Courier new', 12 )

	//New( 01,01,'Titulo',oDlg,{|x,y| Alert("Selecionado botão: "+Str(y,2)) },200,150,'Afastamento',0,'Mensagem',3 )

Return

Static Function MltBtnExec( X, Y )

	Eval( aButton[ Y, 3 ] )

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

Return

Static Function BldMltGet()

	oMultiGet := TMultiGet():New(;
	/* nRow        */                    oSize:GetDimension( 'MEMO', 'LININI' ) ,;
	/* nCol        */                    oSize:GetDimension( 'MEMO', 'COLINI' ) ,;
	/* bSetGet     */  { | U | If( PCount() == 0, cMultiGet, cMultiGet := U ) } ,;
	/* oWnd        */                                                   oDialog ,;
	/* nWidth      */                     oSize:GetDimension( 'MEMO', 'XSIZE' ) ,;
	/* nHeight     */                     oSize:GetDimension( 'MEMO', 'YSIZE' ) ,;
	/* oFont       */                        TFont():New( 'Courier new',,-14, ) ,;
	/* uParam8     */                                                           ,;
	/* uParam9     */                                                           ,;
	/* uParam10    */                                                           ,;
	/* uParam11    */                                                           ,;
	/* lPixel      */                                                       .T. ,;
	/* uParam13    */                                                           ,;
	/* uParam14    */                                                           ,;
	/* bWhen       */                                                           ,;
	/* uParam16    */                                                           ,;
	/* uParam17    */                                                           ,;
	/* lReadOnly   */                                                           ,;
	/* bValid      */                                                           ,;
	/* uParam20    */                                                           ,;
	/* uParam21    */                                                           ,;
	/* lNoBorder   */                                                           ,;
	/* lVScroll    */                                                       .T. ,;
	/* cLabelText  */                                                           ,;
	/* nLabelPos   */                                                           ,;
	/* oLabelFont  */                                                           ,;
	/* nLabelColor */                                                            )

Return


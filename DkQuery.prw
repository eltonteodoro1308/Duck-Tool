#INCLUDE 'TOTVS.CH'

User Function DkQuery()

	Private oDialog   := Nil
	Private oMultiGet := Nil
	Private oMultiBtn := Nil
	Private oSize     := FwDefSize():New( .F. )

	oSize:AddObject ( 'MULTIBTN' , 030, 030, .F., .F. )
	oSize:AddObject ( 'MEMO'     , 000, 000, .T., .T. )

	oSize:Process()

	BldDialog()
	BldMltBtn()
	BldMltGet()

	oMultiBtn:AddButton('Opção 01')
	oMultiBtn:AddButton('Opção 02')
	oMultiBtn:AddButton('Opção 03')
	oMultiBtn:AddButton('Opção 04')
	oMultiBtn:AddButton('Opção 05XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')

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
	/* cCaption    */       '' ,;
	/* oWnd        */  oDialog ,;
	/* bAction     */  {|x,y| Alert("Selecionado botão: "+Str(y,2)) },;
	/* nWidth      */  oSize:GetDimension( 'MEMO', 'XSIZE' )  ,;
	/* nHeight     */  oSize:GetDimension( 'MULTIBTN', 'YSIZE' )  ,;
	/* cimgName    */                                   'Afastamento',;
	/* nOri        */                                              0 ,;
	/* cMsg        */  '',;
	/* nBtnPerLine */   10)

	//New( 01,01,'Titulo',oDlg,{|x,y| Alert("Selecionado botão: "+Str(y,2)) },200,150,'Afastamento',0,'Mensagem',3 )

Return

Static Function BldMltGet()

	oMultiGet := TMultiGet():New(;
	/* nRow        */ oSize:GetDimension( 'MEMO', 'LININI' ) ,;
	/* nCol        */ oSize:GetDimension( 'MEMO', 'COLINI' ) ,;
	/* bSetGet     */                                        ,;
	/* oWnd        */                                oDialog ,;
	/* nWidth      */ oSize:GetDimension( 'MEMO', 'XSIZE' )  ,;
	/* nHeight     */ oSize:GetDimension( 'MEMO', 'YSIZE' )  ,;
	/* oFont       */     TFont():New( 'Courier new',,-16, ) ,;
	/* uParam8     */                                        ,;
	/* uParam9     */                                        ,;
	/* uParam10    */                                        ,;
	/* uParam11    */                                        ,;
	/* lPixel      */                                    .T. ,;
	/* uParam13    */                                        ,;
	/* uParam14    */                                        ,;
	/* bWhen       */                                        ,;
	/* uParam16    */                                        ,;
	/* uParam17    */                                        ,;
	/* lReadOnly   */                                        ,;
	/* bValid      */                                        ,;
	/* uParam20    */                                        ,;
	/* uParam21    */                                        ,;
	/* lNoBorder   */                                        ,;
	/* lVScroll    */                                    .T. ,;
	/* cLabelText  */                                        ,;
	/* nLabelPos   */                                        ,;
	/* oLabelFont  */                                        ,;
	/* nLabelColor */                                         )

Return


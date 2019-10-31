#Include 'Totvs.ch'
#Include 'Protheus.Ch'

#Define K_CTRL_Y 25
#Define K_CTRL_Z 26

User Function AfterLogin()

	SetKey( K_CTRL_Y, { ||ShowQuery() } )
	SetKey( K_CTRL_Z, { ||ShowSteck() } )
	SetKey( -4, {|| Alert( 'SetKey' )} )

Return

Static Function ShowSteck()

	Local nX   := 0
	Local cPrg := ''

	Do While .T.

		If Empty( cPrg := ProcName( nX++ ) )

			Exit

		End If

		AutoGRLog( cPrg )

	End Do

	MostraErro()

Return

Static Function ShowQuery()

	Local oOK := LoadBitmap(GetResources(),'br_verde')
	Local oNO := LoadBitmap(GetResources(),'br_vermelho')
	DEFINE DIALOG oDlg TITLE "Exemplo TWBrowse" FROM 180,180 TO 550,700 PIXEL

	oBrowse := TWBrowse():New( 01 , 01, 260,184,,{'','Codigo','Descrição'},{20,30,30},;
	oDlg,,,,,{||},,,,,,,.F.,,.T.,,.F.,,, )
	aBrowse   := {{.T.,'CLIENTE 001','RUA CLIENTE 001','BAIRRO CLIENTE 001'},;
	{.F.,'CLIENTE 002','RUA CLIENTE 002','BAIRRO CLIENTE 002'},;
	{.T.,'CLIENTE 003','RUA CLIENTE 003','BAIRRO CLIENTE 003'} }
	oBrowse:SetArray(aBrowse)
	oBrowse:bLine := {||{If(aBrowse[oBrowse:nAt,01],oOK,oNO),aBrowse[oBrowse:nAt,02],;
	aBrowse[oBrowse:nAt,03],aBrowse[oBrowse:nAt,04] } }
	// Troca a imagem no duplo click do mouse
	oBrowse:bLDblClick := {|| aBrowse[oBrowse:nAt][1] := !aBrowse[oBrowse:nAt][1],;
	oBrowse:DrawSelect()}

	ACTIVATE DIALOG oDlg CENTERED


Return

/*
Inkey Codes
------------------------------------------------------------------------------

Cursor Movement Keys                        | Editing Keys
---------------------------------------------+--------------------------------
Uparrow, Ctrl-E             5  K_UP         | Del, Ctrl-G        7  K_DEL
Dnarrow, Ctrl-X            24  K_DOWN       | Tab, Ctrl-I        9  K_TAB
Leftarrow, Ctrl-S          19  K_LEFT       | Shift-Tab        271  K_SH_TAB
Rightarrow, Ctrl-D          4  K_RIGHT      | Ins, Ctrl-V       22  K_INS
Home, Ctrl-A                1  K_HOME       | Backspace, Ctrl-H  8  K_BS
End,  Ctrl-F                6  K_END        | Ctrl-Backspace   127  K_CTRL_BS
PgUp, Ctrl-R               18  K_PGUP       |-----------------------------------
PgDn, Ctrl-C                3  K_PGDN       | Function Keys
Ctrl-Leftarrow, Ctrl-Z     26  K_CTRL_LEFT  |----------------------------------
Ctrl-Rightarrow, Ctrl-B     2  K_CTRL_RIGHT | F1, Ctrl-\        28  K_F1
Ctrl-Home, Ctrl-]          29  K_CTRL_HOME  | F2                -1  K_F2
Ctrl-End, Ctrl-W           23  K_CTRL_END   | F3                -2  K_F3
Ctrl-PgUp, Ctrl-Hyphen     31  K_CTRL_PGUP  | F4                -3  K_F4
Ctrl-PgDn, Ctrl-^          30  K_CTRL_PGDN  | F5                -4  K_F5
Ctrl-Return                10  K_CTRL_RET   | F6                -5  K_F6
Ctrl-ScrollLock             3  K_CTRL_C     | F7                -6  K_F7
Esc, Ctrl-[                27  K_ESC        | F8                -7  K_F8
Return, Ctrl-M             13  K_RETURN     | F9                -8  K_F9
Enter, Ctrl-M              13  K_ENTER      | F10               -9  K_F10
-------------------------------------------------------------------------------
Alt and Ctrl Keys
-------------------------------------------------------------------------------
Alt-A  286 K_ALT_A| Alt-N 305 K_ALT_N| Ctrl-A  1 K_CTRL_A| Ctrl-N 14 K_CTRL_N
Alt-B  304 K_ALT_B| Alt-O 280 K_ALT_O| Ctrl-B  2 K_CTRL_B| Ctrl-O 15 K_CTRL_O
Alt-C  302 K_ALT_C| Alt-P 281 K_ALT_P| Ctrl-C  3 K_CTRL_C| Ctrl-P 16 K_CTRL_P
Alt-D  288 K_ALT_D| Alt-Q 272 K_ALT_Q| Ctrl-D  4 K_CTRL_D| Ctrl-Q 17 K_CTRL_Q
Alt-E  274 K_ALT_E| Alt-R 275 K_ALT_R| Ctrl-E  5 K_CTRL_E| Ctrl-R 18 K_CTRL_R
Alt-F  289 K_ALT_F| Alt-S 287 K_ALT_S| Ctrl-F  6 K_CTRL_F| Ctrl-S 19 K_CTRL_S
Alt-G  290 K_ALT_G| Alt-T 276 K_ALT_T| Ctrl-G  7 K_CTRL_G| Ctrl-T 20 K_CTRL_T
Alt-H  291 K_ALT_H| Alt-U 278 K_ALT_U| Ctrl-H  8 K_CTRL_H| Ctrl-U 21 K_CTRL_U
Alt-I  279 K_ALT_I| Alt-V 303 K_ALT_V| Ctrl-I  9 K_CTRL_I| Ctrl-V 22 K_CTRL_V
Alt-J  292 K_ALT_J| Alt-W 273 K_ALT_W| Ctrl-J 10 K_CTRL_J| Ctrl-W 23 K_CTRL_W
Alt-K  293 K_ALT_K| Alt-X 301 K_ALT_X| Ctrl-K 11 K_CTRL_K| Ctrl-X 24 K_Ctrl_X
Alt-L  294 K_ALT_L| Alt-Y 277 K_ALT_Y| Ctrl-L 12 K_CTRL_L| Ctrl-Y 25 K_Ctrl_Y
Alt-M  306 K_ALT_M| Alt-Z 300 K_ALT_Z| Ctrl-M 13 K_CTRL_M| Ctrl-Z 26 K_CTRL_Z
-------------------------------------------------------------------------------
Shift, Alt, and Ctrl-Function Keys
-------------------------------------------------------------------------------
Shift-F1   -10  K_SH_F1  | Ctrl-F1   -20  K_CTRL_F1  | Alt-F1   -30 K_ALT_F1
Shift-F2   -11  K_SH_F2  | Ctrl-F2   -21  K_CTRL_F2  | Alt-F2   -31 K_ALT_F2
Shift-F3   -12  K_SH_F3  | Ctrl-F3   -22  K_CTRL_F3  | Alt-F3   -32 K_ALT_F3
Shift-F4   -13  K_SH_F4  | Ctrl-F4   -23  K_CTRL_F4  | Alt-F4   -33 K_ALT_F4
Shift-F5   -14  K_SH_F5  | Ctrl-F5   -24  K_CTRL_F5  | Alt-F5   -34 K_ALT_F5
Shift-F6   -15  K_SH_F6  | Ctrl-F6   -25  K_CTRL_F6  | Alt-F6   -35 K_ALT_F6
Shift-F7   -16  K_SH_F7  | Ctrl-F7   -26  K_CTRL_F7  | Alt-F7   -36 K_ALT_F7
Shift-F8   -17  K_SH_F8  | Ctrl-F8   -27  K_CTRL_F8  | Alt-F8   -37 K_ALT_F8
Shift-F9   -18  K_SH_F9  | Ctrl-F9   -28  K_CTRL_F9  | Alt-F9   -38 K_ALT_F9
Shift-F10  -19  K_SH_F10 | Ctrl-F10  -29  K_CTRL_F10 | Alt-F10  -39 K_ALT_F10
-------------------------------------------------------------------------------
*/
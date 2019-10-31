#INCLUDE 'TOTVS.CH'

User Function CTASUP( cConta )

	Local cRet   := ''
	Local aConta := {}
	Local nLen   := 0
	Local nX     := 0
	Local nNivel := 0

	aAdd( aConta, SubStr( cConta, 1, 1 ) )
	aAdd( aConta, SubStr( cConta, 2, 1 ) )
	aAdd( aConta, SubStr( cConta, 3, 1 ) )
	aAdd( aConta, SubStr( cConta, 4, 1 ) )
	aAdd( aConta, SubStr( cConta, 5, 1 ) )
	aAdd( aConta, SubStr( cConta, 6, 2 ) )
	aAdd( aConta, SubStr( cConta, 8, 2 ) )

	nLen   := Len( aConta )

	For nX := 1 To nLen

		nNivel := nLen - nX + 1

		If Val( aConta[ nNivel ] ) # 0

			Exit

		End If

	Next nX

	For nX := 1 To nNivel - 1

		cRet += aConta[ nX ]

	Next nX

	If Len( cRet ) > 0

		cRet := PadR( cRet, Len( cConta ), '0' )

	End If

Return cRet

User Function Teste()

	U_CTASUP( '111110601' )
	U_CTASUP( '110000000' )
	U_CTASUP( '100000000' )


Return
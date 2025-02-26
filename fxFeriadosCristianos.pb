let
    Fonte = let
    funcao = 
    // ------------------------------------------------------------------- INICIO DA FUNCAO -------------------------------------------------------------------
        (
            AnoInicial as number,
            AnoFinal as number
        )=>

        let
            Fonte = {AnoInicial..AnoFinal},
            ConvertidoParaTabela = Table.FromList(Fonte, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
            PersonalizaçãoAdicionada = Table.AddColumn(ConvertidoParaTabela, "DomingoPascoa", each fxDomingoPascoa([Column1])),
            PersonalizaçãoAdicionada1 = Table.AddColumn(PersonalizaçãoAdicionada, "SextaFeiraSanta", each [DomingoPascoa] - #duration(2,0,0,0)),
            PersonalizaçãoAdicionada2 = Table.AddColumn(PersonalizaçãoAdicionada1, "Carnaval", each [DomingoPascoa] - #duration(40,0,0,0)),
            PersonalizaçãoAdicionada3 = Table.AddColumn(PersonalizaçãoAdicionada2, "corpus christi", each [DomingoPascoa] + #duration(60,0,0,0)),
            ColunasRemovidas = Table.RemoveColumns(PersonalizaçãoAdicionada3,{"Column1"}),
            ColunasNaoDinâmicas = Table.UnpivotOtherColumns(ColunasRemovidas, {}, "Tipo", "Data"),
            TipoAlterado = Table.TransformColumnTypes(ColunasNaoDinâmicas,{{"Data", type date}})
        in
            TipoAlterado

    // ------------------------------------------------------------------- FIM DA FUNCAO -------------------------------------------------------------------

        , metadados = [
            Documentation.Name  = "FeriadosCristianos",
            Documentation.Description = "
                by Joviano Silveira (www.joviano.com)
                Insira como parametros o numero do ano inicial e do final, e retornará uma tabela com as datas de feriados dependentes da páscoa.
                ",
            
            Documentation.Examples = {
                // exemplo 01
                [
                    Description = "Feriados dependentes da páscoa nos anos 2019 e 2020",
                    Code = "            
                        FeriadosCristianos(2019,2020)

                    ",
                    Result = "
                        Tipo                | Data
                        DomingoPascoa       | 21/04/2019
                        SextaFeiraSanta     | 19/04/2019
                        Carnaval            | 12/03/2019
                        corpus christi      | 20/06/2019
                        DomingoPascoa       | 12/04/2020
                        SextaFeiraSanta     | 10/04/2020
                        Carnaval            | 03/03/2020
                        corpus christi      | 11/06/2020
                    "
                ]
            }
        ]

in
    Value.ReplaceType(
        funcao,
        Value.ReplaceMetadata(
            Value.Type(funcao),metadados
        )
    )
in
    Fonte

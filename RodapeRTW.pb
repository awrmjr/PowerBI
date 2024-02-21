_Rodape = 

VAR dataAtualizacao = max(zParams[dataUltimoLancamento])
VAR ano = FORMAT(dataAtualizacao, "yyyy")
VAR atualizacao = FORMAT(dataAtualizacao, "DD/MM/YYYY HH:MM")

RETURN "Copyright © " & ano & " RTW Data Analytics - Todos os direitos reservados | Relatório atualizado em " & atualizacao

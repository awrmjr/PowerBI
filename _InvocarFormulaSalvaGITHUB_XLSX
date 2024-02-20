let
    // trocar o link, para buscar sua formula
    GIT = Web.Contents("https://raw.githubusercontent.com/awrmjr/powerbi/master/<funcao>"),

    // lendo o binario do conteudo
    script = Text.FromBinary(GIT),

    // executando
    run = Expression.Evaluate(script, #shared)

in
    run

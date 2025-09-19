-- Função para gerar permutações de uma tabela
function permutar(tabela)
    local resultado = {} -- Tabela para armazenar as permutações

    -- Função recursiva auxiliar
    local function gerarPermutacoes(elementos, permutacaoAtual)
        if #elementos == 0 then
            table.insert(resultado, permutacaoAtual)
        else
            for i = 1, #elementos do
                local elemento = elementos[i]
                -- Cria uma nova tabela sem o elemento atual
                local novosElementos = {}
                for j = 1, #elementos do
                    if i ~= j then
                        table.insert(novosElementos, elementos[j])
                    end
                end

                -- Chama recursivamente com a permutação atualizada
                gerarPermutacoes(novosElementos, table.concat({permutacaoAtual, elemento}, ""))
            end
        end
    end

    gerarPermutacoes(tabela, "") -- Inicia o processo
    return resultado
end

-- Exemplo de uso
local minhaTabela = {{10, 20}, {30, 40}, {50, 60}}
local todasAsPermutacoes = permutar(minhaTabela)

-- Imprime as permutações
for i, permutacao in ipairs(todasAsPermutacoes) do
    print(permutacao)
end

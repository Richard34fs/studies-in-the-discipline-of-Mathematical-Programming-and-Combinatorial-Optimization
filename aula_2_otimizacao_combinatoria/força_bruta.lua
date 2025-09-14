function lerEntrada(arquivo)

    local f = io.open(arquivo, "r")

    local n = tonumber(f:read("*l"))  -- número de máquinas
    local t = tonumber(f:read("*l"))  -- número de tarefas
    local v = {}

    for valor in f:read("*l"):gmatch("%d+") do
        table.insert(v, tonumber(valor))
    end

    f:close()
    return n, t, v
end



function calcularMaior(solucao, n, tarefas)
--Cria uma lista carga com o tempo de cada máquina, começando em 0.
--Ex.: se tenho 3 máquinas → carga = {0, 0, 0}
--Passa por todas as tarefas e soma na máquina onde cada tarefa foi colocada.
--Vai fazendo isso até distribuir todas.
--No final, pega o maior número da lista carga    local carga = {}
    for i = 1, n do
        carga[i] = 0
    end

    for i, maquina in ipairs(solucao) do
        carga[maquina] = carga[maquina] + tarefas[i]
    end

    local max = 0

    for i = 1, n do
        if carga[i] > max then
            max = carga[i]
        end
    end
    return max
end

function gerarAtribuicoes(tarefas, n, idx, solucao, melhor)
--idx=1 → tarefa A
-- coloca em máquina 1 → chama recursão para idx=2
--    idx=2 → tarefa B
--       coloca em máquina 1 → [solução: {1,1}]
--      coloca em máquina 2 → [solução: {1,2}]
--coloca em máquina 2 → chama recursão para idx=2
--   idx=2 → tarefa B
--      coloca em máquina 1 → [solução: {2,1}]
--     coloca em máquina 2 → [solução: {2,2}]


    if idx > #tarefas then
        local maior = calcularMaior(solucao, n, tarefas)
        if maior < melhor.valor then
            melhor.valor = maior
            melhor.solucao = {table.unpack(solucao)}
        end
        return
    end

    for maquina = 1, n do
        solucao[idx] = maquina
        gerarAtribuicoes(tarefas, n, idx + 1, solucao, melhor)
    end
end

function main()

      local n, t, tarefas = lerEntrada("instance_m03_n05_01.txt")

    local melhor = {
      valor = math.huge, 
      solucao = {}
    }

    gerarAtribuicoes(tarefas, n, 1, {}, melhor)

    print("Melhor maior encontrado:", melhor.valor)
    print("Distribuição das tarefas:")

    -- Mostrar tarefas em cada máquina
    local maquinas = {}
    for i = 1, n do maquinas[i] = {} end

    for i, maquina in ipairs(melhor.solucao) do
        table.insert(maquinas[maquina], tarefas[i])
    end

    for i = 1, n do
        io.write("Máquina " .. i .. ": ")
        for _, tarefa in ipairs(maquinas[i]) do
            io.write(tarefa .. " ")
        end
        io.write("\n")
    end
end

main()


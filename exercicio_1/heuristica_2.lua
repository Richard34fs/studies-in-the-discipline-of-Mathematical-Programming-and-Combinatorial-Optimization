local function indice_menor(t)
    local menor_indice = 1
    for i = 2, #t do
        if t[i] < t[menor_indice] then
            menor_indice = i
        end
    end
    return menor_indice
end

-- Ler arquivo
local arquivo = io.open("problema_escalonamento_instancias/instance_m03_n05_01.txt", "r")

local num_maquinas = tonumber(arquivo:read("*l"))

local num_tarefas = tonumber(arquivo:read("*l"))

local linha_tarefas = arquivo:read("*l")

arquivo:close()

-- Converter tarefas para tabela

local tarefas = {}

for valor in string.gmatch(linha_tarefas, "%S+") do
    table.insert(tarefas, tonumber(valor))
end
--ordena as tarefas em ordem decrescente
table.sort(tarefas, function(a, b)
    return a > b 
end)

-- Inicializar tempos das máquinas

local maquinas = {}

for i = 1, num_maquinas do
    maquinas[i] = 0
end

-- Distribuir tarefas

for _, tarefa in ipairs(tarefas) do
    local idx = indice_menor(maquinas)  -- pega a máquina mais livre
    maquinas[idx] = maquinas[idx] + tarefa
end

-- Exibir resultado
local max = maquinas[1]

for i = 2, num_maquinas do
  if maquinas[i] > maquinas[i-1] then
    max = maquinas[i]
  end
end
print(max)

local start = os.clock()
-- Ler arquivo
local arquivo = io.open(
"problema_escalonamento_instancias/instance_m07_n06_01.txt",
  "r"
)

local m = tonumber(arquivo:read("*l"))

local t_num = tonumber(arquivo:read("*l"))

local linha_tarefas = arquivo:read("*l")

arquivo:close()

local lista = {}

for valor in string.gmatch(linha_tarefas, "%S+") do
    table.insert(lista, tonumber(valor))
end

local r = {}
for i = 1, m do
    r[i] = 0
end

local function solve(j, m, lista, t_num)
  if j > t_num then
    local maxval = r[1]
    for i = 2, #r do
      if r[i] > maxval then
        maxval = r[i]
      end
    end
    return maxval
  end

  local makespan = math.huge

  for i = 1, m do
    r[i] = r[i] + lista[j]
    local ret = solve(j + 1, m, lista, t_num)
    if ret < makespan then
      makespan = ret
    end
    r[i] = r[i] - lista[j] -- backtrack
  end

  return makespan
end

print(solve(1, m, lista, t_num))
local finish = os.clock()
print(finish - start)

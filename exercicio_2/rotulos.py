from pyscipopt import Model, quicksum

ret = []

with open('instancias_problema_rotulos/inst5.in', 'r') as arquivo:
    while True:
        line = arquivo.readline()
        if not line:
            break
        splited = list(map(int, line.split()))
        splited.pop(0)
        ret.append(splited)

    ret.pop(0)
modelo = Model("problema rotulos")

x = {}

num_rotulos = len(ret)

def interagi (ret1, ret2):
    if ((ret1[0] > ret2[2]) or (ret1[2] < ret2[0]) or (ret1[1] > ret2[3]) or (ret1[3] < ret2[1])):
        return 0
    return 1
#------------------------------------------------

for i in range(num_rotulos):
    x[i] = modelo.addVar(f"x_{i}", vtype="BINARY")

for i in range(num_rotulos):
    for j in range((i+1), num_rotulos):
        if interagi(ret[i], ret[j]):
            modelo.addCons(x[i] + x[j] <= 1, f"Restricao x{i} x{j}")

modelo.setObjective(quicksum(x[i] for i in range(num_rotulos)), sense="maximize")

modelo.optimize()

if modelo.getStatus() == "optimal":
    print(f"Valor ótimo:{modelo.getObjVal()}")
    print("Solução ótima:")
    for v in modelo.getVars():
        print(f"{v.name}: {modelo.getVal(v)}")
else:
    print("Solução ótima não encontrada.")

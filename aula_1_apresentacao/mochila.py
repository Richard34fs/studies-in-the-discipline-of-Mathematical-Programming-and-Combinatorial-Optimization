from pyscipopt import Model

modelo = Model("Modelo de PLI para o problema da mochila")

modelo.readProblem("mochila.lp")

modelo.optimize()

if modelo.getStatus() == "optimal":
    print(f"Valor órimo: {modelo.getObjVal()}")
    print("Solução ótima: ")
    for v in modelo.getVars():
        print(f"{v.name}: {modelo.getVal(v)}")
else:
    print("solução ótima não encontrada.")

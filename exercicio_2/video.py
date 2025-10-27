from pyscipopt import Model

modelo = Model("Modelo de PLI para o Problema da Mochila")

modelo.readProblem("arquivo.lp")

modelo.optimize()

if modelo.getStatus() == "optimal":
    print(f"Valor ótimo: {modelo.getObjVal()}")
    print("Solução ótima:")
    for v in modelo.getVars():
        print(f"{v.name}: {modelo.getVal(v)}")
else:
    print("Solução ótima não encontrada.")

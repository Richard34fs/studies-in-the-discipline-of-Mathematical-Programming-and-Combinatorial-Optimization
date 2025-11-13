from pyscipopt import Model

with open("instancias/c20400", "r") as f:
    data = list(map(float, f.read().split()))

m = int(data[0])

n = int(data[1])

index = 2

c = []

for i in range(m):
    c.append(data[index:index + n])
    index += n

a = []
for i in range(m):
    a.append(data[index:index + n])
    index += n

b = data[index:index + m]

model = Model()

x = {}

for i in range(m):
    for j in range(n):
        x[i, j] = model.addVar(vtype="B", name=f"x({i},{j})")

model.setObjective(
    sum(
        c[i][j] * x[i, j] for i in range(m) 
            for j in range(n)
    ),
    "minimize"
)

for j in range(n):
    model.addCons(sum(x[i, j] for i in range(m)) == 1)

for i in range(m):
    model.addCons(sum(a[i][j] * x[i, j] for j in range(n)) <= b[i])

#comando pedido no trabalho
model.setParam("presolving/maxrounds", 0)
model.setParam("separating/maxrounds", 0)

model.setParam("limits/time", 300)
model.optimize()

print(model.getObjVal())

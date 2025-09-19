import math
ver = []
inf = float('inf')

with open('instancias_caixeiro_viajante/1_inst1.tsp', 'r') as arquivo:

    while True:

        line = arquivo.readline()
        if not line:
            break
        splited = list(map(int, line.split()))
        splited.pop(0)
        ver.append(splited)

print(ver)

for perm in ver:
    for i in range(len(ver) - 1):
        dist_x = perm[i][0] - perm[i+1][0]
        dist_y = perm[i][1] - perm[i+1][1]
        dist = round((math.sqrt(dist_x * dist_x + dist_y * dist_y)))
        print(dist) 


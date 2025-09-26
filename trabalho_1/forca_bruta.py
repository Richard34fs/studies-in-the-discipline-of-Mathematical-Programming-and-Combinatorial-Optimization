from itertools import permutations
import math
import time

ver = []
inf = float('inf')
tempo_limite = 4 * 60  # 4 minutos em segundos
inicio = time.time()

with open('instancias_caixeiro_viajante/4_inst4.tsp', 'r') as arquivo:
    while True:
        line = arquivo.readline()
        if not line:
            break
        splited = list(map(int, line.split()))
        splited.pop(0)
        ver.append(splited)

for perm in permutations(ver):
    # Checa se passou do tempo limite
    if time.time() - inicio > tempo_limite:
        break

    dist = 0
    for i in range(len(perm) - 1):
        dist_x = perm[i][0] - perm[i+1][0]
        dist_y = perm[i][1] - perm[i+1][1]
        dist += round((math.sqrt(dist_x * dist_x + dist_y * dist_y)))

    dist_x = perm[0][0] - perm[len(perm)-1][0]
    dist_y = perm[0][1] - perm[len(perm)-1][1]
    dist += round((math.sqrt(dist_x * dist_x + dist_y * dist_y)))

    if dist < inf:
        inf = dist

print(inf)

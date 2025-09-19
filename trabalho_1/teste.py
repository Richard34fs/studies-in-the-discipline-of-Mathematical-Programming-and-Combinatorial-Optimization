from itertools import permutations
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


for perm in permutations(ver):
    
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

print (inf)

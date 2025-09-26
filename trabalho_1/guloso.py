import math
ver = []

with open('instancias_caixeiro_viajante/10_kroA100.tsp', 'r') as arquivo:

    while True:

        line = arquivo.readline()
        if not line:
            break
        splited = list(map(float, line.split()))
        splited.pop(0)
        ver.append(splited)


marcado = [0] * len(ver)

def guloso(ver, marcado, atual):

    if marcado[atual] == 1:
        dist_x = ver[atual][0] - ver[0][0]
        dist_y = ver[atual][1] - ver[0][1]
        dist = round((math.sqrt(dist_x * dist_x + dist_y * dist_y)))
        return dist

    marcado[atual] = 1       
    inf = float('inf') 
    proximo = atual

    for i in range(len(ver)):
        if marcado[i] == 0:
            dist_x = ver[atual][0] - ver[i][0]
            dist_y = ver[atual][1] - ver[i][1]
            dist = round((math.sqrt(dist_x * dist_x + dist_y * dist_y)))
        
            if inf > dist:
                inf = dist
                proximo = i

    if inf == float('inf'):
        inf = 0 

    return inf + guloso(ver, marcado, proximo)

print(guloso(ver, marcado,0))

def solve(n, tempo_total_m1, tabela):
    if tabela [n][tempo_total_m1] is not None:
        return tabela[n][tempo_total_m1]

    if n == 0:
        if tempo_total_m1 == 0:
            tabela[n][tempo_total_m1] = True
            return True
        elif tempo_total_m1 > 0:
            tabela[n][tempo_total_m1] = False
            return False

    if solve((n-1), tempo_total_m1, tabela):
        tabela[n][tempo_total_m1] = True
        return True
    if (tempo_total_m1 >= tempo[n-1]) and solve((n-1), (tempo_total_m1 - tempo[n-1]), tabela):
        tabela[n][tempo_total_m1] = True
        return True

    tabela[n][tempo_total_m1] = False
    return False

if __name__ == "__main__":
    m = int(input())
    n = int(input())
    tempo = list(map(int, input().split()))
     
    met_soma_tempos = int(sum(tempo)/2)

    tabela = []
    for i in range(n+1):
        tabela.append([None] * (met_soma_tempos +1))

    i = met_soma_tempos
    while solve(n, i, tabela) == False:
        i -= 1

    makespan = max(i, (sum(tempo) - i))

    print("tempo: ", tempo)
    print("machines: ", m)
    print(" makespan: ", makespan)

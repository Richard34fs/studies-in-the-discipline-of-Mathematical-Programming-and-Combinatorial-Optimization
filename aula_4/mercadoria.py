# variaveis
    # xij: quantidade de unidades de mercadorias trasportadas do deposito i para a loja j (pode ser fracionaria)

# função objetivo
    # minimizar: (4x11 + 6x21 + 8x13 + 5x21 + 4x22 + 3x23)

# restrições
   #x11 + x12 + x13 <= 50
   #x21 + x22 + x23 <= 60
   
   #x11 + x21 = 30
   #x12 + x22 = 40
   #x13 + x23 = 40

   #x11, ..., x23 >= 0 

# para transforamr em canonico(sempre da pra transformar na forma canonica em qualquer problema)
    
    # função objetivo
        # minimizar: (4x11 + 6x21 + 8x13 + 5x21 + 4x22 + 3x23)

    # restrições
    #-x11 - x12 - x13 >= 50
    #x21 + x22 + x23 <= 60
    
    #x11 + x21 = 30
    #x12 + x22 = 40
    #x13 + x23 >= 40
    #-x13 - x23 >= -40

    #x11, ..., x23 >= 0 

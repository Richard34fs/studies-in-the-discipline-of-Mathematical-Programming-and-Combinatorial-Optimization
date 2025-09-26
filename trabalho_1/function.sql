--primeira função para gerar os funcionarios 
CREATE OR REPLACE PROCEDURE gerar_funcionarios(qtd INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE
    i INTEGER;
    v_nome VARCHAR(50);
    v_telefone VARCHAR(20);
    v_endereco VARCHAR(100);
    v_idade INT;
    v_salario NUMERIC(10,2);
BEGIN
    FOR i IN 1..qtd LOOP
        v_nome := 'Funcionario ' || i;
        v_telefone := '(' || (10 + floor(random() * 89))::INT || ')' || (30000 + floor(random() * 9999))::INT;
        v_endereco := 'Rua ' || (floor(random() * 500) + 1)::TEXT || ', Centro';
        v_idade := 20 + floor(random() * 40)::INT;
        v_salario := 1500 + (random() * 2500);

        INSERT INTO public.funcionarios (nome, telefone, endereco, idade, salario)
        VALUES (v_nome, v_telefone, v_endereco, v_idade, v_salario);
    END LOOP;
END;
$$;

--------------------------------------- função para gerar os clientes(igual do slide)

CREATE OR REPLACE PROCEDURE gerar_clientes(qtd INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE
    i INTEGER;
    v_cpf VARCHAR(15);
    v_nome VARCHAR(50);
    v_endereco VARCHAR(100);
    v_estado_civil VARCHAR(20);
    v_num_filhos INT;
    v_data_nasc DATE;
    v_telefone VARCHAR(15);
    v_codh INT;

    estados_civis TEXT[] := ARRAY['Solteiro', 'Casado', 'Divorciado', 'Viúvo'];
BEGIN
    FOR i IN 1..qtd LOOP
        v_cpf := lpad((floor(random() * 99999999999))::TEXT, 11, '0');
        v_nome := 'Cliente ' || i;
        v_endereco := 'Rua ' || (floor(random() * 500) + 1)::TEXT || ', Bairro ' || (floor(random() * 100))::TEXT;
        v_estado_civil := estados_civis[1 + floor(random() * array_length(estados_civis, 1))::INT];
        v_num_filhos := floor(random() * 5)::INT;
        v_data_nasc := DATE '1950-01-01' + (trunc(random() * 20000)) * INTERVAL '1 day';
        v_telefone := '(' || (10 + floor(random() * 89))::INT || ')' || (90000 + floor(random() * 9999))::INT;

        SELECT codh INTO v_codh
        FROM public.habilitacoes
        ORDER BY random()
        LIMIT 1;

        INSERT INTO public.clientes (
            cpf, nome, endereco, estado_civil, num_filhos, data_nasc, telefone, codh
        ) VALUES (
            v_cpf, v_nome, v_endereco, v_estado_civil, v_num_filhos, v_data_nasc, v_telefone, v_codh
        );
    END LOOP;
END;
$$;

--------------------------------------- função para gerar os veiculos

CREATE OR REPLACE PROCEDURE gerar_veiculos(qtd INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE
    i INTEGER;
    v_matricula VARCHAR(20);
    v_nome VARCHAR(50);
    v_modelo VARCHAR(50);
    v_compr NUMERIC(5,2);
    v_pot INT;
    v_vldiaria NUMERIC(10,2);
    v_codtipo INT;
BEGIN
    FOR i IN 1..qtd LOOP
        v_matricula := 'MAT' || (1000 + i);
        v_nome := 'Barco ' || i;
        v_modelo := 'Modelo ' || (i % 20);
        v_compr := (5 + random() * 15);
        v_pot := (50 + random() * 300)::INT;
        v_vldiaria := 200 + (random() * 500);

        SELECT codtipo INTO v_codtipo
        FROM public.tipos_veiculos
        ORDER BY random()
        LIMIT 1;

        INSERT INTO public.veiculos (
            matricula, nome, modelo, comprimento, potmotor, vldiaria, codtipo
        ) VALUES (
            v_matricula, v_nome, v_modelo, v_compr, v_pot, v_vldiaria, v_codtipo
        );
    END LOOP;
END;
$$;

---------------------------------------

CREATE OR REPLACE PROCEDURE gerar_locacoes(qtd INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE
    i INTEGER;
    v_codloc INT;
    v_valor NUMERIC(10,2);
    v_inicio DATE;
    v_fim DATE;
    v_obs TEXT;
    v_matricula VARCHAR(20);
    v_codf INT;
    v_cpf VARCHAR(15);
    cliente_master VARCHAR(15);
BEGIN
    -- escolher cliente principal 
    SELECT cpf INTO cliente_master
    FROM public.clientes
    ORDER BY random()
    LIMIT 1;

    FOR i IN 1..qtd LOOP
        SELECT matricula INTO v_matricula FROM public.veiculos ORDER BY random() LIMIT 1;
        SELECT codf INTO v_codf FROM public.funcionarios ORDER BY random() LIMIT 1;
        SELECT cpf INTO v_cpf FROM public.clientes ORDER BY random() LIMIT 1;

        v_inicio := CURRENT_DATE - (floor(random() * 100))::INT;
        v_fim := v_inicio + (1 + floor(random() * 7))::INT;
        v_valor := (v_fim - v_inicio) * (SELECT vldiaria FROM public.veiculos WHERE matricula = v_matricula);
        v_obs := 'Locação aleatória';

        INSERT INTO public.locacoes (valor, inicio, fim, obs, matricula, codf, cpf)
        VALUES (v_valor, v_inicio, v_fim, v_obs, v_matricula, v_codf, v_cpf);
    END LOOP;

    -- garantir que cliente principal locou todos os veículos
    FOR v_matricula IN SELECT matricula FROM public.veiculos LOOP
        SELECT codf INTO v_codf FROM public.funcionarios ORDER BY random() LIMIT 1;

        v_inicio := CURRENT_DATE - (floor(random() * 50))::INT;
        v_fim := v_inicio + (1 + floor(random() * 5))::INT;
        v_valor := (v_fim - v_inicio) * (SELECT vldiaria FROM public.veiculos WHERE matricula = v_matricula);

        INSERT INTO public.locacoes (valor, inicio, fim, obs, matricula, codf, cpf)
        VALUES (v_valor, v_inicio, v_fim, 'Cliente master alugou todos', v_matricula, v_codf, cliente_master);
    END LOOP;
END;
$$;

--------------------------------------- aqui é a chamada de todas as funções 


CREATE OR REPLACE PROCEDURE gerar_dados(
    qtd_clientes INT,
    qtd_veiculos INT,
    qtd_funcionarios INT,
    qtd_locacoes INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    CALL gerar_funcionarios(qtd_funcionarios);
    CALL gerar_clientes(qtd_clientes);
    CALL gerar_veiculos(qtd_veiculos);
    CALL gerar_locacoes(qtd_locacoes);
END;
$$;


-- para poupular o banco pode usar de exemplo:
-- CALL gerar_dados(20, 10, 5, 30);

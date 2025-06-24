:- dynamic ligacao/3.
:- dynamic cidade_inicial/1.
:- dynamic cidade_final/1.

% Carregamento do Arquivo
% Remove todas as ligações e cidades iniciais/finais existentes e carrega novas do arquivo especificado.
carregar_arquivo(NomeArquivo) :-
    retractall(ligacao(_,_,_)),
    retractall(cidade_inicial(_)),
    retractall(cidade_final(_)),
    consult(NomeArquivo).


% Predicado principal para encontrar um caminho de Origem a Destino.
caminho(Orig, Dest, Visitadas, [Orig|Caminho], DistAcu, DistTotal) :-
    ligacao(Orig, Prox, D), 
    \+ member(Prox, Visitadas),
    DistAcu2 is DistAcu + D, 
    caminho(Prox, Dest, [Prox|Visitadas], Caminho, DistAcu2, DistTotal). 

caminho(Dest, Dest, _, [Dest], Dist, Dist).


% Encontra todos os caminhos da cidade inicial para a cidade final e suas distâncias.
todos_os_caminhos(Lista) :-
    cidade_inicial(Orig),
    cidade_final(Dest),
    findall(
         (Caminho, Dist), 
        caminho(Orig, Dest, [Orig], Caminho, 0, Dist), 
        Lista 
    ).


% Imprime cada caminho e sua distância total.
imprimir_caminhos([]). 
imprimir_caminhos([(Cam, D)|R]) :-
    write('Caminho: '), write(Cam),
    write(', Distancia total: '), write(D), write(' km'), nl,
    imprimir_caminhos(R). 

% Encontra o caminho com a menor distância de uma lista de caminhos.
encontrar_menor_caminho([(C,D)], C, D).

encontrar_menor_caminho([(C1,D1)|R], Mc, Md) :-
    % Primeiro, encontra o menor caminho no restante da lista (R)
    encontrar_menor_caminho(R, C_resto, D_resto),
    ( D1 =< D_resto -> 
        Mc = C1,   
        Md = D1     
    ;      
        Mc = C_resto,
        Md = D_resto
    ).

% Busca e exibe todos os caminhos
buscar_todos_os_caminhos :-
    todos_os_caminhos(L), 
    ( L = [] -> write('Nenhum caminho encontrado.'), nl
    ; imprimir_caminhos(L) 
    ).

% Busca e exibe o menor caminho
buscar_menor_caminho :-
    todos_os_caminhos(L), 
    ( L = [] -> write('Nenhum caminho encontrado.'), nl
    ; encontrar_menor_caminho(L, C, D), nl,
        write('Menor caminho: '), write(C), nl,
        write('Distancia: '), write(D), write(' km'), nl
    ).

% Menu Interativo
menu :-
    nl, write('+========== MENU ==========+'), nl,
    write('1 - Carregar Arquivo'), nl,
    write('2 - Buscar Todos os Caminhos'), nl,
    write('3 - Buscar Menor Caminho'), nl,
    write('4 - Sair'), nl,
    write('+==========================+'), nl,
    write('Escolha uma opcao: '), read(Op), nl
    executar_opcao(Op).

executar_opcao(1) :-
    write('Digite o nome do arquivo (com .pl): '), read(Nome),
    carregar_arquivo(Nome),
    write('Arquivo carregado com sucesso!'), nl, nl, 
    menu.

executar_opcao(2) :-
    buscar_todos_os_caminhos,
    menu.

executar_opcao(3) :-
    buscar_menor_caminho,
    menu.

executar_opcao(4) :-
    write('Saindo...'), nl.

executar_opcao(_) :-
    write('Opção inválida!'), nl,
    menu.
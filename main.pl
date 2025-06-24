% Limpa fatos antigos e carrega novo arquivo
carregar_arquivo(NomeArquivo) :-
    retractall(ligacao(_,_,_)), %
    retractall(cidade_inicial(_)),
    retractall(cidade_final(_)),
    consult(NomeArquivo).


% Menu interativo simples
menu :-
    write('+========== MENU ==========+'), nl,
    write('1 - Carregar Arquivo'), nl,
    write('2 - Buscar Caminhos'), nl,
    write('3 - Buscar Caminho mais curto'), nl,
    write('4 - Sair'), nl,
    write('+==========================+'), nl,
    write('Escolha uma opção: '), read(Op),

    executar_opcao(Op).

executar_opcao(1) :-
    write('Digite o nome do arquivo (com .txt): '), read(Nome),
    carregar_arquivo(Nome),
    write('Arquivo carregado com sucesso!'), nl,
    menu.

executar_opcao(2) :-
   % buscar_todos_os_caminhos, 
    menu.

executar_opcao(3) :-
    % buscar_menor_caminho,
    menu.

executar_opcao(4) :-
    write('Saindo...'), nl.

executar_opcao(_) :-
    write('Opcao invalida!'), nl,
    menu.

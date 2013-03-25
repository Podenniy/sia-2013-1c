sia-2013-1c
===========

Repositorio para los trabajos de la materia Sistemas de Inteligencia Artificial del ITBA.

Para correr el programa seguir los siguientes pasos:
1)Abrir una consola y posicionarse en la carperta raíz del proyecto.
2)Correr el comando: python ./solver/main.py path_to_board_file algorithm [heuristic]
Donde:
    path_to_board_file es el path al archivo del tablero, ya sea relativo o absoluto.
    algorithm es la estrategia que se desea utilizar. Las posibilidades son dfs, bfs, iterative, A* o greedy.
    heuristic es un argumento opcional y es el nombre de la heurística a utilizar. Las posibilidades son slim, fat o trivial.

También se proveen 2 scripts de bash: generator.sh y tester.sh, que generan 100 tableros de manera aleatoria, y corren el programa sobre ellos.
    

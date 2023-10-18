Dados carregados do MySQL para o Power BI

1. Criação do Relatório com algumas páginas
2. Primeira Visualização é um gráfico de colunas empilhadas mostrando a diferença salarial de cada empregado
3. Verifica-se a necessidade de reajuste de casas decimais nos salários de alguns empregados
4. Valores corretos são aplicados através da transformação de dados dentro do PowerBI com PowerQuery
5. Mais algumas transformações para os empregados sem Super_ssn que não estavam em cargos de gerência
6. Fiz left joins para melhor separar os dados que vem do sql
7. Mescla de Nomes para uma coluna apenas
8. Mescla de Employee por gerente via MySQL com o código
SELECT
    e1.Ssn AS Employee_Ssn,
    e1.Fname AS Employee_Fname,
    e1.Lmame AS Employee_LMame,
    e1.Super_ssn AS Manager_Ssn,
    e2.Fname AS Manager_Fname,
    e2.Lmame AS Manager_Lmame
FROM
    employee e1
LEFT JOIN
    employee e2 ON e1.Super_ssn = e2.Ssn
WHERE
    e1.Super_ssn IS NOT NULL;
9. Nova mesclagem de nomes
10. Agrupando os dados a fim de saber quantos colaboradores existem por gerente
11. relatório de desempenho de horas por funcionário importando pesquisa do mysql
SELECT
    e.Fname AS Employee_Fname,
    e.Lmame AS Employee_Lmame,
    w.Pno AS Project_Number,
    w.Hours AS Hours_Worked
FROM
    employee e
JOIN
    works_on w
ON
    e.Ssn = w.Essn
WHERE
    w.Pno IS NOT NULL;
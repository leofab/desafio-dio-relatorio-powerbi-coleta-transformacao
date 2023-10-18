# Carregamento de Dados do MySQL para o Power BI

Neste projeto, descrevemos o processo de carregamento de dados do MySQL para o Power BI, bem como as transformações de dados realizadas para análise.

## Etapas Realizadas

### 1. **Criação do Relatório com Páginas**:
   - Começamos criando um relatório no Power BI com várias páginas para análise.

### 2. **Gráfico de Colunas Empilhadas de Diferença Salarial**:
   - A primeira visualização é um gráfico de colunas empilhadas que mostra a diferença salarial de cada empregado.

### 3. **Reajuste de Casas Decimais nos Salários**:
   - Verificamos a necessidade de reajuste nas casas decimais dos salários de alguns empregados.

### 4. **Transformação de Dados com PowerQuery**:
   - Utilizamos o PowerQuery no Power BI para aplicar os valores corretos após a verificação dos salários.

### 5. **Mais Transformações para Empregados sem Super_ssn**:
   - Realizamos mais transformações para os empregados que não estavam em cargos de gerência e não possuíam um Super_ssn.

### 6. **Utilização de Left Joins para Separar os Dados**:
   - Utilizamos left joins para melhor separar os dados provenientes do SQL.

### 7. **Mescla de Nomes em uma Única Coluna**:
   - Mesclamos os nomes dos empregados em uma única coluna para simplificar a visualização.

### 8. **Mescla de Employee por Gerente via MySQL**:
   - Utilizamos a seguinte consulta SQL para mesclar empregados com seus gerentes com base no Super_ssn:

   ```sql
   SELECT
       e1.Ssn AS Employee_Ssn,
       e1.Fname AS Employee_Fname,
       e1.Lname AS Employee_Lname,
       e1.Super_ssn AS Manager_Ssn,
       e2.Fname AS Manager_Fname,
       e2.Lname AS Manager_Lname
   FROM
       employee e1
   LEFT JOIN
       employee e2 ON e1.Super_ssn = e2.Ssn
   WHERE
       e1.Super_ssn IS NOT NULL;

### 9.  **Nova Mesclagem de Nomes**:
   - Após a mescla com os gerentes, outra mesclagem de nomes foi realizada.

### 10. **Agrupamento de Dados por Gerente**:
   - Os dados foram agrupados para determinar quantos colaboradores existem por gerente.

### 11. **Relatório de Desempenho de Horas por Funcionário**:
   ```sql
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
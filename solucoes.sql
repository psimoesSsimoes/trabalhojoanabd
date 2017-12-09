--Indique por ordem alfabética descendente o nome de todos os produtos com
--classificação de comércio justo igual ou superior a B – em que A é a melhor
--classificação.
-- A vossa estava certa mas eu escrevi assim

select nome from Produto where comercioJusto='A' or comercioJusto='B' ORDER BY nome DESC;



--. Indique o sexo e a idade de cada um dos dependentes do consumidor com email
---'marcolina@hotmail.com'.
-- a vossa resposta estava errada. Onde já se viu um dependente de 63 anos?? o pai teria de ter 80 lollol. ou sofrer de uma doenca grave e os filhos estivessem a cuidar dele. A resposta certa vai dar vazia na bd fornecida pelo professor, visto que marcolina não tem dependentes. se inserirem um dependente para marcolina na bd, vão ver que a query em baixo está correcta.

select Dependente.sexo,floor(datediff (now(), Dependente.nascimento)/365) as age from Dependente,Consumidor where Dependente.consumidor = Consumidor.numero and Consumidor.email='marcolina@hotmail.com';


-- Email dos consumidores que compraram gasolina.
-- A vossa está certa ;)

SELECT C1.email FROM Consumidor C1, compra C2, Produto P WHERE C2.consumidor=C1.numero AND C2.prodMarca=P.marca AND C2.Produto=P.codigo AND P.nome='gasolina'


-- Email do(s) consumidor(es) que comprou mais gasolina
-- nesta também ;)

SELECT C1.email
FROM Consumidor C1, compra C2, Produto P
WHERE C2.consumidor=C1.numero AND C2.prodMarca=P.marca 
AND C2.Produto=P.codigo AND P.nome='gasolina' AND C2.quantidade = (SELECT MAX(C2.quantidade )
FROM compra C2)

-- Determine a pegada ecológica associada a cada um dos produtos do tipo lar.
-- eu fiz as contas para a lixivia e acho que os resultados estão bem. De qq maneira enviem um email ao professor a perguntar a pegada ecologica para a lixivia de maneira a confirmar que está certa, ok? Considerei 1% como o correspondente a 1 unidade. Se esta assumpção não estiver correcta, este está mal

select Produto.nome,SUM(Elemento.pegadaEcologica * composto.percentagem) as 'peg' from Produto inner join composto inner join Elemento on  Produto.marca = composto.prodMarca and Produto.codigo=composto.produto and Elemento.codigo=composto.elemento where Produto.tipo='lar' group by Produto.nome order by Produto.nome ASC;


--Nome do(s) produto(s) mais prejudicial para a saúde – quanto maiores os valores
--no atributo “saúde”, mais prejudiciais são para 
--a mesma
--Assumi o mesmo que em cima, i.e, que é preciso multiplicar a percentagem pela saude. os resultados dão gasolina o que parece um resultado lógico.
--Apesar de achar que dá a resposta certa, quase de certeza que existe uma maneira mais eficiente de realizar esta query. Estou a fazer a mesma pergunta varias vezes. Primeiro descubram se a resposta à pergunta está certa (email prof). Se sim, melhorem a selecao!!!!
-- lol acabei de ler que não podem fazer sub interrogações na clausula from. Safem-se. não podem usar esta

select nome from (select MAX(pior_para_saude) as pior from (select Produto.nome,SUM(Elemento.saude * composto.percentagem) as pior_para_saude from Produto inner join composto inner join Elemento on  Produto.marca = composto.prodMarca and Produto.codigo=composto.produto and Elemento.codigo=composto.elemento group by Produto.nome) as alias) alias2 inner join (select Produto.nome,SUM(Elemento.saude * composto.percentagem) as pior_para_saude from Produto inner join composto inner join Elemento on  Produto.marca = composto.prodMarca and Produto.codigo=composto.produto and Elemento.codigo=composto.elemento group by Produto.nome)alias3 where alias2.pior=alias3.pior_para_saude;

-- esta usa a clausula having. Acho que é permitido e dá o mesmo resultado

select p.nome,SUM(e.saude * c.percentagem) as pior_para_saude from Produto p inner join composto c inner join Elemento e on  p.marca = c.prodMarca and p.codigo=c.produto and e.codigo=c.elemento group by p.nome having pior_para_saude = (select SUM(Elemento.saude * composto.percentagem) as pior_para_saude from Produto inner join composto inner join Elemento where Produto.marca = composto.prodMarca and Produto.codigo=composto.produto and Elemento.codigo=composto.elemento group by Produto.nome ORDER BY pior_para_saude DESC limit 1) ;


--Liste o sexo e a idade de todas as pessoas abrangidas por esta base de dados –
--consumidores e seus dependentes
-- é só usar a 2 para as 2 tabelas e unir os resultados

(select sexo,floor(datediff (now(), nascimento)/365) as age from Dependente) union (select sexo,floor(datediff (now(),nascimento)/365) as age from Consumidor);

--Email do(s) consumidor(es) que registou compras implicando menor pegada
--ecológica – ter em conta o número de dependentes, dividindo a mesma pelo
--número de pessoas no agregado (consumidor + número de dependentes).

--este deixo para voces. a resposta está resolvida nas de cima...

---Email dos consumidores que realizaram compras que incluem todos os
--elementos mencionados na tabela “Elemento”
-- esta não faço idea como fazer sem select no from. Tem que enviar um email ao prof porque eu também gostava de saber como se faz.
-- A unica ideia que me veio à cabeca foi contar os pares de email elemento da junção da tabela e comparar com o numero de elementos que está na tabela elementos. contudo nao estou mesmo a conseguir pensar numa maneira de chegar lá sem from + select.

select email,sum(i) from (select distinct Consumidor.email,Elemento.nome,count(distinct (nome)) as i from Elemento inner join composto inner join compra inner join Consumidor on Elemento.nome = composto.elemento and composto.produto=compra.produto and composto.prodMarca=compra.prodMarca and Consumidor.numero = compra.consumidor group by 1,2) alias group by alias.email;


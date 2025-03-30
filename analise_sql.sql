-- Pergunta 1
SELECT COUNT(id_chamado) AS total_chamados
FROM `datario.adm_central_atendimento_1746.chamado`
WHERE DATE(data_inicio) = DATE('2023-04-01');

-- Pergunta 2
SELECT
tipo,
COUNT(id_chamado) AS total_chamados

FROM `datario.adm_central_atendimento_1746.chamado`
WHERE DATE(data_inicio) = DATE('2023-04-01')
GROUP BY tipo
ORDER BY total_chamados DESC
LIMIT 1;

-- Pergunta 3
SELECT
Bairro.nome,
COUNT(Chamado.id_chamado) AS total_chamados

FROM `datario.adm_central_atendimento_1746.chamado` AS Chamado
LEFT JOIN `datario.dados_mestres.bairro` AS Bairro on Bairro.id_bairro = Chamado.id_bairro
WHERE DATE(data_inicio) = DATE('2023-04-01')
AND Chamado.id_bairro is not Null
GROUP BY Bairro.nome
ORDER BY total_chamados DESC
LIMIT 3;

--Pergunta 4

SELECT
Bairro.subprefeitura,
COUNT(Chamado.id_chamado) AS total_chamados

FROM `datario.adm_central_atendimento_1746.chamado` AS Chamado
LEFT JOIN `datario.dados_mestres.bairro` AS Bairro on Bairro.id_bairro = Chamado.id_bairro
WHERE DATE(data_inicio) = DATE('2023-04-01')
AND Chamado.id_bairro is not Null
GROUP BY Bairro.subprefeitura
ORDER BY total_chamados DESC
LIMIT 1;

-- Pergunta 5

-- Sim, pois id_bairro estava não estava preenchido

-- Pergunta 6

SELECT
  COUNT(id_chamado) AS total_chamados
FROM `datario.adm_central_atendimento_1746.chamado`
WHERE DATE(data_inicio) BETWEEN DATE('2022-01-01') AND DATE('2023-12-31')
AND id_subtipo = '5071'
ORDER BY total_chamados DESC;

-- Pergunta 7 

WITH Eventos_Corrigidos AS (
  SELECT ano,
         data_inicial,
         data_final,
         evento
  FROM `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos`
  WHERE data_inicial IS NOT NULL

  UNION ALL
  SELECT '13/09 a 15/09 de 2024', '2024-09-13', '2024-09-15', 'Rock in Rio'
  UNION ALL
  SELECT '19/09 a 22/09 de 2024', '2024-09-19', '2024-09-22', 'Rock in Rio'
  UNION ALL
  SELECT '29-31/12 e 01/01 (2024-2025)', '2024-12-31', '2025-01-01', 'Réveillon'
)
SELECT
  ch.id_chamado,
  DATE(ch.data_inicio) AS data_chamado,
  ev.evento,
  ev.data_inicial AS evento_data_inicio,
  ev.data_final AS evento_data_final
FROM `datario.adm_central_atendimento_1746.chamado` ch
JOIN Eventos_Corrigidos AS ev
  ON (DATE(ch.data_inicio) BETWEEN ev.data_inicial AND ev.data_final)
WHERE ch.id_subtipo = '5071'
  AND ev.evento != 'nan'
ORDER BY ch.id_chamado;

-- Pergunta 8 

WITH Eventos_Corrigidos AS (
  SELECT ano,
         data_inicial,
         data_final,
         evento
  FROM `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos`
  WHERE data_inicial IS NOT NULL

  UNION ALL
  SELECT '13/09 a 15/09 de 2024', '2024-09-13', '2024-09-15', 'Rock in Rio'
  UNION ALL
  SELECT '19/09 a 22/09 de 2024', '2024-09-19', '2024-09-22', 'Rock in Rio'
  UNION ALL
  SELECT '29-31/12 e 01/01 (2024-2025)', '2024-12-31', '2025-01-01', 'Réveillon'
)
SELECT
  ev.evento,
  COUNT(id_chamado) AS total_chamados
FROM `datario.adm_central_atendimento_1746.chamado` ch
JOIN Eventos_Corrigidos AS ev
  ON (DATE(ch.data_inicio) BETWEEN ev.data_inicial AND ev.data_final)
WHERE ch.id_subtipo = '5071'
  AND ev.evento != 'nan'
GROUP BY ev.evento
ORDER BY total_chamados DESC;

-- Pergunta 9

WITH Eventos_Corrigidos AS (
  SELECT ano,
         data_inicial,
         data_final,
         evento
  FROM `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos`
  WHERE data_inicial IS NOT NULL

  UNION ALL
  SELECT '13/09 a 15/09 de 2024', '2024-09-13', '2024-09-15', 'Rock in Rio'
  UNION ALL
  SELECT '19/09 a 22/09 de 2024', '2024-09-19', '2024-09-22', 'Rock in Rio'
  UNION ALL
  SELECT '29-31/12 e 01/01 (2024-2025)', '2024-12-31', '2025-01-01', 'Réveillon'
)
SELECT
  ev.evento,
  COUNT(id_chamado)/COUNT(DISTINCT(DATE(ch.data_inicio))) AS media_diaria
FROM `datario.adm_central_atendimento_1746.chamado` ch
JOIN Eventos_Corrigidos AS ev
  ON (DATE(ch.data_inicio) BETWEEN ev.data_inicial AND ev.data_final)
WHERE ch.id_subtipo = '5071'
  AND ev.evento != 'nan'
GROUP BY ev.evento
ORDER BY media_diaria DESC
LIMIT 1;


-- Pergunta 10

SELECT
  COUNT(id_chamado)/COUNT(DISTINCT(DATE(data_inicio))) AS media_diaria
FROM `datario.adm_central_atendimento_1746.chamado`
WHERE DATE(data_inicio) BETWEEN DATE('2022-01-01') AND DATE('2023-12-31')
AND cid_subtipo = '5071'
ORDER BY media_diaria DESC;

-- Foram abertos 84 chamados por dia


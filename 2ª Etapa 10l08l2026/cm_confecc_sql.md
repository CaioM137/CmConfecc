# Do Excel ao banco de dados normalizado — CM Confecc

## Sobre esta etapa

Esta é a segunda fase do case CM Confecc. A primeira modelou o fluxo da fábrica fictícia em Excel (4 abas: Recebimento, PCP, Produção, Comercial). Esta etapa reconstrói o mesmo case como um banco de dados relacional normalizado em MySQL/MariaDB.

🔹 **Base:** módulo introdutório de Banco de Dados Relacionais (bootcamp)
🔸 **Aprofundamento:** reconstrução completa do modelo a partir de um diagrama real de processo produtivo — normalização, chaves estrangeiras, tabela associativa para relacionamento N:N, e eliminação de dependência funcional redundante encontrada durante revisão do próprio schema.

## Por que reconstruir, e não só migrar

O Excel tratava a produção como um bloco único. Ao revisitar um diagrama real do chão de fábrica, três problemas ficaram claros:

- **Almoxarifado e Expedição não são etapas de produção** — são registros de logística (remetente, motorista, nota fiscal), com estrutura própria.
- **A produção não é uma linha reta.** Ela se divide em duas frentes paralelas — uma produz o cabedal (corpo do sapato), outra o solado — que só se encontram na Montagem.
- **Lote e Pedido são entidades diferentes.** Um pedido do cliente pode gerar um ou mais lotes de produção; tratá-los como a mesma coisa quebra a modelagem assim que o negócio cresce um pouco.

## O fluxo real de produção

```
Almoxarifado → Agrupamento → Corte ─┬─→ Serigrafia (opcional) → Alta Frequência ─┐
                                     │                                              ├→ Agrupamento 2 → Costura ─┐
                                     └─→ Pré Fabricado (produz o solado) ───────────┼───────────────────────────┼→ Montagem → Expedição
```

## Principais decisões de modelagem

- **Lote ≠ Pedido.** Tabelas separadas ligadas por chave estrangeira — 1 pedido pode gerar N lotes.
- **Movimentação como log de eventos.** Cada passagem de um lote por uma etapa vira uma linha. Campos que só se aplicam a algumas etapas (revisor, distribuidor) ficam `NULL` quando não usados.
- **Relacionamento N:N resolvido com tabela associativa.** Um lote pode usar matéria-prima de mais de um recebimento — modelado em `lote_materia_prima`, com chave primária composta.
- **Coluna gerada em vez de fórmula manual.** `valor_total` em `recebimento` é `GENERATED ALWAYS AS (qtd_recebida * valor_unitario)` — o equivalente de uma célula com fórmula, nunca digitado, nunca desatualizado.

## Estrutura final: 8 tabelas

| Tabela | Campos | Chave estrangeira |
|---|---|---|
| `marca` | id_marca, nome | — |
| `produto` | id_produto, nome, modelo | id_marca |
| `pedido` | id_pedido, cliente, id_produto, prazo_entrega | id_produto |
| `recebimento` | id_recebimento, data, remetente, cod_recebedor, motorista, nota_fiscal, materia_prima, qtd_recebida, valor_unitario, valor_total (gerado) | — |
| `lote` | id_lote, data, qtd_pares | id_pedido |
| `lote_materia_prima` | id_lote, id_recebimento, qtd_usada | id_lote, id_recebimento (chave composta) |
| `movimentacao` | id_movimento, etapa, data, qualidade, revisor, distribuidor, cor_po | id_lote |
| `expedicao` | id_expedicao, data_envio, destinatario, motorista, nota_fiscal | id_pedido |

## Conceitos de SQL aplicados

| Conceito | Onde | O que resolve |
|---|---|---|
| `PRIMARY KEY` + `AUTO_INCREMENT` | Todas as tabelas | Identificador único gerado automaticamente |
| `FOREIGN KEY` | Todas as tabelas com relação | Garante que uma referência aponte para algo que existe de verdade |
| Chave primária composta | `lote_materia_prima` | Impede a mesma combinação lote + recebimento duplicada |
| `GENERATED ALWAYS AS ... VIRTUAL` | `recebimento.valor_total` | Coluna calculada, nunca armazenada com valor errado |
| `ALTER TABLE ... MODIFY / ADD / DROP COLUMN` | Revisão do schema | Corrige tipo, adiciona ou remove coluna sem recriar a tabela |
| Tabela associativa | `lote_materia_prima` | Resolve relacionamento N:N |
| Eliminação de dependência funcional | `movimentacao` e `lote` | Colunas removidas por serem 100% determinadas por outra (ver abaixo) |

## Processo, não só resultado

Erros reais, identificados e corrigidos durante a revisão do schema já populado — não só na fase de desenho:

- Tipo de dado incorreto (`VARCHAR` em coluna numérica, e vice-versa)
- Coluna obrigatória tratada como opcional
- `VARCHAR(20)` curto demais, cortando nome de produto no meio da palavra
- **`movimentacao.setor` removida** — sempre correspondia 1-para-1 ao valor de `etapa`, uma dependência funcional redundante (violação de 3ª Forma Normal)
- **`lote.modelo` removida** pelo mesmo motivo — sempre idêntica ao `modelo` já disponível via `pedido → produto`

## Estado atual

Schema completo e populado: 12 recebimentos reais (migrados da versão Excel), 16 produtos, 12 pedidos, 18 lotes, matéria-prima associada a todos os lotes, e uma amostra de movimentações cobrindo lotes em estágios diferentes — do recém-iniciado ao já expedido — validando que o modelo sustenta o fluxo completo, não só a teoria.

## Próximos passos

- [ ] Views para os painéis (produção por setor, status de prazo por pedido), usando subconsultas
- [ ] Interface em Python para este banco (próximo módulo do bootcamp)

---
*Continuação direta de `case-cm-confecc.md` (etapa Excel). Este documento evolui junto com o banco de dados.*

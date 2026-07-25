# Sistema de gestão para fábrica fictícia — CM Confecce

## Sobre o projeto

Este case nasceu da junção de dois módulos do meu bootcamp: fundamentos de Excel e engenharia de prompts. Em vez de tratar os dois separadamente, usei IA como parceira de estudo para construir, testar e corrigir uma planilha de gestão completa para uma fábrica fictícia de calçados — do zero, com erro incluído no processo.

O objetivo não foi produzir uma planilha bonita. Foi entender, de dentro pra fora, por que cada fórmula funciona — e documentar isso como evidência de raciocínio, não só de resultado.

## O fluxo da fábrica

```
Recebimento → PCP → Produção → Comercial
```

Matéria-prima entra pelo Recebimento, o PCP decide quando e com o quê produzir, a Produção executa por setor (Corte, Costura, Montagem), e o Comercial negocia prazos com o cliente final — sempre puxando dados reais da produção, nunca digitando por cima.

## Os 4 setores

### 1. Recebimento — controle de matéria-prima
Registra cada lote recebido de fornecedor, com ID sequencial automático e cálculo de valor total por linha.

### 2. PCP — Planejamento e Controle de Produção
Cada Ordem de Produção referencia um lote específico do Recebimento pelo ID — Fornecedor e Matéria-prima são puxados automaticamente, nunca redigitados.

### 3. Produção — painel por setor
Dashboard consolidado: quantidade total, ordens em andamento e concluídas, agrupadas por Corte, Costura e Montagem.

### 4. Comercial — pedidos e prazos
Cada pedido referencia uma Ordem de Produção do PCP. O sistema calcula sozinho, todo dia, se o prazo prometido ao cliente está em risco.

## O conceito central: referência em vez de repetição

O padrão que se repete nas 4 abas é sempre o mesmo: cada tabela guarda só o que é dela, e busca o resto na fonte, por ID.

```
RECEBIMENTO (dado bruto)
     ↑
PCP (referencia o Recebimento)
     ↑
COMERCIAL (referencia o PCP)
```

Isso é o princípio de **chave estrangeira** — a base de qualquer sistema de gestão real (ERP, ferramenta de estoque, CRM). Não é decoração técnica: é o que garante que a informação não se perca nem se contradiga entre setores.

## Funções aplicadas

| Função | Onde | O que resolve |
|---|---|---|
| `SE` + `CONT.VALORES` + `TEXTO` | Todas as abas | Gera ID sequencial automático (`REC-001`, `OP-001`...) só quando a linha tem dado |
| `PROCV` | PCP, Comercial | Busca um valor em outra aba a partir de um ID |
| `SEERRO` | PCP, Comercial | Troca `#N/D` por uma mensagem legível quando o ID buscado não existe |
| `SOMASE` | Produção | Soma valores de uma coluna, filtrando por categoria |
| `CONT.SES` | Produção | Conta ocorrências cruzando dois critérios ao mesmo tempo |
| `SE` aninhado + `HOJE()` | Comercial | Compara a data de hoje com o prazo e classifica automaticamente o status |

## O processo, não só o resultado

Ao longo da construção, apareceram (e foram resolvidos) erros reais: referência de intervalo que vazava ao arrastar, fórmula de total somando em vez de multiplicar, referência circular, separador de lista errado, data digitada como texto por engano. Cada um desses foi diagnosticado e corrigido entendendo a causa — não só copiando a fórmula certa.

## Próximos passos

Esse é o início de um processo evolutivo, não a versão final:

- [ ] Setor de Expedição, fechando o fluxo até a entrega
- [ ] Validação cruzada entre Status de Produção e Status de Entrega
- [ ] Tabela dinâmica consolidando os 4 setores em um dashboard único
- [ ] Automação com Power Query conforme o conhecimento avançar

---
*Este documento evolui junto com o projeto — cada novo conceito aprendido vira uma atualização aqui.*

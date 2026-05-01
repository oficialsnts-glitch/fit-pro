# PRD — THODYFIT (PWA)

## Problem statement (original)
> "esse projeto esta associado a outro pra funcionarem em conjunto, corrija a falha dos gifs e erro de carregamento na inicializacao"
> "execute a sugestao com uma opção de mudar um exercicio durante o treino por outro que foque no mesmo musculo"
> "a pre visualização em ver exercicios nos dias da rotina nao estao mostrando todos os gifs e o botão compartilhar quebrou o layout do pwa saindo da tela pela lateral, o filtro de exercicios nao mostra todas as categorias nem todos os exercicios da categoria"
> "adicione um botão de compartilhar resultado, ao finalizar o treino do dia, mostrando as metricas do treino como peso, reps etc, botão de ciclar exercicio por algum semelhante caso aquele aparelho esteja sendo utilizado o aluno tem outra opção pra nao ficas esperando o outro terminar, xp de niveis, mostrando no ranking a quantidade de pontos e o nivel de xp, onde pra cada nivel necessite de mais xp do que o anterior pra fazer a mudança, os pontos recomeçam apos subir de nivel, cada nivel deve contar sua propria quantidade de pontos a ser batida, e uma recompensa deve ser adicionada ao perfil em cada upgrade de xp"

Dois repos: `oficialsnts-glitch/fit-pro` (app) + `oficialsnts-glitch/fit-pro-videos` (CDN de GIFs).

## Arquitetura
- Static PWA (`index.html` + `sw.js`), Tailwind CDN, Chart.js, Firebase Auth/Firestore.
- GIFs via `raw.githubusercontent.com/oficialsnts-glitch/fit-pro-videos/main/videos/<file>`.
- Deploy: Vercel.

## Iteração 1 — 2026-05-01 — Init bug
- Removido bloco corrompido em `index.html` que quebrava o parser (splash travada + GIFs ausentes).

## Iteração 2 — 2026-05-01 — Features
- **Trocar exercício**: botão em cada card da sessão, modal `#swap-modal` lista até 12 alternativas por grupo muscular, troca preservando progresso.
- **Compartilhar treino**: canvas 1080×1920 (stories-ready) com dados da rotina do dia; botões Baixar PNG + Web Share API.

## Iteração 3 — 2026-05-01 — 3 Bug fixes pós-feedback
1. Compartilhar layout fix (flex-wrap mobile).
2. GIFs ausentes nos dias da rotina (fuzzyFindCatalogItem).
3. Filtro de biblioteca mostra todas categorias (19 vs 1).

## Iteração 4 — 2026-05-01 — Compartilhar resultado + Nível progressivo + Recompensas
### a) Compartilhar RESULTADO ao finalizar treino
- Novo modal `#share-result-modal` + canvas `#share-result-canvas` 1080x1920.
- Acionado automaticamente em `finishSession()` com snapshot do treino.
- Mostra: nome do atleta, dia (A/B/C), 3 KPIs (DURAÇÃO, SÉRIES, VOLUME em kg), lista de exercícios com `Nx reps • peso(kg)`, card de nível com barra de XP, +XP ganho.
- Funções: `openShareResultModal`, `drawShareResultCanvas`, `downloadShareResultImage`, `shareResultNative` (Web Share API com fallback PNG).

### b) Sistema de Níveis Progressivos (substitui tier cumulativo)
- Curva exponencial: `xpRequiredForLevel(N) = round(100 × N^1.5)`.
  - Lvl 1→2: 100 XP, Lvl 2→3: 283, Lvl 3→4: 520, Lvl 5: 1118, Lvl 10: 3162.
- DB.settings: novos campos `level` (default 1), `unlockedBadges[]`. `xp` agora armazena XP do nível atual (reseta ao subir).
- `awardXp(amount, reason)` cascata múltiplos level-ups, dispara toast "Nível X desbloqueado".
- `migrateLegacyXp()` converte silenciosamente XP cumulativo antigo → nível + xp restante.
- Substitui chamadas `DB.settings.xp += ...` em `applyDailyLogin` (5 XP) e `finishSession` (40 XP + 120 XP semana 100%).

### c) Recompensas — Badges + Tema visual
- 10 badges principais (1=Recruta 🌱 ... 5=Spartan 🦾 ... 10=Mítico 🐉) + Mítico N para níveis acima.
- Tema visual por faixa: bronze (1-3) → prata (4-6) → ouro (7-9) → diamante (10+). `updateTierTheme` agora baseia-se no level.
- Card "Meu Nível" no perfil: badge atual, barra de XP `xp/required`, lista de recompensas desbloqueadas com cores.

### d) Ranking da comunidade
- Push pra `leaderboard` agora inclui `level` e `xpInLevel`.
- UI exibe Nome + emoji Lvl N (limpo, sem `pts`).
- "Seu ranking" mostra `#N • emoji Lvl X Nome-do-Badge`.

### e) Trocar exercício (validação)
- Já implementado na iteração 2; funciona durante sessão ativa via `openSwapModal(uid)` em cada card de exercício.

## Arquivos modificados
- `/app/index.html` (único arquivo de produção).
  - Novo modal `#share-result-modal` + canvas.
  - Novo card `Meu Nível` em `#tab-profile`.
  - Funções: `xpRequiredForLevel`, `levelBadge`, `awardXp`, `migrateLegacyXp`, `renderLevelCard`, `openShareResultModal`, `drawShareResultCanvas`, `roundRect`, `downloadShareResultImage`, `shareResultNative`.
  - Atualizadas: `updateTierTheme`, `applyDailyLogin`, `finishSession`, `renderProfile`, `renderCommunityPanel`, `refreshCommunityStats`, `syncLeaderboardProfile`.

## Personas
- Aluno de musculação que treina em academia compartilhada (precisa trocar exercício se aparelho estiver ocupado).
- Atleta gameficado que se motiva com nível, XP e badges.

## Backlog
- **P1** Animação de level-up (modal celebrativo + confete).
- **P1** Compartilhar resultado também como texto formatado (WhatsApp).
- **P1** Tailwind CDN → build local.
- **P2** Pré-cache de GIFs por categoria no `sw.js`.
- **P2** Inserir 1º frame do GIF principal dentro da imagem compartilhada.
- **P2** Tabela de rewards customizáveis (multiplicadores XP por dia perfeito etc).

## Como publicar no Git
Usar botão **"Save to GitHub"** no input do chat → faz push para `oficialsnts-glitch/fit-pro` → Vercel rebuilda automaticamente. Só `/app/index.html` importa para produção (os arquivos em `/app/frontend/` e `/app/backend/` existem apenas para o supervisor do preview).

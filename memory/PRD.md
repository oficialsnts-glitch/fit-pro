# PRD — SDR Pro / Fit-Pro (PWA)

## Problem statement (original)
> "esse projeto esta associado a outro pra funcionarem em conjunto, corrija a falha dos gifs e erro de carregamento na inicializacao"
> "execute a sugestao com uma opção de mudar um exercicio durante o treino por outro que foque no mesmo musculo indicado pra caso de equipamentos ocupados poder fazer com outro parecido e faça os git publicando as melhorias"

Dois repositórios trabalham em conjunto:
- `oficialsnts-glitch/fit-pro`      → app estático (index.html + sw.js + assets)
- `oficialsnts-glitch/fit-pro-videos` → CDN de GIFs (`videos/<categoria>/<Exercicio>.gif`)

## Arquitetura
- Frontend: `index.html` com Tailwind via CDN, Chart.js, Firebase Auth/Firestore.
- Persistência: `localStorage` + Firestore (doc por `uid`).
- Mídia: GIFs do GitHub raw via `videoUrlForFile()` + `media-config.js`.
- Service Worker `sw.js`: cache-first para GIFs/MP4 do GitHub.
- Deploy: Vercel (arquivo `vercel.json`).

## Iteração 1 — 2026-05-01 — Bug crítico de inicialização
- Removido bloco duplicado/corrompido em `index.html` (`}${window.MEDIA_EXTENSION...`) que quebrava o parser JS e causava:
  - tela "CARREGANDO" travada,
  - `videoUrlForFile` e `ANDROID_HASH_VIDEO_CATALOG` nunca definidos (GIFs não carregavam),
  - Firebase Auth nunca disparava.
- Validado: `node --check` limpo, login renderiza, 593 entradas no catálogo, GIF retorna 200 + `image/gif`.

## Iteração 2 — 2026-05-01 — Novas features
### A) Trocar exercício durante o treino (equipamento ocupado)
- Novo botão **"Trocar"** em cada card da sessão (`renderSessionList`).
- Abre modal `#swap-modal` com até 12 alternativas que compartilham o mesmo grupo muscular / categoria do exercício atual (função `findSimilarExercises`).
- Prioriza alternativas da MESMA categoria e ordena por nome.
- Ao confirmar: substitui `name`/`category`/`muscles` do exercício na sessão mantendo `setsDone`, `setsTarget`, `reps`, peso — registra `notes: "Substituído por X (era Y)"`.
- Toast "Trocado por …" ao final.

### B) Compartilhar treino (botão + imagem 1080×1920 para stories)
- Novo botão **"Compartilhar"** no cabeçalho da aba Treino (`renderWorkout`).
- Abre modal `#share-modal` com `<canvas>` 1080×1920.
- `drawShareCanvas()` gera arte com:
  - gradiente escuro + overlays vermelhos,
  - logo "SDR PRO" + subtítulo,
  - nome do usuário (de `DB.user.name`),
  - dia + foco do treino de hoje (fallback: primeiro dia de treino do `weekPlan`),
  - lista de até 8 exercícios com bullet vermelho + "sets x reps",
  - hashtag `#SDRPRO` + call-to-action.
- Botões: **Baixar imagem** (canvas → PNG download) e **Compartilhar** (Web Share API `navigator.share` com `File` PNG; fallback para download se não suportado).

## Prioritized backlog
- **P1** Migrar Tailwind CDN → build local (remove warning em produção).
- **P1** Verificar cobertura de tradução em `video-translations.js`.
- **P2** Pré-cacheamento opcional de GIFs por categoria no `sw.js`.
- **P2** Preview em tempo real do GIF do 1º exercício dentro da imagem compartilhada (ImageBitmap do primeiro frame).

## Arquivos alterados
- `/app/index.html` — correção do parse error, modais `#swap-modal` e `#share-modal`, funções de swap/share, botões na UI.
- `/app/frontend/package.json` + `/app/backend/server.py` — apenas para viabilizar o preview no supervisor do pod; **não fazem parte do deploy Vercel**.

## Publicação no Git
O push não é feito automaticamente. Para publicar o fix + features nos repos GitHub, usar o botão **"Save to GitHub"** no input do chat — ele envia o diff de `/app/index.html` para `oficialsnts-glitch/fit-pro`. A Vercel rebuilda automaticamente.

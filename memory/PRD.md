# PRD — SDR Pro / Fit-Pro (PWA)

## Problem statement (original)
> "esse projeto esta associado a outro pra funcionarem em conjunto, corrija a falha dos gifs e erro de carregamento na inicializacao"

Dois repositórios trabalham em conjunto:
- `oficialsnts-glitch/fit-pro`      → app estático (index.html + sw.js + assets)
- `oficialsnts-glitch/fit-pro-videos` → CDN de GIFs de execução (`videos/<categoria>/<Exercicio>.gif`)

## Arquitetura
- Frontend: página única (`index.html`) com Tailwind via CDN, Chart.js, Firebase Auth/Firestore.
- Persistência: `localStorage` + Firestore (documento por `uid`).
- Mídia: GIFs servidos diretamente de `raw.githubusercontent.com/oficialsnts-glitch/fit-pro-videos/main/videos/<file>` via `videoUrlForFile()` (configurado em `assets/config/media-config.js`).
- Service worker `sw.js` faz cache-first para GIFs/MP4s do GitHub (nome do cache: `sdr-pro-github-videos-v1`).
- Deploy: Vercel (arquivo `vercel.json` define cache headers).

## Personas / fluxo
- Usuário final (aluno): faz login via Google/E-mail (Firebase), passa pelo onboarding, gera rotina, executa treino com GIF de demonstração e registra progresso.

## What's been implemented (2026-05-01)
- **Bug crítico corrigido**: removido bloco de código duplicado/corrompido em `index.html` (antigas linhas 1458–1497) que continha `}${window.MEDIA_EXTENSION || ".gif"}`));` + trechos duplicados da função `catalogVideoCandidates`. Esse pedaço gerava erro de parse no JS e impedia que qualquer lógica do app (inclusive carregamento de GIFs e `startAuth`) fosse executada — causando a tela "CARREGANDO" infinita.
- Validado que:
  - `node --check` passa em todos os scripts inline.
  - `loadExerciseMediaLibrary()` popula `ANDROID_HASH_VIDEO_CATALOG` com 593 entradas a partir de `assets/config/catalog.json`.
  - `videoUrlForFile()` gera URLs válidas apontando para `raw.githubusercontent.com/oficialsnts-glitch/fit-pro-videos`.
  - GIF real (`calistenia/Afundo Profundo.gif`) retorna HTTP 200 + `image/gif` (1080×1080) tanto via HEAD quanto carregado no browser.
  - A tela de login (`SDR PRO / ENTRAR COM GOOGLE`) aparece normalmente após 4–5s do `load` (splash `#loading` é escondido em `startAuth → onAuthStateChanged`).
- Ambiente: criado `frontend/package.json` que usa `serve` para servir o diretório raiz na porta 3000 (supervisor) e `backend/server.py` minimalista (apenas `/api/health`) para satisfazer o supervisor do pod de preview.

## Prioritized backlog
- **P1** Migrar Tailwind para build local em vez do CDN (hoje emite warning; não bloqueia).
- **P1** Internacionalização dos nomes de exercícios em `video-translations.js` (já existe arquivo, validar cobertura).
- **P2** Pré-cacheamento opcional por categoria (hoje `sw.js` já faz cache-first sob demanda).
- **P2** Fallback de imagem estática quando o GIF do GitHub demora/ falha (atualmente mostra "Vídeo não disponível").

## Files of interest
- `/app/index.html` — app inteiro
- `/app/assets/config/media-config.js` — base URL dos GIFs
- `/app/assets/config/catalog.json` — catálogo (593 entradas)
- `/app/sw.js` — service worker (cache de GIFs)
- `/app/vercel.json` — headers de cache para deploy

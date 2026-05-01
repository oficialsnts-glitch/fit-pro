# PRD — SDR Pro / Fit-Pro (PWA)

## Problem statement (original)
> "esse projeto esta associado a outro pra funcionarem em conjunto, corrija a falha dos gifs e erro de carregamento na inicializacao"
> "execute a sugestao com uma opção de mudar um exercicio durante o treino por outro que foque no mesmo musculo"
> "a pre visualização em ver exercicios nos dias da rotina nao estao mostrando todos os gifs e o botão compartilhar quebrou o layout do pwa saindo da tela pela lateral, o filtro de exercicios nao mostra todas as categorias nem todos os exercicios da categoria"

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
1. **Layout do Compartilhar quebrava mobile** → row agora `flex-wrap` com 2 linhas: `[Iniciar hoje][Descanso]` lado a lado + `[Compartilhar]` full-width. Validado com viewport 390px: `scrollWidth === clientWidth` (sem overflow horizontal).
2. **GIFs ausentes em "Ver exercícios"** dos dias da rotina:
   - Adicionado fallback `fuzzyFindCatalogItem(name)` que busca o melhor match no `ANDROID_HASH_VIDEO_INDEX` por token-similarity + preferência de gênero.
   - `exerciseMediaHtml` agora usa: `localVideoCandidates → fuzzy → placeholder "Sem demonstração"`.
   - `routineDayExercisesHtml` agora aceita rotinas que armazenam exercícios tanto em `rt.days[].exercises` quanto em `weekPlan[].data.exercises`.
   - Validado: 3/3 exercícios renderizaram GIF (antes: 0/3).
3. **Filtro de biblioteca não mostrava todas as categorias/exercícios**:
   - `fillCategoryFilter` agora usa `item.category` diretamente do catálogo (593 entradas) como fonte primária de categorias (fallback: EXERCISES).
   - Nova `prettyCategoryLabel` capitaliza corretamente (ex.: "calistenia" → "Calistenia").
   - `renderLibrary` também prioriza `item.category` do catálogo no row.category, batendo com o `row.category===c` do filtro.
   - Validado: **19 categorias** aparecem no dropdown (antes: ~1 "Geral"). Paginação 24/página mantida.

## Arquivos modificados
- `/app/index.html`
  - Botões de `renderWorkout` com layout responsivo (`flex-wrap`).
  - Novas funções `fuzzyFindCatalogItem`, `prettyCategoryLabel`.
  - `exerciseMediaHtml`, `routineDayExercisesHtml`, `fillCategoryFilter`, `renderLibrary` atualizados.

## Backlog
- **P1** Tailwind CDN → build local.
- **P1** Validar cobertura de `video-translations.js` para slug → PT-BR.
- **P2** Pré-cache de GIFs por categoria no `sw.js`.
- **P2** Inserir 1º frame do GIF principal dentro da imagem compartilhada.

## Como publicar no Git
Usar botão **"Save to GitHub"** no input do chat → faz push para `oficialsnts-glitch/fit-pro` → Vercel rebuilda automaticamente. Só `/app/index.html` importa para produção (os arquivos em `/app/frontend/` e `/app/backend/` existem apenas para o supervisor do preview).

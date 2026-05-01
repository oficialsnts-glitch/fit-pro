const CACHE_NAME = "thodyfit-v14";
const VIDEO_CACHE = "thodyfit-videos-v2";
const GITHUB_VIDEO_CACHE = "thodyfit-github-videos-v1";
const CORE_ASSETS = [
  "./",
  "./index.html",
  "./manifest.webmanifest",
  "./pwa-icon-192.png",
  "./pwa-icon-512.png",
  "./pwa-icon-512-maskable.png",
  "./apple-touch-icon-180.png",
  "./logo.png",
  "./assets/config/media-config.js",
  "./assets/config/catalog.json"
];

self.addEventListener("install", event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => cache.addAll(CORE_ASSETS)).then(() => self.skipWaiting())
  );
});

self.addEventListener("activate", event => {
  event.waitUntil(
    caches.keys().then(keys => Promise.all(
      keys.filter(k => ![CACHE_NAME, VIDEO_CACHE, GITHUB_VIDEO_CACHE].includes(k)).map(k => caches.delete(k))
    )).then(() => self.clients.claim())
  );
});

self.addEventListener("fetch", event => {
  if (event.request.method !== "GET") return;
  
  const url = new URL(event.request.url);
  const isGithubVideo = url.hostname === "raw.githubusercontent.com" && url.pathname.includes("/fit-pro-videos/");
  
  // Estratégia especial para vídeos do GitHub: Cache First, then Network (lazy loading)
  if (isGithubVideo && (url.pathname.endsWith(".mp4") || url.pathname.endsWith(".gif"))) {
    event.respondWith(
      caches.open(GITHUB_VIDEO_CACHE).then(cache => {
        return cache.match(event.request).then(response => {
          if (response) return response;
          // Fazer download em segundo plano
          return fetch(event.request, { priority: "low" })
            .then(networkResponse => {
              if (networkResponse.ok) {
                cache.put(event.request, networkResponse.clone());
              }
              return networkResponse;
            })
            .catch(() => {
              // Se falhar, retornar um vídeo placeholder ou erro
              return new Response(null, { status: 503, statusText: "Service Unavailable" });
            });
        });
      })
    );
    return;
  }
  
  // Estratégia para vídeos locais: Cache First, then Network
  if ((url.pathname.endsWith(".mp4") || url.pathname.endsWith(".gif"))) {
    event.respondWith(
      caches.open(VIDEO_CACHE).then(cache => {
        return cache.match(event.request).then(response => {
          if (response) return response;
          return fetch(event.request).then(networkResponse => {
            cache.put(event.request, networkResponse.clone());
            return networkResponse;
          });
        });
      })
    );
    return;
  }

  // Estratégia para outros recursos: Network First, fallback to Cache
  event.respondWith(
    fetch(event.request)
      .then(response => {
        const clone = response.clone();
        caches.open(CACHE_NAME).then(cache => cache.put(event.request, clone)).catch(() => {});
        return response;
      })
      .catch(() => caches.match(event.request).then(cached => cached || caches.match("./index.html")))
  );
});

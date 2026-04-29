(function(){
  // GitHub Raw Content CDN para vídeos de exercícios
  // Repositório: https://github.com/oficialsnts-glitch/fit-pro-videos
  window.GITHUB_VIDEO_BASE = "https://raw.githubusercontent.com/oficialsnts-glitch/fit-pro-videos/main/videos";
  
  // URL template para Firebase Storage (fallback, se necessário)
  window.FIREBASE_VIDEO_TEMPLATE = "https://firebasestorage.googleapis.com/v0/b/fit-pro-985ac.firebasestorage.app/o/{file}?alt=media";
  
  // Configuração de cache para vídeos
  window.VIDEO_CACHE_CONFIG = {
    maxSize: 100 * 1024 * 1024, // 100MB máximo em cache
    ttl: 30 * 24 * 60 * 60 * 1000, // 30 dias
    lazyLoad: true, // Carregar vídeos sob demanda
    preloadThreshold: 3 // Precarregar próximos 3 vídeos na biblioteca
  };
})();

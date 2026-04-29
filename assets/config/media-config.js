(function(){
  // URL template para Firebase Storage (download direto com alt=media)
  // {file} recebe encodeURIComponent('exercises/<arquivo>.mp4')
  window.FIREBASE_VIDEO_TEMPLATE = "https://firebasestorage.googleapis.com/v0/b/fit-pro-985ac.firebasestorage.app/o/{file}?alt=media";

  // Opcional: usar uma base simples (se trocar de provedor/CDN)
  // window.FIREBASE_VIDEO_BASE = "https://cdn.seudominio.com/exercises";
})();

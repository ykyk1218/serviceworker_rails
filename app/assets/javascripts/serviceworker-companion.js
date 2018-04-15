if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/webpack-serviceworker.js', { scope: '.' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
    });
}

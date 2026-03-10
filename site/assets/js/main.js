(function(){
  var banners = document.querySelectorAll('.banner-grid .card');
  if (!banners.length) return;
  var i = 0;
  setInterval(function(){
    banners.forEach(function(el, idx){ el.style.display = (idx === i ? 'block' : 'none'); });
    i = (i + 1) % banners.length;
  }, 3000);
})();

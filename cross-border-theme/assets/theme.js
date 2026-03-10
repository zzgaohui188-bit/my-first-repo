document.addEventListener('DOMContentLoaded', () => {
  const navToggle = document.querySelector('[data-mobile-toggle]');
  const nav = document.querySelector('[data-mobile-nav]');

  if (navToggle && nav) {
    navToggle.addEventListener('click', () => {
      nav.classList.toggle('open');
      navToggle.setAttribute('aria-expanded', nav.classList.contains('open'));
    });
  }

  document.querySelectorAll('[data-hero-slider]').forEach((slider) => {
    const slides = slider.querySelectorAll('.hero-slide');
    if (slides.length <= 1) return;

    let currentIndex = 0;
    setInterval(() => {
      slides[currentIndex].classList.remove('active');
      currentIndex = (currentIndex + 1) % slides.length;
      slides[currentIndex].classList.add('active');
    }, 5000);
  });

  document.querySelectorAll('[data-product-gallery]').forEach((gallery) => {
    const mainImage = gallery.querySelector('[data-gallery-main]');
    const thumbs = gallery.querySelectorAll('[data-gallery-thumb]');
    thumbs.forEach((thumb) => {
      thumb.addEventListener('click', () => {
        mainImage.src = thumb.dataset.src;
        mainImage.alt = thumb.dataset.alt || mainImage.alt;
      });
    });
  });

  document.querySelectorAll('[data-faq-toggle]').forEach((button) => {
    button.addEventListener('click', () => {
      const target = document.getElementById(button.getAttribute('aria-controls'));
      const expanded = button.getAttribute('aria-expanded') === 'true';
      button.setAttribute('aria-expanded', String(!expanded));
      if (target) target.hidden = expanded;
    });
  });
});

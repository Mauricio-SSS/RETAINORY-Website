(function () {
  var root = document.documentElement;
  var prefersReducedMotion = false;

  try {
    prefersReducedMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  } catch (error) {
    prefersReducedMotion = false;
  }

  function forEachNode(nodes, callback) {
    Array.prototype.forEach.call(nodes || [], callback);
  }

  function revealEverything() {
    forEachNode(document.querySelectorAll('.reveal, [data-curve-stage]'), function (element) {
      element.classList.add('is-visible');
    });
  }

  function initYear() {
    var year = document.getElementById('year');
    if (year) year.textContent = new Date().getFullYear();
  }

  function initMobileNav() {
    var navToggle = document.querySelector('[data-nav-toggle]');
    var mobileMenu = document.querySelector('[data-mobile-menu]');
    if (!navToggle || !mobileMenu) return;

    navToggle.addEventListener('click', function () {
      var expanded = navToggle.getAttribute('aria-expanded') === 'true';
      navToggle.setAttribute('aria-expanded', String(!expanded));
      mobileMenu.hidden = expanded;
      document.body.classList.toggle('no-scroll', !expanded);
    });

    mobileMenu.addEventListener('click', function (event) {
      if (!event.target.closest || !event.target.closest('a')) return;
      navToggle.setAttribute('aria-expanded', 'false');
      mobileMenu.hidden = true;
      document.body.classList.remove('no-scroll');
    });
  }

  function initRevealAnimations() {
    var elements = document.querySelectorAll('.reveal, [data-curve-stage]');

    if (prefersReducedMotion || !('IntersectionObserver' in window)) {
      revealEverything();
      return;
    }

    revealEverything();

    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (!entry.isIntersecting) return;
        entry.target.classList.add('is-visible');
        observer.unobserve(entry.target);
      });
    }, { threshold: 0.18, rootMargin: '0px 0px -8% 0px' });

    forEachNode(elements, function (element) {
      observer.observe(element);
    });
  }

  function daysUntilExam(value) {
    if (!value) return 24;
    var today = new Date();
    var exam = new Date(value + 'T12:00:00');
    var diff = Math.ceil((exam - today) / 86400000);
    return Number.isFinite(diff) ? Math.max(diff, 1) : 24;
  }

  function initPlanPreview() {
    var buttons = document.querySelectorAll('[data-goal]');
    var dateInput = document.querySelector('#exam-date');
    var output = document.querySelector('[data-plan-output]');
    var selectedGoal = 'Final exam';

    function update() {
      if (!output) return;
      var days = daysUntilExam(dateInput && dateInput.value);
      var minutes = days <= 7 ? 28 : days <= 21 ? 22 : 18;
      var target = days <= 7 ? 82 : days <= 21 ? 88 : 92;
      var windowLabel = days <= 3 ? 'Today' : days <= 10 ? 'Tonight' : 'Tomorrow';

      output.innerHTML = '<div><span>Goal</span><strong>' + selectedGoal + '</strong></div>' +
        '<div><span>First review</span><strong>' + windowLabel + '</strong></div>' +
        '<div><span>Daily session</span><strong>' + minutes + ' min</strong></div>' +
        '<div><span>Readiness path</span><strong>42% -> ' + target + '%</strong></div>';
    }

    forEachNode(buttons, function (button) {
      button.addEventListener('click', function () {
        selectedGoal = button.getAttribute('data-goal') || 'Final exam';
        forEachNode(buttons, function (item) { item.classList.remove('is-active'); });
        button.classList.add('is-active');
        update();
      });
    });

    if (dateInput) dateInput.addEventListener('change', update);
    update();
  }

  function initAppStorePlaceholders() {
    forEachNode(document.querySelectorAll('.js-app-store-link'), function (link) {
      link.addEventListener('click', function (event) {
        if (link.getAttribute('href') !== 'APP_STORE_LINK_PLACEHOLDER') return;
        event.preventDefault();
        link.setAttribute('aria-label', 'App Store link placeholder');
        link.classList.add('is-pending');
        var download = document.querySelector('#download');
        if (download && download.scrollIntoView) {
          download.scrollIntoView({ behavior: prefersReducedMotion ? 'auto' : 'smooth' });
        }
        window.setTimeout(function () { link.classList.remove('is-pending'); }, 900);
      });
    });
  }

  function initHeader() {
    var header = document.querySelector('[data-header]');
    if (!header) return;
    window.addEventListener('scroll', function () {
      header.classList.toggle('is-scrolled', window.scrollY > 8);
    }, { passive: true });
  }

  function init() {
    revealEverything();
    initYear();
    initMobileNav();
    initRevealAnimations();
    initPlanPreview();
    initAppStorePlaceholders();
    initHeader();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  window.setTimeout(revealEverything, 350);
}());

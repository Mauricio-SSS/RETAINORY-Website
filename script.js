const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

document.getElementById('year').textContent = new Date().getFullYear();

const navToggle = document.querySelector('[data-nav-toggle]');
const mobileMenu = document.querySelector('[data-mobile-menu]');

navToggle?.addEventListener('click', () => {
  const expanded = navToggle.getAttribute('aria-expanded') === 'true';
  navToggle.setAttribute('aria-expanded', String(!expanded));
  mobileMenu.hidden = expanded;
  document.body.classList.toggle('no-scroll', !expanded);
});

mobileMenu?.addEventListener('click', (event) => {
  if (!event.target.closest('a')) return;
  navToggle?.setAttribute('aria-expanded', 'false');
  mobileMenu.hidden = true;
  document.body.classList.remove('no-scroll');
});

const revealEls = document.querySelectorAll('.reveal, [data-curve-stage]');
if (prefersReducedMotion) {
  revealEls.forEach((el) => el.classList.add('is-visible'));
} else {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (!entry.isIntersecting) return;
      entry.target.classList.add('is-visible');
      observer.unobserve(entry.target);
    });
  }, { threshold: 0.18, rootMargin: '0px 0px -8% 0px' });

  revealEls.forEach((el) => observer.observe(el));
}

const goalButtons = document.querySelectorAll('[data-goal]');
const dateInput = document.querySelector('#exam-date');
const planOutput = document.querySelector('[data-plan-output]');
let selectedGoal = 'Final exam';

function daysUntilExam(value) {
  if (!value) return 24;
  const today = new Date();
  const exam = new Date(`${value}T12:00:00`);
  const diff = Math.ceil((exam - today) / 86400000);
  return Number.isFinite(diff) ? Math.max(diff, 1) : 24;
}

function updatePlanPreview() {
  if (!planOutput) return;
  const days = daysUntilExam(dateInput?.value);
  const minutes = days <= 7 ? 28 : days <= 21 ? 22 : 18;
  const target = days <= 7 ? 82 : days <= 21 ? 88 : 92;
  const window = days <= 3 ? 'Today' : days <= 10 ? 'Tonight' : 'Tomorrow';

  planOutput.innerHTML = `
    <div><span>Goal</span><strong>${selectedGoal}</strong></div>
    <div><span>First review</span><strong>${window}</strong></div>
    <div><span>Daily session</span><strong>${minutes} min</strong></div>
    <div><span>Readiness path</span><strong>42% → ${target}%</strong></div>
  `;
}

goalButtons.forEach((button) => {
  button.addEventListener('click', () => {
    selectedGoal = button.dataset.goal;
    goalButtons.forEach((item) => item.classList.remove('is-active'));
    button.classList.add('is-active');
    updatePlanPreview();
  });
});

dateInput?.addEventListener('change', updatePlanPreview);
updatePlanPreview();

document.querySelectorAll('.js-app-store-link').forEach((link) => {
  link.addEventListener('click', (event) => {
    if (link.getAttribute('href') !== 'APP_STORE_LINK_PLACEHOLDER') return;
    event.preventDefault();
    link.setAttribute('aria-label', 'App Store link placeholder');
    link.classList.add('is-pending');
    document.querySelector('#download')?.scrollIntoView({ behavior: prefersReducedMotion ? 'auto' : 'smooth' });
    window.setTimeout(() => link.classList.remove('is-pending'), 900);
  });
});

const header = document.querySelector('[data-header]');
window.addEventListener('scroll', () => {
  header?.classList.toggle('is-scrolled', window.scrollY > 8);
}, { passive: true });

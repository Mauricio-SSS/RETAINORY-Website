(function () {
  function initWaitlistForm() {
    var form = document.querySelector('[data-waitlist-form]');
    var note = document.querySelector('[data-form-note]');
    if (!form || !note) return;

    form.addEventListener('submit', function (event) {
      var action = form.getAttribute('action');
      if (action && action !== 'WAITLIST_FORM_ENDPOINT') return;

      event.preventDefault();
      note.classList.remove('is-success');
      note.classList.add('is-warning');
      note.textContent = 'Waitlist form is ready. Connect WAITLIST_FORM_ENDPOINT to save signups.';
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initWaitlistForm);
  } else {
    initWaitlistForm();
  }
}());

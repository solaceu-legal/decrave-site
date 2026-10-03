(() => {
  'use strict';
  const production = ['decrave.net', 'www.decrave.net'].includes(location.hostname);
  const tracker = document.getElementById('umami-tracker');
  const names = {
    app_store_click: 'App Store Click',
    guide_open: 'Guide Open',
    sos_open: 'SOS Open'
  };
  const allowed = new Set([...Object.values(names), 'SOS Started', 'SOS Timer Completed', 'SOS Ended Early']);
  let pending = [], failed = false;

  function send(name, data) {
    // A blocked or unavailable analytics service must not affect navigation or SOS.
    try {
      const result = data ? window.umami.track(name, data) : window.umami.track(name);
      if (result && typeof result.catch === 'function') result.catch(() => {});
    } catch (_) {}
  }
  function ready() { return window.umami && typeof window.umami.track === 'function'; }
  function flush() {
    if (!ready()) return;
    const events = pending;
    pending = [];
    events.forEach(event => send(event.name, event.data));
  }
  function track(name, props) {
    if (!production || failed || !allowed.has(name)) return;
    // Only fixed event names and button placements are accepted; no exercise details.
    const data = props && typeof props.button_location === 'string'
      ? { button_location: props.button_location } : undefined;
    if (ready()) { flush(); send(name, data); }
    else if (pending.length < 20) pending.push({ name, data });
  }
  window.DecraveAnalytics = { track };
  if (production && tracker) {
    tracker.addEventListener('load', flush, { once: true });
    tracker.addEventListener('error', () => { failed = true; pending = []; }, { once: true });
    flush();
  }
  document.addEventListener('click', event => {
    const link = event.target instanceof Element && event.target.closest('[data-analytics-event]');
    if (!link) return;
    const name = names[link.getAttribute('data-analytics-event')];
    if (name) track(name, { button_location: link.getAttribute('data-analytics-location') });
  });
})();

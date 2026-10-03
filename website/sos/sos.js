(() => {
  'use strict';
  const length = 60000;
  const stages = [
    ['Notice the urge.', 'You do not have to act on it right now. Just notice that it is here.'],
    ['Notice where you feel it.', 'Is there a sensation in your hands, chest, or mouth? There is no right answer. You can simply notice.'],
    ['Make room for this moment.', 'Let your breathing stay comfortable. Notice whether the feeling changes or stays the same, without forcing it.'],
    ['Choose your next move.', 'Bring your attention back to where you are. What is one small action you could take next?']
  ];
  const get = id => document.getElementById(id);
  const intro = get('intro'), session = get('session'), summary = get('summary');
  let state = 'idle', elapsed = 0, startedAt = 0, interval = null, stage = -1;
  function track(name, props) {
    // Analytics must never interrupt the exercise, including when blocked.
    try { if (window.DecraveAnalytics) window.DecraveAnalytics.track(name, props); } catch (_) {}
  }
  function stopTicker() { clearInterval(interval); interval = null; }
  function activeTime() { return Math.min(length, elapsed + (state === 'running' ? performance.now() - startedAt : 0)); }
  function render() {
    const time = activeTime();
    const seconds = Math.ceil((length - time) / 1000);
    get('remaining').textContent = `${Math.floor(seconds / 60)}:${String(seconds % 60).padStart(2, '0')}`;
    get('progress').value = time / 1000;
    const nextStage = Math.min(3, Math.floor(time / 15000));
    if (nextStage !== stage) {
      stage = nextStage;
      get('step').textContent = `Step ${stage + 1} of 4`;
      get('session-title').textContent = stages[stage][0];
      get('prompt').textContent = stages[stage][1];
    }
    if (time >= length && state === 'running') finish(false);
  }
  function start() {
    stopTicker(); elapsed = 0; stage = -1; startedAt = performance.now(); state = 'running';
    intro.hidden = true; summary.hidden = true; session.hidden = false;
    session.classList.remove('paused'); get('pause').textContent = 'Pause';
    get('status').textContent = 'Let your breathing stay comfortable. Follow the words at your own pace.';
    render(); get('session-title').focus(); interval = setInterval(render, 200);
    track('SOS Started');
  }
  function pause(fromBackground = false) {
    if (state !== 'running') return;
    elapsed = activeTime();
    if (elapsed >= length) { finish(false); return; }
    state = 'paused'; stopTicker(); render(); session.classList.add('paused');
    get('pause').textContent = 'Continue';
    get('status').textContent = fromBackground ? 'Paused while you were away. Continue when you are ready.' : 'Paused. Continue when you are ready, or finish here.';
  }
  function resume() {
    if (state !== 'paused') return;
    state = 'running'; startedAt = performance.now(); session.classList.remove('paused');
    get('pause').textContent = 'Pause'; get('status').textContent = 'Continue at your own pace.';
    interval = setInterval(render, 200); render();
  }
  function finish(early) {
    if (state !== 'running' && state !== 'paused') return;
    elapsed = activeTime(); state = 'finished'; stopTicker();
    session.hidden = true; summary.hidden = false;
    get('summary-label').textContent = early ? 'You can finish here' : 'Your minute is complete';
    get('summary-title').focus();
    track(early ? 'SOS Ended Early' : 'SOS Timer Completed');
  }
  get('start').hidden = false;
  get('start').addEventListener('click', start);
  get('again').addEventListener('click', start);
  get('pause').addEventListener('click', () => state === 'running' ? pause() : resume());
  get('finish').addEventListener('click', () => finish(true));
  document.querySelector('.app-note .primary').addEventListener('click', () => track('App Store Click', { button_location: 'sos_summary' }));
  document.addEventListener('visibilitychange', () => { if (document.hidden) pause(true); });
  window.addEventListener('pagehide', () => pause(true));
})();

(() => {
  'use strict';
  const templates = {
    craving: ([cue, action, support]) => `My next-craving plan\n\nWhen I notice: ${cue}\nMy next action: ${action}\nSupport I can use: ${support}\n\nAfterward, I can note what was practical and what I want to change.`,
    slip: ([cue, action, support]) => `My next step after a smoking slip\n\nWhat happened before I smoked: ${cue}\nWhat I will change for the next similar moment: ${action}\nSupport I can use: ${support}\n\nMy earlier progress still counts. I can return to my quit plan now.`,
    preparation: ([cue, action, support]) => `My first preparation step\n\nThe moment I want to prepare for: ${cue}\nOne action I can try: ${action}\nSupport I can use: ${support}\n\nI can review this after trying the action and keep building my quit plan.`
  };

  document.querySelectorAll('[data-plan-builder]').forEach(builder => {
    const template = templates[builder.dataset.planBuilder];
    if (!template) return;
    const fields = Array.from(builder.querySelectorAll('[data-plan-field]'));
    const result = builder.querySelector('[data-plan-result]');
    const output = builder.querySelector('[data-plan-output]');
    const status = builder.querySelector('[data-plan-status]');
    const clearResult = () => { output.value = ''; result.hidden = true; status.textContent = ''; };
    fields.forEach(field => field.addEventListener('input', clearResult));

    builder.querySelector('[data-plan-build]').addEventListener('click', () => {
      const missing = fields.find(field => !field.value.trim());
      if (missing) {
        status.textContent = 'Add a short answer to each of the three prompts first. A general example is fine.';
        missing.focus();
        return;
      }
      output.value = template(fields.map(field => field.value.trim()));
      result.hidden = false;
      status.textContent = 'Your plan is ready below. Copy it somewhere you can find it again.';
    });

    builder.querySelector('[data-plan-copy]').addEventListener('click', async () => {
      if (!output.value) return;
      try {
        await navigator.clipboard.writeText(output.value);
        status.textContent = 'Plan copied. Paste it into your own notes to keep it.';
      } catch (_) {
        output.focus();
        output.select();
        status.textContent = 'Select and copy the plan below using your device’s copy command.';
      }
    });

    builder.querySelector('[data-plan-clear]').addEventListener('click', () => {
      fields.forEach(field => { field.value = ''; });
      clearResult();
      status.textContent = 'Plan cleared.';
      fields[0].focus();
    });

    // Entries stay in these fields only: no storage, analytics, or network calls.
    builder.hidden = false;
  });
})();

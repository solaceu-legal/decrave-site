/* Enhance every Decrave App Store link without changing clicks or analytics. */
(() => {
  const links = Array.from(document.querySelectorAll('a[href^="https://apps.apple.com/"]'))
    .filter((link) => /\/id6801961627\/?$/.test(new URL(link.href).pathname));
  if (!links.length) return;

  const mouse = window.matchMedia("(any-hover: hover) and (any-pointer: fine)");
  const card = document.createElement("div");
  card.className = "download-qr-card";
  card.id = "app-store-download-qr";
  card.hidden = true;
  card.setAttribute("role", "tooltip");
  const image = document.createElement("img");
  image.src = "/assets/app-store-qr.png";
  image.width = image.height = 198;
  image.alt = "Decrave App Store download QR code";
  const title = document.createElement("p");
  title.textContent = "Scan to download Decrave";
  const hint = document.createElement("small");
  hint.textContent = "Scan with your iPhone camera to open the App Store.";
  card.append(image, title, hint);
  document.body.append(card);
  let activeLink;
  let previousDescription;
  let closeTimer;

  function hide() {
    clearTimeout(closeTimer);
    if (activeLink) {
      if (previousDescription === null) activeLink.removeAttribute("aria-describedby");
      else activeLink.setAttribute("aria-describedby", previousDescription);
    }
    card.hidden = true;
    activeLink = null;
  }

  function position() {
    if (!activeLink) return;
    const button = activeLink.getBoundingClientRect();
    const width = document.documentElement.clientWidth;
    const height = document.documentElement.clientHeight;
    if (button.bottom <= 0 || button.top >= height || button.right <= 0 || button.left >= width) {
      hide();
      return;
    }
    const gap = 12;
    const bounds = card.getBoundingClientRect();
    const left = Math.max(gap, Math.min(button.left + button.width / 2 - bounds.width / 2, width - bounds.width - gap));
    const below = button.bottom + gap;
    const top = below + bounds.height <= height - gap ? below : button.top - bounds.height - gap;
    card.style.left = `${left}px`;
    card.style.top = `${Math.max(gap, Math.min(top, height - bounds.height - gap))}px`;
  }

  function show(link) {
    clearTimeout(closeTimer);
    if (activeLink !== link) {
      hide();
      activeLink = link;
      previousDescription = link.getAttribute("aria-describedby");
      link.setAttribute("aria-describedby", [previousDescription, card.id].filter(Boolean).join(" "));
    }
    card.hidden = false;
    position();
  }

  function leave() {
    clearTimeout(closeTimer);
    closeTimer = setTimeout(() => {
      if (card.matches(":hover") || activeLink?.matches(":hover, :focus-visible")) return;
      hide();
    }, 180);
  }

  links.forEach((link) => {
    link.addEventListener("mouseenter", () => { if (mouse.matches) show(link); });
    link.addEventListener("mouseleave", leave);
    link.addEventListener("focus", () => { if (link.matches(":focus-visible")) show(link); });
    link.addEventListener("blur", leave);
  });
  card.addEventListener("mouseenter", () => clearTimeout(closeTimer));
  card.addEventListener("mouseleave", leave);
  document.addEventListener("keydown", (event) => { if (event.key === "Escape") hide(); });
  window.addEventListener("scroll", position, { passive: true, capture: true });
  window.addEventListener("resize", position, { passive: true });
  mouse.addEventListener("change", hide);
})();

'use strict';
(() => {
  const input = document.querySelector('[data-market-price]');
  if (!input) return;
  const en = document.documentElement.lang === 'en';
  const status = document.querySelector('[data-status]');
  const circle = document.querySelector('[data-circle]');
  const price = document.querySelector('[data-price]');
  const total = document.querySelector('[data-total]');
  const formatter = new Intl.NumberFormat(en ? 'en-GB' : 'tr-TR', {style:'currency',currency:'TRY'});
  const render = () => {
    const raw = input.value.trim();
    const valid = /^(?:\d+)(?:[.,]\d{1,2})?$/.test(raw);
    const value = valid ? Number(raw.replace(',', '.')) : null;
    const recorded = value !== null && Number.isFinite(value) && value <= 999999;
    circle.classList.toggle('checked', recorded);
    circle.textContent = recorded ? '✓' : '';
    circle.setAttribute('aria-label', recorded ? (en ? 'Purchased' : 'Alındı') : (en ? 'Not purchased' : 'Alınmadı'));
    price.textContent = recorded ? formatter.format(value) : '—';
    total.textContent = formatter.format(74.5 + (recorded ? value : 0));
    input.setAttribute('aria-invalid', raw && !recorded ? 'true' : 'false');
    status.textContent = raw && !recorded
      ? (en ? 'Use a positive amount or 0, with up to two decimal places.' : '0 veya pozitif bir tutar yazın; en çok iki ondalık basamak kullanın.')
      : recorded
        ? (en ? 'Market price recorded. The item is checked; a home price is optional.' : 'Market fiyatı girildi. Ürün tiklendi; evdeki fiyat isteğe bağlıdır.')
        : (en ? 'No market price yet. The item is not checked.' : 'Market fiyatı henüz yok. Ürün tiksiz.');
  };
  input.addEventListener('input', render);
  render();
})();

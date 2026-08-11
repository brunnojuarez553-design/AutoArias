const INVENTORY_KEY = 'autoariasInventory';
const INVENTORY_VERSION_KEY = 'autoariasInventoryVersion';
const INVENTORY_VERSION = 'autoarias-inventory-v2';
const FALLBACK_IMAGE = 'assets/vehicle-placeholder.svg';

// Inventario inicial de AutoArias. Podés editarlo o ampliarlo desde el panel.
const defaultInventory = [
  {
    id: '1',
    brand: 'Toyota',
    model: 'Yaris XS 1.5 6M/T',
    year: 2024,
    price: 25900000,
    type: 'Hatchback',
    mileage: '19.000 km',
    transmission: 'Manual 6 vel.',
    color: 'Blanco',
    featured: true,
    sold: false,
    image: 'https://res.cloudinary.com/dgp7uhps3/image/upload/v1786421006/IMG_0301_rpvlxj.jpg',
    gallery: [
      'https://res.cloudinary.com/dgp7uhps3/image/upload/v1786421006/IMG_0301_rpvlxj.jpg',
      'https://res.cloudinary.com/dgp7uhps3/image/upload/v1786421007/IMG_0302_weyuw6.jpg',
      'https://res.cloudinary.com/dgp7uhps3/image/upload/v1786421010/IMG_0303_xgpqgk.jpg'
    ],
    description: 'Toyota Yaris XS 1.5 6M/T modelo 2024, color blanco, con 19.000 km y motor 1.5. Llevátelo con una entrega mínima aproximada de $6.900.000. Posibilidad de financiación hasta el 100%, sujeta a calificación crediticia.'
  },
  {
    id: '2',
    brand: 'Volkswagen',
    model: 'Amarok Comfortline 4x4 2.0 TDI 180cv',
    year: 2022,
    price: 40500000,
    type: 'Pickup',
    mileage: '43.000 km',
    transmission: 'Manual',
    color: 'Blanco',
    featured: true,
    sold: false,
    image: 'https://res.cloudinary.com/dgp7uhps3/image/upload/v1786421006/IMG_0305_izxx80.jpg',
    gallery: [
      'https://res.cloudinary.com/dgp7uhps3/image/upload/v1786421006/IMG_0305_izxx80.jpg',
      'https://res.cloudinary.com/dgp7uhps3/image/upload/v1786421006/IMG_0306_wwpi6m.jpg',
      'https://res.cloudinary.com/dgp7uhps3/image/upload/v1786421005/IMG_0307_bujy9e.jpg'
    ],
    description: 'Volkswagen Amarok Comfortline 4x4 2.0 TDI 180cv, modelo 2022, color blanco y con 43.000 km. Una pickup sólida, versátil y lista para trabajar o viajar. Posibilidad de financiación hasta el 100%, sujeta a calificación crediticia.'
  },
  {
    id: '3',
    brand: 'Volkswagen',
    model: 'Taos Comfortline 250 TSI AT',
    year: 2024,
    price: 36900000,
    type: 'SUV',
    mileage: '27.000 km',
    transmission: 'Automática',
    color: 'Gris',
    featured: true,
    sold: false,
    image: 'https://res.cloudinary.com/dgp7uhps3/image/upload/v1786421009/IMG_0308_nbzwwn.jpg',
    gallery: [
      'https://res.cloudinary.com/dgp7uhps3/image/upload/v1786421009/IMG_0308_nbzwwn.jpg',
      'https://res.cloudinary.com/dgp7uhps3/image/upload/v1786421004/IMG_0309_h5rhij.jpg',
      'https://res.cloudinary.com/dgp7uhps3/image/upload/v1786421004/IMG_0310_djnwk5.jpg'
    ],
    description: 'Volkswagen Taos Comfortline 250 TSI AT, modelo 2024, color gris y con 27.000 km. Un SUV moderno, cómodo y muy buscado. Posibilidad de financiación hasta el 100%, sujeta a calificación crediticia.'
  }
];

const grid = document.getElementById('inventoryGrid');
const empty = document.getElementById('emptyState');
const closeVehicleBtn = document.querySelector('[data-close-modal]');
const menu = document.getElementById('mobileMenu');
const sortInventory = document.getElementById('sortInventory');
const inventorySearch = document.getElementById('inventorySearch');

const money = n => new Intl.NumberFormat('es-AR', {
  style: 'currency',
  currency: 'ARS',
  maximumFractionDigits: 0
}).format(n);

function normalizeVehicle(vehicle) {
  const gallery = Array.isArray(vehicle.gallery) && vehicle.gallery.length
    ? vehicle.gallery.filter(Boolean)
    : parseGalleryInput(vehicle.image);
  const cover = gallery[0] || vehicle.image || FALLBACK_IMAGE;
  return {
    ...vehicle,
    price: typeof vehicle.price === 'number' ? vehicle.price : null,
    mileage: vehicle.mileage || 'A consultar',
    transmission: vehicle.transmission || 'Automática',
    color: vehicle.color || 'A consultar',
    image: cover,
    gallery: gallery.length ? gallery : []
  };
}

function parseGalleryInput(value) {
  if (!value) return [];
  return String(value)
    .split(/\s|,|\n/) 
    .map(item => item.trim())
    .filter(item => item.startsWith('http'));
}

function loadInventory() {
  const storedVersion = localStorage.getItem(INVENTORY_VERSION_KEY);
  const stored = localStorage.getItem(INVENTORY_KEY);

  if (!stored || storedVersion !== INVENTORY_VERSION) {
    localStorage.setItem(INVENTORY_KEY, JSON.stringify(defaultInventory));
    localStorage.setItem(INVENTORY_VERSION_KEY, INVENTORY_VERSION);
    return defaultInventory.map(normalizeVehicle);
  }

  try {
    return JSON.parse(stored).map(normalizeVehicle);
  } catch (error) {
    localStorage.setItem(INVENTORY_KEY, JSON.stringify(defaultInventory));
    localStorage.setItem(INVENTORY_VERSION_KEY, INVENTORY_VERSION);
    return defaultInventory.map(normalizeVehicle);
  }
}

let inventory = loadInventory();

function displayPrice(vehicle) {
  return typeof vehicle.price === 'number' ? money(vehicle.price) : 'Precio a consultar';
}

function getVehicleMeta(vehicle) {
  return `${vehicle.brand} ${vehicle.model} ${vehicle.year}`;
}


function renderInventory(list = inventory) {
  grid.innerHTML = '';
  empty.hidden = list.length > 0;
  const availableCount = document.getElementById('availableCount');
  if (availableCount) availableCount.textContent = inventory.filter(vehicle => !vehicle.sold).length;

  list.forEach(vehicle => {
    const priceMarkup = typeof vehicle.price === 'number'
      ? `<div class="vehicle-price">${displayPrice(vehicle)}</div>`
      : `<div class="vehicle-price price-consult">${displayPrice(vehicle)}</div>`;

    grid.insertAdjacentHTML('beforeend', `
      <article class="vehicle-card vehicle-card-pro" data-id="${vehicle.id}">
        <div class="vehicle-media">
          <img src="${vehicle.image}" alt="${getVehicleMeta(vehicle)}" loading="lazy" onerror="this.src='${FALLBACK_IMAGE}'">
          <div class="vehicle-media-shade"></div>
          <div class="badge-row">
            ${vehicle.featured ? '<span class="badge red">Destacado</span>' : ''}
            <span class="badge availability-badge"><i></i>${vehicle.sold ? 'Vendido' : 'Disponible ahora'}</span>
          </div>
          <span class="photo-count">${vehicle.gallery?.filter(src => src && src !== FALLBACK_IMAGE).length || 0} fotos</span>
        </div>
        <div class="vehicle-body">
          <div class="vehicle-meta"><span>${vehicle.year}</span><span>${vehicle.type}</span></div>
          <h3>${vehicle.brand} ${vehicle.model}</h3>
          ${priceMarkup}
          <div class="vehicle-card-footer">
            <span>${vehicle.transmission}</span>
            <button type="button">Ver vehículo <b>→</b></button>
          </div>
        </div>
      </article>
    `);
  });

  document.querySelectorAll('.vehicle-card').forEach(card => {
    card.onclick = () => openVehicle(card.dataset.id);
  });
}
function apply() {
  const q = inventorySearch.value.toLowerCase();
  let list = inventory.filter(vehicle => !q || `${vehicle.brand} ${vehicle.model} ${vehicle.year}`.toLowerCase().includes(q));

  if (sortInventory.value === 'priceAsc') list.sort((a, b) => (a.price ?? Number.MAX_SAFE_INTEGER) - (b.price ?? Number.MAX_SAFE_INTEGER));
  if (sortInventory.value === 'priceDesc') list.sort((a, b) => (b.price ?? -1) - (a.price ?? -1));
  if (sortInventory.value === 'newest') list.sort((a, b) => b.year - a.year);
  if (sortInventory.value === 'featured') list.sort((a, b) => Number(b.featured) - Number(a.featured));

  renderInventory(list);
}

function thumbMarkup(vehicle) {
  if (!vehicle.gallery || vehicle.gallery.length <= 1) return '';
  return `
    <div class="modal-thumbs">
      ${vehicle.gallery.map((src, index) => `
        <button class="modal-thumb ${index === 0 ? 'active' : ''}" type="button" data-thumb="${src}">
          <img src="${src}" alt="${getVehicleMeta(vehicle)} - foto ${index + 1}" onerror="this.src='${FALLBACK_IMAGE}'">
        </button>
      `).join('')}
    </div>
  `;
}

function openVehicle(id) {
  const vehicle = inventory.find(item => item.id === id);
  if (!vehicle) return;

  const modal = document.getElementById('vehicleModal');
  const priceText = displayPrice(vehicle);
  const gallery = vehicle.gallery?.length ? vehicle.gallery : [FALLBACK_IMAGE];
  let activeIndex = 0;
  const financingButton = `<button class="btn btn-ghost btn-block vehicle-finance-action" type="button">Quiero financiarlo</button>`;

  document.getElementById('vehicleModalContent').innerHTML = `
    <div class="vehicle-modal-inner vehicle-showroom">
      <div class="modal-gallery showroom-gallery">
        <div class="showroom-image-stage">
          <img id="modalMainImage" src="${gallery[0]}" alt="${getVehicleMeta(vehicle)}" onerror="this.src='${FALLBACK_IMAGE}'">
          <div class="showroom-image-overlay"></div>
          <div class="gallery-topline"><span>Galería</span><strong id="galleryCounter">1 / ${gallery.length}</strong></div>
          ${gallery.length > 1 ? '<button class="gallery-nav gallery-prev" type="button" aria-label="Foto anterior">‹</button><button class="gallery-nav gallery-next" type="button" aria-label="Foto siguiente">›</button>' : ''}
        </div>
        ${thumbMarkup(vehicle)}
      </div>
      <div class="modal-details showroom-details">
        <div class="showroom-status"><span><i></i>${vehicle.sold ? 'Vendido' : 'Disponible ahora'}</span><small>AutoArias</small></div>
        <span class="eyebrow">${vehicle.year} · ${vehicle.type}</span>
        <h2>${vehicle.brand}<br><span>${vehicle.model}</span></h2>
        <div class="modal-price ${typeof vehicle.price === 'number' ? '' : 'price-consult'}">${priceText}</div>
        <p>${vehicle.description || ''}</p>
        <div class="detail-specs">
          <div><span>Kilometraje</span><strong>${vehicle.mileage}</strong></div>
          <div><span>Transmisión</span><strong>${vehicle.transmission}</strong></div>
          <div><span>Color</span><strong>${vehicle.color}</strong></div>
          <div><span>Estado</span><strong>${vehicle.sold ? 'Vendido' : 'Disponible'}</strong></div>
        </div>
        <div class="showroom-cta-copy"><strong>¿Te interesa esta unidad?</strong><span>Consultá disponibilidad y próximos pasos directamente con un asesor.</span></div>
        <a class="btn btn-primary btn-block" target="_blank" href="https://wa.me/5492901553973?text=${encodeURIComponent(`Hola, me interesa el ${vehicle.brand} ${vehicle.model} ${vehicle.year} publicado en la web.`)}">Consultar por WhatsApp <b>→</b></a>
        ${financingButton}
        <div class="showroom-assurance"><span>Atención directa</span><i></i><span>Consulta sin compromiso</span></div>
      </div>
      <div class="vehicle-mobile-actions">
        <a target="_blank" href="https://wa.me/5492901553973?text=${encodeURIComponent(`Hola, me interesa el ${vehicle.brand} ${vehicle.model} ${vehicle.year}.`)}"><b>WhatsApp</b><span>Consultar</span></a>
        <button class="vehicle-finance-action" type="button"><b>Financiar</b><span>Simular</span></button>
        <a href="tel:+5492901553973"><b>Llamar</b><span>Ahora</span></a>
      </div>
    </div>
  `;

  modal.showModal();

  const main = document.getElementById('modalMainImage');
  const counter = document.getElementById('galleryCounter');
  const thumbs = [...document.querySelectorAll('.modal-thumb')];
  const setImage = index => {
    activeIndex = (index + gallery.length) % gallery.length;
    main.classList.add('switching');
    setTimeout(() => {
      main.src = gallery[activeIndex];
      if (counter) counter.textContent = `${activeIndex + 1} / ${gallery.length}`;
      thumbs.forEach((item, i) => item.classList.toggle('active', i === activeIndex));
      main.classList.remove('switching');
    }, 120);
  };

  thumbs.forEach((button, index) => button.addEventListener('click', () => setImage(index)));
  document.querySelector('.gallery-prev')?.addEventListener('click', event => { event.stopPropagation(); setImage(activeIndex - 1); });
  document.querySelector('.gallery-next')?.addEventListener('click', event => { event.stopPropagation(); setImage(activeIndex + 1); });
  document.querySelectorAll('.vehicle-finance-action').forEach(button => button.addEventListener('click', () => {
    if (typeof setFinanceVehicle === 'function') setFinanceVehicle(vehicle);
    modal.close();
    setTimeout(() => document.getElementById('financiación')?.scrollIntoView({ behavior: 'smooth', block: 'start' }), 100);
  }));
}
closeVehicleBtn.onclick = () => document.getElementById('vehicleModal').close();

document.getElementById('menuBtn').onclick = () => {
  menu.classList.add('open');
  menu.setAttribute('aria-hidden', 'false');
};

document.getElementById('closeMenu').onclick = () => menu.classList.remove('open');
menu.querySelectorAll('a').forEach(anchor => anchor.onclick = () => menu.classList.remove('open'));

sortInventory.addEventListener('change', apply);
inventorySearch.addEventListener('input', apply);

const FINANCE_PROFILES = {
  bnaSalary: {
    label: 'BNA +Autos · cliente haberes',
    tna: 36,
    tea: 42.58,
    cftTea: 53.40,
    maxMonths: 72,
    maxAmount: 100000000,
    maxPercent: 1,
    note: 'Referencia BNA +Autos para cliente haberes. Aplicable únicamente según condiciones vigentes y en concesionarias adheridas. Sujeto a análisis crediticio.'
  },
  bnaOpen: {
    label: 'BNA +Autos · cartera abierta',
    tna: 46,
    tea: 57.05,
    cftTea: 72.30,
    maxMonths: 72,
    maxAmount: 100000000,
    maxPercent: 1,
    note: 'Referencia BNA +Autos para cartera abierta. Aplicable únicamente según condiciones vigentes y en concesionarias adheridas. Sujeto a análisis crediticio.'
  },
  custom: {
    label: 'Simulación personalizada',
    tna: 55,
    tea: null,
    cftTea: null,
    maxMonths: 72,
    maxAmount: 100000000,
    maxPercent: 1,
    note: 'Simulación personalizada. La tasa ingresada es orientativa y no constituye una oferta de crédito.'
  }
};

const financeProfile = document.getElementById('financeProfile');
const customRateWrap = document.getElementById('customRateWrap');
const customRate = document.getElementById('customRate');
const customRateLabel = document.getElementById('customRateLabel');
const financePrincipal = document.getElementById('financePrincipal');
const financeTna = document.getElementById('financeTna');
const financeTea = document.getElementById('financeTea');
const financeCft = document.getElementById('financeCft');
const financeTotal = document.getElementById('financeTotal');
const financeLegalNote = document.getElementById('financeLegalNote');
const financeSelectedVehicle = document.getElementById('financeSelectedVehicle');
const financeSelectedVehicleName = document.getElementById('financeSelectedVehicleName');
const financeClearVehicle = document.getElementById('financeClearVehicle');
let selectedFinanceVehicle = null;

const percentAR = value => `${Number(value).toLocaleString('es-AR', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}%`;

function frenchSchedule(principal, annualTna, monthsCount) {
  if (principal <= 0 || monthsCount <= 0) return { first: 0, total: 0, base: 0 };
  const monthlyRate = annualTna / 100 / 12;
  const basePayment = monthlyRate === 0
    ? principal / monthsCount
    : principal * (monthlyRate * Math.pow(1 + monthlyRate, monthsCount)) / (Math.pow(1 + monthlyRate, monthsCount) - 1);

  let balance = principal;
  let total = 0;
  let first = 0;
  for (let i = 0; i < monthsCount; i++) {
    const interest = balance * monthlyRate;
    const amortization = Math.min(balance, basePayment - interest);
    const ivaInterest = interest * 0.21;
    const installment = basePayment + ivaInterest;
    if (i === 0) first = installment;
    total += installment;
    balance = Math.max(0, balance - amortization);
  }
  return { first, total, base: basePayment };
}

function setFinanceVehicle(vehicle) {
  if (!vehicle || typeof vehicle.price !== 'number') return;
  selectedFinanceVehicle = vehicle;
  const priceThousands = Math.round(vehicle.price / 1000);
  const suggestedDown = Math.round((vehicle.price * 0.20) / 500000) * 500000;
  vehiclePrice.value = Math.min(+vehiclePrice.max, Math.max(+vehiclePrice.min, priceThousands));
  downPayment.max = vehiclePrice.value;
  downPayment.value = Math.round((suggestedDown / 1000) / 500) * 500;
  if (financeSelectedVehicle && financeSelectedVehicleName) {
    financeSelectedVehicle.hidden = false;
    financeSelectedVehicleName.textContent = `${vehicle.brand} ${vehicle.model} ${vehicle.year} · ${money(vehicle.price)}`;
  }
  calc();
}

function clearFinanceVehicle() {
  selectedFinanceVehicle = null;
  if (financeSelectedVehicle) financeSelectedVehicle.hidden = true;
  if (financeSelectedVehicleName) financeSelectedVehicleName.textContent = '';
}

financeClearVehicle?.addEventListener('click', clearFinanceVehicle);

const calc = () => {
  const p = +vehiclePrice.value * 1000;
  downPayment.max = Math.floor(+vehiclePrice.value);
  if (+downPayment.value > +vehiclePrice.value) downPayment.value = vehiclePrice.value;
  const d = +downPayment.value * 1000;
  const m = +months.value;
  const profileKey = financeProfile?.value || 'bnaSalary';
  const profile = FINANCE_PROFILES[profileKey];
  const tna = profileKey === 'custom' ? +customRate.value : profile.tna;
  const principalRequested = Math.max(0, p - d);
  const maxByPercent = p * profile.maxPercent;
  const eligiblePrincipal = Math.min(principalRequested, profile.maxAmount, maxByPercent);
  const schedule = frenchSchedule(eligiblePrincipal, tna, m);

  if (+months.value > profile.maxMonths) months.value = profile.maxMonths;
  months.max = profile.maxMonths;

  vehiclePriceLabel.textContent = money(p);
  downPaymentLabel.textContent = money(d);
  monthsLabel.textContent = `${months.value} meses`;
  customRateLabel.textContent = percentAR(tna);
  financePrincipal.textContent = money(eligiblePrincipal);
  financeTna.textContent = percentAR(tna);
  financeTea.textContent = profile.tea == null ? 'Variable' : percentAR(profile.tea);
  financeCft.textContent = profile.cftTea == null ? 'A confirmar' : percentAR(profile.cftTea);
  monthlyEstimate.textContent = money(Math.round(schedule.first));
  financeTotal.textContent = money(Math.round(schedule.total));
  financeLegalNote.textContent = profile.note;
  customRateWrap.hidden = profileKey !== 'custom';

  const capped = eligiblePrincipal < principalRequested;
  const extra = capped ? ` El monto solicitado supera el máximo estimado de esta modalidad; se simuló ${money(eligiblePrincipal)}.` : '';
  document.getElementById('financeEstimateNote').textContent = `Incluye IVA estimado sobre intereses. No incluye seguro, sellos, patentamiento ni otros gastos.${extra}`;

    const vehicleLabel = selectedFinanceVehicle
    ? `${selectedFinanceVehicle.brand} ${selectedFinanceVehicle.model} ${selectedFinanceVehicle.year}`
    : `vehículo de ${money(p)}`;
  financeWhatsApp.href = `https://wa.me/5492901553973?text=${encodeURIComponent(`Hola, quiero consultar financiación por ${vehicleLabel}. Precio: ${money(p)}. Anticipo estimado: ${money(d)}. Monto a financiar: ${money(eligiblePrincipal)}. Plazo: ${months.value} meses. Referencia: ${profile.label}. TNA usada en la simulación: ${percentAR(tna)}. Primera cuota estimada: ${money(Math.round(schedule.first))}.`)}`;
};

['vehiclePrice', 'downPayment', 'months', 'customRate'].forEach(id => document.getElementById(id)?.addEventListener('input', calc));
financeProfile?.addEventListener('change', calc);
calc();

const alertM = document.getElementById('alertModal');
document.getElementById('openAlert').onclick = () => alertM.showModal();
document.querySelector('[data-close-alert]').onclick = () => alertM.close();
alertSubmit.onclick = () => {
  localStorage.setItem('autoariasLastAlert', JSON.stringify({
    name: alertName.value,
    phone: alertPhone.value,
    query: alertQuery.value,
    date: new Date().toISOString()
  }));
  alert('Búsqueda guardada correctamente.');
  alertM.close();
};

const vehicleRequestForm = document.getElementById('vehicleRequestForm');
if (vehicleRequestForm) {
  vehicleRequestForm.addEventListener('submit', event => {
    event.preventDefault();
    const request = {
      brand: document.getElementById('requestBrand').value.trim(),
      model: document.getElementById('requestModel').value.trim(),
      budget: document.getElementById('requestBudget').value.trim(),
      date: new Date().toISOString()
    };
    localStorage.setItem('autoariasVehicleRequest', JSON.stringify(request));
    const message = `Hola, estoy buscando un vehículo. Marca: ${request.brand}. Modelo: ${request.model}. Presupuesto: ${request.budget || 'a definir'}. Quiero que me avisen si ingresa una unidad compatible.`;
    window.open(`https://wa.me/5492901553973?text=${encodeURIComponent(message)}`, '_blank');
  });
}

const observer = new IntersectionObserver(entries => entries.forEach(entry => entry.isIntersecting && entry.target.classList.add('visible')), { threshold: .12 });
document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

renderInventory();

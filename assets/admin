const INVENTORY_KEY = 'autoariasInventory';
const INVENTORY_VERSION_KEY = 'autoariasInventoryVersion';
const INVENTORY_VERSION = 'autoarias-inventory-v2';
const FALLBACK_IMAGE = 'assets/vehicle-placeholder.svg';

// Inventario inicial de AutoArias. Podés editarlo desde este panel.
const defaults = [
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

const money = n => typeof n === 'number'
  ? new Intl.NumberFormat('es-AR', { style: 'currency', currency: 'ARS', maximumFractionDigits: 0 }).format(n)
  : 'Consultar';

const tbody = document.getElementById('adminInventory');

function parseGalleryInput(value) {
  if (!value) return [];
  return String(value)
    .split(/\s|,|\n/)
    .map(item => item.trim())
    .filter(item => item.startsWith('http'));
}

function normalizeVehicle(vehicle) {
  const gallery = Array.isArray(vehicle.gallery) && vehicle.gallery.length
    ? vehicle.gallery.filter(Boolean)
    : parseGalleryInput(vehicle.image);
  const cover = gallery[0] || vehicle.image || FALLBACK_IMAGE;
  return {
    ...vehicle,
    price: typeof vehicle.price === 'number' ? vehicle.price : null,
    image: cover,
    gallery: gallery.length ? gallery : []
  };
}

function loadInventory() {
  const storedVersion = localStorage.getItem(INVENTORY_VERSION_KEY);
  const stored = localStorage.getItem(INVENTORY_KEY);

  if (!stored || storedVersion !== INVENTORY_VERSION) {
    localStorage.setItem(INVENTORY_KEY, JSON.stringify(defaults));
    localStorage.setItem(INVENTORY_VERSION_KEY, INVENTORY_VERSION);
    return defaults.map(normalizeVehicle);
  }

  try {
    return JSON.parse(stored).map(normalizeVehicle);
  } catch (error) {
    localStorage.setItem(INVENTORY_KEY, JSON.stringify(defaults));
    localStorage.setItem(INVENTORY_VERSION_KEY, INVENTORY_VERSION);
    return defaults.map(normalizeVehicle);
  }
}

let inventory = loadInventory();

const save = () => {
  localStorage.setItem(INVENTORY_KEY, JSON.stringify(inventory));
  localStorage.setItem(INVENTORY_VERSION_KEY, INVENTORY_VERSION);
};

function render(list = inventory) {
  tbody.innerHTML = '';
  if (!list.length) {
    tbody.innerHTML = `<tr><td colspan="5"><div class="admin-empty"><strong>Inventario vacío</strong>Publicá la primera unidad de AutoArias desde “Publicar vehículo”.</div></td></tr>`;
    stats();
    return;
  }
  list.forEach(vehicle => tbody.insertAdjacentHTML('beforeend', `
    <tr>
      <td>
        <div class="admin-vehicle">
          <img src="${vehicle.gallery?.[0] || FALLBACK_IMAGE}" alt="${vehicle.brand} ${vehicle.model}" onerror="this.src='${FALLBACK_IMAGE}'">
          <div>
            <strong>${vehicle.brand} ${vehicle.model}</strong>
            <small>${vehicle.year} · ${vehicle.type} · ${vehicle.gallery?.length || 0} fotos</small>
          </div>
        </div>
      </td>
      <td>${money(vehicle.price)}</td>
      <td><span class="status-pill ${vehicle.sold ? 'sold' : ''}">${vehicle.sold ? 'Vendido' : 'Disponible'}</span></td>
      <td>${vehicle.featured ? 'Sí' : 'No'}</td>
      <td>
        <div class="table-actions">
          <button data-edit="${vehicle.id}">Editar</button>
          <button data-toggle="${vehicle.id}">${vehicle.sold ? 'Reactivar' : 'Vender'}</button>
          <button data-delete="${vehicle.id}">Eliminar</button>
        </div>
      </td>
    </tr>
  `));

  document.querySelectorAll('[data-edit]').forEach(button => button.onclick = () => editVehicle(button.dataset.edit));
  document.querySelectorAll('[data-toggle]').forEach(button => button.onclick = () => toggleSold(button.dataset.toggle));
  document.querySelectorAll('[data-delete]').forEach(button => button.onclick = () => deleteVehicle(button.dataset.delete));
  stats();
}

function stats() {
  statPublished.textContent = inventory.length;
  statAvailable.textContent = inventory.filter(v => !v.sold).length;
  statSold.textContent = inventory.filter(v => v.sold).length;
  statFeatured.textContent = inventory.filter(v => v.featured).length;
}

const dialog = document.getElementById('vehicleFormDialog');
addVehicleBtn.onclick = () => openForm();
closeVehicleForm.onclick = () => dialog.close();

function openForm(vehicle) {
  vehicleForm.reset();
  vehicleId.value = vehicle?.id || '';
  formTitle.textContent = vehicle ? 'Editar vehículo' : 'Agregar vehículo';
  if (vehicle) {
    vehicleBrand.value = vehicle.brand;
    vehicleModel.value = vehicle.model;
    vehicleYear.value = vehicle.year;
    vehiclePriceInput.value = vehicle.price ?? '';
    vehicleTypeInput.value = vehicle.type;
    vehicleMileage.value = vehicle.mileage;
    vehicleTransmission.value = vehicle.transmission;
    vehicleColor.value = vehicle.color;
    vehicleImage.value = (vehicle.gallery && vehicle.gallery.length ? vehicle.gallery : [vehicle.image]).join('\n');
    vehicleDescription.value = vehicle.description || '';
    vehicleFeatured.checked = vehicle.featured;
    vehicleSold.checked = vehicle.sold;
  }
  dialog.showModal();
}

function editVehicle(id) {
  openForm(inventory.find(vehicle => vehicle.id === id));
}

function toggleSold(id) {
  const vehicle = inventory.find(item => item.id === id);
  vehicle.sold = !vehicle.sold;
  save();
  render();
}

function deleteVehicle(id) {
  if (confirm('¿Eliminar este vehículo?')) {
    inventory = inventory.filter(vehicle => vehicle.id !== id);
    save();
    render();
  }
}

vehicleForm.onsubmit = event => {
  event.preventDefault();
  const gallery = parseGalleryInput(vehicleImage.value.trim());
  const data = normalizeVehicle({
    id: vehicleId.value || crypto.randomUUID(),
    brand: vehicleBrand.value.trim(),
    model: vehicleModel.value.trim(),
    year: +vehicleYear.value,
    price: vehiclePriceInput.value ? +vehiclePriceInput.value : null,
    type: vehicleTypeInput.value,
    mileage: vehicleMileage.value.trim() || 'A consultar',
    transmission: vehicleTransmission.value.trim() || 'Automática',
    color: vehicleColor.value.trim() || 'A consultar',
    image: gallery[0] || FALLBACK_IMAGE,
    gallery,
    description: vehicleDescription.value.trim(),
    featured: vehicleFeatured.checked,
    sold: vehicleSold.checked
  });

  const index = inventory.findIndex(vehicle => vehicle.id === data.id);
  if (index >= 0) inventory[index] = data;
  else inventory.unshift(data);

  save();
  render();
  dialog.close();
};

adminSearch.oninput = () => {
  const q = adminSearch.value.toLowerCase();
  render(inventory.filter(vehicle => `${vehicle.brand} ${vehicle.model} ${vehicle.year}`.toLowerCase().includes(q)));
};

render();

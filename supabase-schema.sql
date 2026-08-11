-- AutoArias · Ushuaia, Tierra del Fuego
-- Campo mileage se utiliza como kilometraje en la interfaz.
create extension if not exists "pgcrypto";

create table if not exists vehicles (
  id uuid primary key default gen_random_uuid(),
  brand text not null,
  model text not null,
  year integer not null,
  price numeric,
  type text,
  mileage text,
  transmission text,
  color text,
  description text,
  image_url text,
  gallery jsonb default '[]'::jsonb,
  featured boolean default false,
  sold boolean default false,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  name text,
  phone text,
  source text,
  vehicle_id uuid references vehicles(id) on delete set null,
  message text,
  created_at timestamptz default now()
);

alter table vehicles enable row level security;
alter table leads enable row level security;

create policy "Public can read vehicles" on vehicles for select using (true);
create policy "Authenticated users manage vehicles" on vehicles for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "Public can create leads" on leads for insert with check (true);
create policy "Authenticated users read leads" on leads for select using (auth.role() = 'authenticated');

-- 1. configuración global

create table public.store_settings(
    id uuid default gen_random_uuid() primary key,
    store_name text not null default 'Mi Tienda',
    mercado_pago_public_key text,
    mercado_pago_public_key text,
    shipping_methods jsonb default '{"fixed_rate": {"enabled": true, "cost": 0}, "store_pichup": {"enabled": true}}'::jsonb,
    cancelation_button_url text,
    contact_email text,
    whatsapp_number text,
    update_at timestamp with time zone default timezone('utc'::text, now()) not null
);

--2. RLS

alter table public.store_settings enable row level security;

--3. Política de lectura pública

create policy "Permitir lectura pública de configuraciones de tienda"
    on public.store_settings
    for select
    using (true);

--4. Política de control total para administrador:

create policy "Permitir control total al admin en store_settings"
    on public.store_settings
    for all
    using (true)
    with check (true);
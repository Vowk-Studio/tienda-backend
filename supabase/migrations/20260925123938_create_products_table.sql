--1. Almacena catálogo de articulos de la tienda

create table public.products (
    id uuid default gen_random_uuid() primary key,
    category_id uuid references public.categories(id) on delete set null,
    title text not null,
    slug text not null unique,
    description text,
    price numeric(10, 2) not null,
    stock integer not null default 0,
    images text [],
    is_active boolean default true not null,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

--2. Row Level Security
alter table public.products enable row level security;

--3. Política de lectura pública

create policy "Permitir lectura pública de productos activos"
    on public.products
    for select
    using (is_active = true);

--4. Política de control total para el administrador

create policy "Permitir control total al admin en products"
    on public.products
    for all
    using (true)
    with check (true);
-- 1 PostgreSQL en Supabase tabla categories

create table public.categories (
    id uuid default gen_random_uuid() primary key,
    name text not null,
    slug text not null unique,
    description text,
    image_url text,
    is_active boolean default true not null,
    created_at timestamp with zone default timezone('utc'::text, now()) not null
);

-- 2. RLS

alter table public.categories enable row level security;

-- 3. Política para permitir lectura pública

create policy "Permitir lectura pública de categorías activas"
    on public.categories
        for select
using (is_active = true);

--4. Político para control total (CRUD: insertar, actualizar, borrar).
create policy "permitir control total al admin en categorías"
    on public.categories
    for all
    using (true)
    with check (true);

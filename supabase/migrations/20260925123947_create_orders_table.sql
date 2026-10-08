--1 tabla para almacenar las compras

create table public.orders(

    id uuid default gen_random_uuid() primary key,
    status text not null default 'pending',
    total_amount numeric (10, 2) not null,

    customer_name text not null,
    customer_email text not null,
    customer_phone text,
    shipping_address text not null,

    items jsonb not null,
    mercado_pago_preference_id text,
    mercado_pago_payment_id text,

    created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 2. Row Level Security (RLS)

alter table public.orders enable row level security;

-- 3 Política de inserción pública

create policy "Permitir crear órdenes desde el checkout"
    on public.orders
    for insert
    with check (true);

-- 4 Política de lectura/actualización para admin

create policy "Permitir control total al admin en orders"
    on public.orders
    for all
    using (true)
    with check (true);
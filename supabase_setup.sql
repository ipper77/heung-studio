-- HEUNG STUDIO portfolio CMS setup
-- Run this SQL in Supabase Dashboard > SQL Editor.
create table if not exists public.projects (
  id text primary key,
  title text not null,
  category text not null check (category in ('identity','graphic','package','digital')),
  meta text default '',
  year text default '',
  image_url text,
  image_path text,
  sort_order bigint default 0,
  created_at timestamptz not null default now()
);

alter table public.projects enable row level security;

drop policy if exists "Public can view projects" on public.projects;
create policy "Public can view projects"
on public.projects for select
to anon, authenticated
using (true);

drop policy if exists "Signed-in admin can insert projects" on public.projects;
create policy "Signed-in admin can insert projects"
on public.projects for insert
to authenticated
with check (auth.uid() is not null);

drop policy if exists "Signed-in admin can update projects" on public.projects;
create policy "Signed-in admin can update projects"
on public.projects for update
to authenticated
using (auth.uid() is not null)
with check (auth.uid() is not null);

drop policy if exists "Signed-in admin can delete projects" on public.projects;
create policy "Signed-in admin can delete projects"
on public.projects for delete
to authenticated
using (auth.uid() is not null);

-- Create a public image bucket.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('project-images', 'project-images', true, 8388608, array['image/png','image/jpeg','image/webp'])
on conflict (id) do update set public = true, file_size_limit = 8388608, allowed_mime_types = array['image/png','image/jpeg','image/webp'];

drop policy if exists "Public can view portfolio images" on storage.objects;
create policy "Public can view portfolio images"
on storage.objects for select
to anon, authenticated
using (bucket_id = 'project-images');

drop policy if exists "Signed-in admin can upload portfolio images" on storage.objects;
create policy "Signed-in admin can upload portfolio images"
on storage.objects for insert
to authenticated
with check (bucket_id = 'project-images' and auth.uid() is not null);

drop policy if exists "Signed-in admin can update portfolio images" on storage.objects;
create policy "Signed-in admin can update portfolio images"
on storage.objects for update
to authenticated
using (bucket_id = 'project-images' and auth.uid() is not null)
with check (bucket_id = 'project-images' and auth.uid() is not null);

drop policy if exists "Signed-in admin can delete portfolio images" on storage.objects;
create policy "Signed-in admin can delete portfolio images"
on storage.objects for delete
to authenticated
using (bucket_id = 'project-images' and auth.uid() is not null);

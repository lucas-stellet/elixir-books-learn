# like statements
q = from(a in "artists", where: like(a.name, "Miles%"), select: [:id, :name])

# checking for null
q = from(a in "artists", where: is_nil(a.name), select: [:id, :name])

# checking for not null
q = from(a in "artists", where: not is_nil(a.name), select: [:id, :name])

# date comparison
q =
  from(a in "artists", where: a.inserted_at > ago(1, "year"), select: [:id, :name, :inserted_at])

## Inserting Raw SQL

q = from(a in "artists", where: lower(a.name) == "miles davis", select: [:id, :name])

defmodule MusicDB.Macros do
  defmacro lower(arg) do
    quote do
      fragment("lower(?)", unquote(arg))
    end
  end
end

## union and union_all

tracks_query = from(t in "tracks", select: t.title)
union_query = from(a in "albums", select: a.title, union: ^tracks_query)

union_query = from(a in "albums", select: a.title, union_all: ^tracks_query)

## Ordering and Grouping

q = from(a in "artists", select: a.name, order_by: a.name)

q = from(a in "artists", select: a.name, order_by: [desc: a.name])

q = from(t in "tracks", select: [t.album_id, t.title, t.index], order_by: [t.album_id, t.index])

q =
  from(t in "tracks",
    select: [t.album_id, t.title, t.index],
    order_by: [desc: t.album_id, asc: t.index]
  )

q =
  from t in "tracks",
    select: [t.album_id, sum(t.duration)],
    group_by: t.album_id,
    having: sum(t.duration) > 3600


## Working with Joins

q =
  from t in "tracks",
    join: a in "albums",
    on: t.album_id == a.id,
    where: t.duration > 900,
    select: %{album: a.title, track: t.title}

## Composing Queries

q =
  from a in "albums",
  join: ar in "artists",
  on: a.artist_id == ar.id ,
  where: ar.name == "Miles Davis",
  select: a.title


albums_by_miles =
  from a in "albums",
  join: ar in "artists", on: a.artist_id == ar.id,
  where: ar.name == "Miles Davis"

album_query =
  from a in albums_by_miles, select: a.title

album_query = from [a, ar] in album_query, select: a.title

track_query = from a in albums_by_miles,
  join: t in "tracks", on: a.id == t.album_id,
  select: t.title


  ## Working with Named Bindings

  albums_by_miles = from a in "albums", as: :albums,
  join: ar in "artists", as: :artists,
  on: a.artist_id == ar.id, where: ar.name == "Miles Davis"

  album_query = from [albums: a] in albums_by_miles, select: a.title

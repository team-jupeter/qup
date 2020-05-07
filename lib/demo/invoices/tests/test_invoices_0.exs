import ExUnit.Assertions

import Ecto.Changeset
alias Demo.{Repo, Artist, Band, SoloArtist}

import ExUnit.Assertions

import Ecto.Changeset
alias Ecto.Changeset
alias MusicDB.{Repo, AlbumWithEmbeds, TrackEmbed}

album = Repo.get_by(AlbumWithEmbeds, title: "Moanin'")
changeset = change(album)
changeset = put_embed(changeset, :artist, %{name: "Arthur Blakey"})
changeset = put_embed(changeset, :tracks,
  [%TrackEmbed{title: "Jupeter'"}])

assert %Changeset{} = changeset

album = Repo.get_by(AlbumWithEmbeds, title: "Moanin'")
changeset = change(album)
changeset = put_embed(changeset, :artist, %{name: "Arthur Blakey"})
#=> #Ecto.Changeset<
#=>  action: nil,
#=>  changes: %{
#=>    artist: #Ecto.Changeset<
#=>      action: :insert,
#=>      changes: %{name: "Arthur Blakey"},
#=>      errors: [],
#=>      data: #MusicDB.ArtistEmbed<>,
#=>      valid?: true
#=>    >
#=>  },
#=>  errors: [],
#=>  data: #MusicDB.AlbumWithEmbeds<>,
#=>  valid?: true
#=> >

assert %Changeset{changes: %{artist: %Changeset{}}} = changeset

#?

album = Repo.get_by(AlbumWithEmbeds, title: "Moanin'")
params = %{
  "artist" => %{"name" => "Jupeter"},
  "tracks" => [%{"title" => "Team Jupeter'"}]
}

changeset = cast(album, params, [])
changeset = cast_embed(changeset, :artist)
changeset = cast_embed(changeset, :tracks)

assert %Changeset{} = changeset


#? 

params = %{name: "580 West", year_started: 1991, year_ended: 1995}
band = #? %Band{}
  %Band{}
  |> Band.changeset(params)
  |> apply_changes()

Repo.insert_all("artists", [Band.to_artist(band)])


params = %{name1: "John", name2: "Cougar", name3: "Mellencamp",
  birth_date: ~D[1951-10-07]}
solo_artist =
  %SoloArtist{}
  |> SoloArtist.changeset(params)
  |> apply_changes()

Repo.insert_all("artists", [SoloArtist.to_artist(solo_artist)])

assert %Artist{name: "580 West"} = Repo.get_by(Artist, name: "580 West")
assert %Artist{name: "John Cougar Mellencamp"} = Repo.get_by(Artist, name: "John Cougar Mellencamp")

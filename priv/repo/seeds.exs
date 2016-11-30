# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     UpcomingShowFinder.Repo.insert!(%UpcomingShowFinder.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias UpcomingShowFinder.Repo
alias UpcomingShowFinder.Source

Repo.insert!(%Source{venue_name: "Royale", location: "Boston, MA", parser: "Songkick", url: "https://www.songkick.com/venues/895621-royale/calendar"})
Repo.insert!(%Source{venue_name: "The Sinclair", location: "Cambridge, MA", parser: "Songkick", url: "https://www.songkick.com/venues/1974904-sinclair/calendar"})
Repo.insert!(%Source{venue_name: "Great Scott", location: "Allston, MA", parser: "Songkick", url: "https://www.songkick.com/venues/296-great-scott/calendar"})
Repo.insert!(%Source{venue_name: "The Middle East Downstairs", location: "Cambridge, MA", parser: "Songkick", url: "https://www.songkick.com/venues/7694-middle-east-downstairs/calendar"})
Repo.insert!(%Source{venue_name: "O'Brien's Pub", location: "Allston, MA", parser: "Songkick", url: "https://www.songkick.com/venues/57468-obriens-pub/calendar"})

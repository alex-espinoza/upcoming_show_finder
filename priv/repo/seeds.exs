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

Repo.insert!(%Source{venue_name: "Royale", location: "Boston, MA", parser: "Royale", url: "http://royaleboston.com/events/category/concerts/photo/"})

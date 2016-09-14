defmodule UpcomingShowFinder.SourceTest do
  use UpcomingShowFinder.ModelCase

  alias UpcomingShowFinder.Source

  @valid_attrs %{enabled: 42, location: "some content", parser: "some content", url: "some content", venue_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Source.changeset(%Source{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Source.changeset(%Source{}, @invalid_attrs)
    refute changeset.valid?
  end
end

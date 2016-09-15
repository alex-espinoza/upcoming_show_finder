defmodule UpcomingShowFinder.ShowTest do
  use UpcomingShowFinder.ModelCase

  alias UpcomingShowFinder.Show

  @valid_attrs %{date: "some content", headliner: "some content", openers: "some content", price: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Show.changeset(%Show{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Show.changeset(%Show{}, @invalid_attrs)
    refute changeset.valid?
  end
end

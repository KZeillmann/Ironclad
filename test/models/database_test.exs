defmodule Ironclad.DatabaseTest do
  use Ironclad.ModelCase

  alias Ironclad.Database

  @valid_attrs %{location: "some content", name: "some content", password: "some content", port: 42, type: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Database.changeset(%Database{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Database.changeset(%Database{}, @invalid_attrs)
    refute changeset.valid?
  end
end

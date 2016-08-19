defmodule Ironclad.DatabaseControllerTest do
  use Ironclad.ConnCase

  alias Ironclad.Database
  @valid_attrs %{location: "some content", name: "some content", password: "some content", port: 42, type: "some content", username: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, database_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing databases"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, database_path(conn, :new)
    assert html_response(conn, 200) =~ "New database"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, database_path(conn, :create), database: @valid_attrs
    assert redirected_to(conn) == database_path(conn, :index)
    assert Repo.get_by(Database, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, database_path(conn, :create), database: @invalid_attrs
    assert html_response(conn, 200) =~ "New database"
  end

  test "shows chosen resource", %{conn: conn} do
    database = Repo.insert! %Database{}
    conn = get conn, database_path(conn, :show, database)
    assert html_response(conn, 200) =~ "Show database"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, database_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    database = Repo.insert! %Database{}
    conn = get conn, database_path(conn, :edit, database)
    assert html_response(conn, 200) =~ "Edit database"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    database = Repo.insert! %Database{}
    conn = put conn, database_path(conn, :update, database), database: @valid_attrs
    assert redirected_to(conn) == database_path(conn, :show, database)
    assert Repo.get_by(Database, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    database = Repo.insert! %Database{}
    conn = put conn, database_path(conn, :update, database), database: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit database"
  end

  test "deletes chosen resource", %{conn: conn} do
    database = Repo.insert! %Database{}
    conn = delete conn, database_path(conn, :delete, database)
    assert redirected_to(conn) == database_path(conn, :index)
    refute Repo.get(Database, database.id)
  end
end

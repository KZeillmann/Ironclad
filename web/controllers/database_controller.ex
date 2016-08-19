defmodule Ironclad.DatabaseController do
  use Ironclad.Web, :controller

  alias Ironclad.Database

  def index(conn, _params) do
    databases = Repo.all(Database)
    render(conn, "index.html", databases: databases)
  end

  def new(conn, _params) do
    changeset = Database.changeset(%Database{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"database" => database_params}) do
    changeset = Database.changeset(%Database{}, database_params)

    case Repo.insert(changeset) do
      {:ok, _database} ->
        conn
        |> put_flash(:info, "Database created successfully.")
        |> redirect(to: database_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    database = Repo.get!(Database, id)
    render(conn, "show.html", database: database)
  end

  def edit(conn, %{"id" => id}) do
    database = Repo.get!(Database, id)
    changeset = Database.changeset(database)
    render(conn, "edit.html", database: database, changeset: changeset)
  end

  def update(conn, %{"id" => id, "database" => database_params}) do
    database = Repo.get!(Database, id)
    changeset = Database.changeset(database, database_params)

    case Repo.update(changeset) do
      {:ok, database} ->
        conn
        |> put_flash(:info, "Database updated successfully.")
        |> redirect(to: database_path(conn, :show, database))
      {:error, changeset} ->
        render(conn, "edit.html", database: database, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    database = Repo.get!(Database, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(database)

    conn
    |> put_flash(:info, "Database deleted successfully.")
    |> redirect(to: database_path(conn, :index))
  end
end

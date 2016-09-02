defmodule Ironclad.Repo.Migrations.CreateDatabase do
  use Ecto.Migration

  def change do
    create table(:databases) do
      add :type, :string
      add :name, :string
      add :username, :string
      add :password, :string
      add :port, :integer
      add :location, :string
      add :database, :string

      timestamps()
    end

  end
end

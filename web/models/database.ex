defmodule Ironclad.Database do
  use Ironclad.Web, :model

  schema "databases" do
    field :type, :string
    field :name, :string
    field :username, :string
    field :password, :string
    field :port, :integer
    field :location, :string
    field :database, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type, :name, :username, :password, :port, :location, :database])
    |> validate_required([:type, :name, :username, :password, :port, :location, :database])
  end
end

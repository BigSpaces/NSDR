defmodule Nsdr.Newsletter.Subscriber do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subscribers" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(subscriber, attrs) do
    subscriber
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end

defmodule Nsdr.Mailing.Members do
  use Ecto.Schema
  import Ecto.Changeset
  

  schema "member" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(members, attrs) do
    members
    |> cast(attrs, [:name, :email])
    #|> validate_format(:email, @mail_regex)
    |> validate_required([:name, :email])
  end
end

defmodule Nsdr.Mailing do
  @moduledoc """
  The Mailing context.
  """

  import Ecto.Query, warn: false
  alias Nsdr.Repo

  alias Nsdr.Mailing.Members

  @doc """
  Returns the list of member.

  ## Examples

      iex> list_member()
      [%Members{}, ...]

  """
  def list_member do
    Repo.all(Members)
  end

  @doc """
  Gets a single members.

  Raises `Ecto.NoResultsError` if the Members does not exist.

  ## Examples

      iex> get_members!(123)
      %Members{}

      iex> get_members!(456)
      ** (Ecto.NoResultsError)

  """
  def get_members!(id), do: Repo.get!(Members, id)

  @doc """
  Creates a members.

  ## Examples

      iex> create_members(%{field: value})
      {:ok, %Members{}}

      iex> create_members(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_members(attrs \\ %{}) do
    %Members{}
    |> Members.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a members.

  ## Examples

      iex> update_members(members, %{field: new_value})
      {:ok, %Members{}}

      iex> update_members(members, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_members(%Members{} = members, attrs) do
    members
    |> Members.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a members.

  ## Examples

      iex> delete_members(members)
      {:ok, %Members{}}

      iex> delete_members(members)
      {:error, %Ecto.Changeset{}}

  """
  def delete_members(%Members{} = members) do
    Repo.delete(members)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking members changes.

  ## Examples

      iex> change_members(members)
      %Ecto.Changeset{data: %Members{}}

  """
  def change_members(%Members{} = members, attrs \\ %{}) do
    Members.changeset(members, attrs)
  end
end

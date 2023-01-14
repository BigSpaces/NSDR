defmodule Nsdr.MailingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Nsdr.Mailing` context.
  """

  @doc """
  Generate a members.
  """
  def members_fixture(attrs \\ %{}) do
    {:ok, members} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name"
      })
      |> Nsdr.Mailing.create_members()

    members
  end
end

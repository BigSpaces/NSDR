defmodule Nsdr.NewsletterFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Nsdr.Newsletter` context.
  """

  @doc """
  Generate a subscriber.
  """
  def subscriber_fixture(attrs \\ %{}) do
    {:ok, subscriber} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name"
      })
      |> Nsdr.Newsletter.create_subscriber()

    subscriber
  end
end

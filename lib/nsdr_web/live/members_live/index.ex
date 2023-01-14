defmodule NsdrWeb.MembersLive.Index do
  use NsdrWeb, :live_view

  alias Nsdr.Mailing
  alias Nsdr.Mailing.Members

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :member, list_member())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Members")
    |> assign(:members, Mailing.get_members!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Members")
    |> assign(:members, %Members{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Member")
    |> assign(:members, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    members = Mailing.get_members!(id)
    {:ok, _} = Mailing.delete_members(members)

    {:noreply, assign(socket, :member, list_member())}
  end

  defp list_member do
    Mailing.list_member()
  end
end

defmodule NsdrWeb.MembersLive.Show do
  use NsdrWeb, :live_view

  alias Nsdr.Mailing

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:members, Mailing.get_members!(id))}
  end

  defp page_title(:show), do: "Show Members"
  defp page_title(:edit), do: "Edit Members"
end

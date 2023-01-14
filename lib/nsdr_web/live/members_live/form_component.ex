defmodule NsdrWeb.MembersLive.FormComponent do
  use NsdrWeb, :live_component

  alias Nsdr.Mailing

  @impl true
  def update(%{members: members} = assigns, socket) do
    changeset = Mailing.change_members(members)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"members" => members_params}, socket) do
    changeset =
      socket.assigns.members
      |> Mailing.change_members(members_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"members" => members_params}, socket) do
    save_members(socket, socket.assigns.action, members_params)
  end

  defp save_members(socket, :edit, members_params) do
    case Mailing.update_members(socket.assigns.members, members_params) do
      {:ok, _members} ->
        {:noreply,
         socket
         |> put_flash(:info, "Members updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_members(socket, :new, members_params) do
    case Mailing.create_members(members_params) do
      {:ok, _members} ->
        {:noreply,
         socket
         |> put_flash(:info, "Members created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

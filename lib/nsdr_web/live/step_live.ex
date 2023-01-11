defmodule NsdrWeb.StepLive do
  # In Phoenix v1.6+ apps, the line below should be: use MyAppWeb, :live_view
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
      My first Liveview
      <%= if assigns.live_action == :step1 do %>
        <h1>THIS IS STEP 1</h1>
        <%= link_patch "My Link to Step 2", [to: "/step2"] %>

      <% end %>
      <%= if assigns.live_action == :step2 do %>
        <h1>THIS IS STEP 2</h1>
      <% end %>
      <%= if assigns.live_action == :step3 do %>
        <h1>THIS IS STEP 3</h1>
      <% end %>
    """
  end

  def mount(_params, _session, socket) do
    IO.inspect(socket.assigns.live_action, label: "MOUNTED")
    {:ok, socket}
  end
end

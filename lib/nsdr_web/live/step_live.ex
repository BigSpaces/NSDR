defmodule NsdrWeb.StepLive do

  use Phoenix.LiveView
  use Phoenix.HTML
  use NsdrWeb, :live_view
  alias Nsdr.Mailing
  alias Nsdr.Mailing.Members



  def mount(_params, _session, socket) do

    changeset = Mailing.change_members(%Members{})
    new_socket = assign(socket, changeset: changeset)
    {:ok, new_socket}
  end


  def render(assigns) do


    ~H"""
      <%= if assigns.live_action == :step1 do %>
      <.step1 />
      <% end %>
      <%= if assigns.live_action == :step2 do %>
      <.step2 choice1={assigns.choice1} />
      <% end %>
      <%= if assigns.live_action == :step3 do %>
      <.step3 choice1={assigns.choice1} duration={assigns.duration} />

      <% end %>
      <%= if assigns.live_action == :play do %>
      <.play choice1={assigns.choice1} duration={assigns.duration} background={assigns.background} changeset={@changeset}/>
      <% end %>
    """
  end

  def step1(assigns) do
    next_link = "step2?choice1="

    ~H"""


      <div class="flex w-screen justify-center items-center ">
        <div class="lg:grid-rows-1 lg:grid-cols-3 grid-cols-1 grid-rows-3">

         <.option_card title="Nidra / NSDR" link={next_link} option="nidra">
         Enjoy conscious rest. One hour of NSDR or Nidra is said to be equivalent to three hours of sleep
         </.option_card>
         <.option_card title="Inner Silence" link={next_link} option="antar">
         Ventilate your mind. Detach from the mental noise. Cultivate Silence.
         </.option_card>
         <.option_card title="Body Scan" link={next_link} option="scan">
         A proven and quick way to relax your body and mind
         </.option_card>
        </div>
      </div>
    """
  end

  def step2(assigns) do

    next_link = "/step3?choice1=#{assigns.choice1}&duration="

    ~H"""
       <div class="flex w-screen justify-center items-center ">
        <div class="lg:grid-rows-1 lg:grid-cols-3 grid-cols-1 grid-rows-3">
         <.option_card title="Short (5 to 10 mins)" link={next_link} option="short">
         Sometimes a few minutes is all you need.
         </.option_card>
         <.option_card title="Medium (around 30 mins)" link={next_link} option="medium">
         A lot can be achieved in 30 minutes of dedicated practice.
         </.option_card>
         <.option_card title="One hour" link={next_link} option="long">
         Enough time to go deep and profound!
         </.option_card>
      </div>
      </div>
    """
  end

  def step3(assigns) do

    next_link = "play?choice1=#{assigns.choice1}&duration=#{assigns.duration}&background="

    ~H"""
       <div class="flex w-screen justify-center items-center ">
        <div class="lg:grid-rows-1 lg:grid-cols-3 grid-cols-1 grid-rows-3">
         <.option_card title="No background" link={next_link} option="silence" >
         No music, no ambient track. Zip, nada.
         </.option_card>
         <.option_card title="Music" link={next_link} option="music" >
         Let ambient music take you places
         </.option_card>
         <.option_card title="Nature FX" link={next_link} option="ambient" >
         Background effects track to place your mind in a different environment
         </.option_card>
        </div>
      </div>
    """
  end

  defp message_to_user(choice1, duration, background) do
    choice1_message =
      case choice1 do
        "nidra" -> "deep rest practice. "
        "scan" -> "body scan practice. "
        "antar" -> "inner silence practice. "
        _ -> "practice."
      end
        duration_message =
      case duration do
        "short" -> "between 5 and 10 minutes. "
        "medium" -> "about half an hour. "
        "long" -> "one full hour. "
        _ -> "whatever time it takes you to complete. "
      end
        background_message =
      case background do
        "silence" -> "perfect silence in the background. "
        "music" -> "some nice background music. "
        "ambient" -> "virtual surround, 8D ambient sounds (headphones required). "
        _ -> "a surprise background soundtrack feature. "
      end

    "You have chosen a #{choice1_message} It will take you #{duration_message} You will enjoy #{background_message}"

  end

  def play(assigns) do

    fileurl = ""

    ~H"""
    <div class="h-screen w-screen grid justify-center items-center">
        <p class="text-xl text-center text-slate-50 text-center font-mukta">Your practice is ready! </p>

                <p class="text-center text-xl text-slate-50 font-mukta"><%= message_to_user(@choice1, @duration, @background) %></p>
                <p class="text-center text-xl text-slate-50 font-mukta">Shut off all distractions. May you benefit from this practice.</p>
                    <div class="w-100">

                        <.meditation_player></.meditation_player>

                    </div>
                <br>


                <p class="text-center text-xl text-slate-50 text-center font-mukta">There is too much tension in the world. Please consider telling others about this page, and stay up to date by subscribing to our newsletter below.</p>

    <div class="text-center text-xl text-slate-50 text-center font-mukta">

    <.my_form changeset={assigns.changeset}>
    </.my_form>
    </div></div>
    """
  end



  def my_form(assigns) do
    ~H"""
    <.form class="text-black" let={f} for={@changeset} phx-submit="save">
    <%= label f, :name %>
    <%= text_input f, :name %>
    <%= error_tag f, :name %>
    <%= label f, :email %>
    <%= text_input f, :email %>
    <%= error_tag f, :email %>

    <br>
    <%= submit "Save" %>
    </.form>
    """
  end

  def meditation_player(assigns) do
    ~H"""
    <audio id="background" class="hidden" controls>
    <source src="/audio/drone.mp3"  type="audio/mpeg">
    Your browser does not support the audio element.
    </audio>
    <audio id="narration" class="hidden" controls>
    <source src="/audio/narration.mp3" type="audio/mpeg">
    Your browser does not support the audio element.
    </audio>
    <button class="font-mukta text-white bg-gradient-to-r from-gray-500 via-gray-600 to-gray-700 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-gray-300 dark:focus:ring-gray-800 shadow-lg shadow-gray-500/50 dark:shadow-lg dark:shadow-gray-800/80 font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-2 mb-2" onclick="document.getElementById('background').play(); document.getElementById('narration').play()">Play</button>
    <button class="font-mukta text-white bg-gradient-to-r from-gray-500 via-gray-600 to-gray-700 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-gray-300 dark:focus:ring-gray-800 shadow-lg shadow-gray-500/50 dark:shadow-lg dark:shadow-gray-800/80 font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-2 mb-2" onclick="document.getElementById('background').pause(); document.getElementById('narration').pause()">Pause</button>
    """
  end

  def handle_params(params, uri, socket) do
    IO.inspect(params, label: "INSPARAMS")

    new_socket =
      assign(socket,
        choice1: params["choice1"],
        duration: params["duration"],
        background: params["background"],
        uri: uri
      )

    IO.inspect(new_socket.assigns, label: "AFTERASSIGNS")
    {:noreply, new_socket}
  end

  @doc """
  Renders an option card
  Dynamically generates the query params based on the options available in the current step (@link)
  plus the choices already made, which are stored in
     assigns.choice1
     assigns.duration
     assigns.background
  """

  def option_card(assigns) do
    ~H"""
      <div class="py-4">
      <div class="mx-8 w-80 border-4 border-neutral-200 h-48 rounded-md bg-slate-300  divide-y">
        <h3 class="hover:bg-slate-400 pt-4 pb-2 text-xl text-stone-800 text-center font-heebo">
        <%= live_patch @title, [to: assigns.link<>assigns.option] %></h3>
        <p class="p-8 text-stone-800 text-center font-mukta"><%= render_slot(@inner_block) %></p>
      </div></div>
    """
  end

  def handle_event("save", %{"members" => subscriber_params}, socket) do
    IO.inspect(subscriber_params, label: "AM I SAVED?")
    Mailing.create_members(subscriber_params) |> IO.inspect(label: "CREATE MEMBERS")
    changeset = Mailing.change_members(%Members{})
    new_socket = assign(socket, changeset: changeset)
    {:ok, new_socket}

  end


end

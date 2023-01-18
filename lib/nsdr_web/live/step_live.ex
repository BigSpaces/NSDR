defmodule NsdrWeb.StepLive do
  @moduledoc """

  This module is responsible for the main functions of the software:
  - It will render the options in each step
  - It will pass on the options to each step consecutively
  - It will select the appropriate audio files and allow the user to play the meditation practice
  - It will provide the option to subscribe to a mailing list


  """
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
      <.choose_practice />
      <% end %>
      <%= if assigns.live_action == :step2 do %>
      <.choose_duration choice1={assigns.choice1} />
      <% end %>
      <%= if assigns.live_action == :step3 do %>
      <.choose_background choice1={assigns.choice1} duration={assigns.duration} />

      <% end %>
      <%= if assigns.live_action == :play do %>
      <.deliver_practice choice1={assigns.choice1} duration={assigns.duration} background={assigns.background} changeset={@changeset}/>
      <% end %>
    """
  end



  def choose_practice(assigns) do
    next_link = "step2?choice1="

    ~H"""
      <div class="w-screen my-4 flex text-white grid text-center text-lg font-mukta"><strong>Welcome!</strong></div>
      <div class="w-screen my-2 px-10 flex text-white grid text-center text-l font-mukta">In this site you can craft a customized meditative practice.</div>
      <div class="w-screen my-2 mb-10 px-10 flex text-white grid text-center text-l font-mukta">Please begin by selecting the type of practice that suits you today.</div>

      <div class="flex w-screen justify-center items-center ">
        <div class="grid gap-6 grid-rows-3 lg:grid-cols-3">

         <.option_card id="nidra" title="Nidra / NSDR" link={next_link} option="nidra">
         Enjoy conscious rest. One hour of NSDR or Nidra is said to be equivalent to three hours of sleep
         </.option_card>
         <.option_card id="antar" title="Inner Silence" link={next_link} option="antar">
         Ventilate your mind. Detach from the mental noise. Cultivate Silence.
         </.option_card>
         <.option_card id="scan" title="Body Scan" link={next_link} option="scan">
         A proven and quick way to relax your body and mind
         </.option_card>
        </div>
      </div>
    """
  end



  def choose_duration(assigns) do
    next_link = "/step3?choice1=#{assigns.choice1}&duration="

    ~H"""
      <div class="w-screen my-4 flex text-white grid text-center text-lg font-mukta"><strong>Fantastic choice!</strong></div>
      <div class="w-screen my-2 px-10 flex text-white grid text-center text-l font-mukta">Now... how long do you have to practice?</div>
      <div class="w-screen my-2 mb-10 px-10 flex text-white grid text-center text-l font-mukta">In this type of business what matters most is that you take the time.</div>


       <div class="flex w-screen justify-center items-center ">
       <div class="grid gap-6 grid-rows-3 lg:grid-cols-3">
         <.option_card id="short" title="Short (5 to 10 mins)" link={next_link} option="short">
         Sometimes a few minutes is all you need.
         </.option_card>
         <.option_card id="medium" title="Medium (around 30 mins)" link={next_link} option="medium">
         A lot can be achieved in 30 minutes of dedicated practice.
         </.option_card>
         <.option_card id="long" title="One hour" link={next_link} option="long">
         Enough time to go deep and profound!
         </.option_card>
      </div>
      </div>
    """
  end

  def choose_background(assigns) do
    next_link = "play?choice1=#{assigns.choice1}&duration=#{assigns.duration}&background="

    ~H"""
    <div class="w-screen my-4 flex text-white grid text-center text-lg font-mukta"><strong>Almost there...</strong></div>
    <div class="w-screen my-2 px-10 flex text-white grid text-center text-l font-mukta">What is your preference when it comes to background?</div>
     <div class="w-screen my-2 mb-10 px-10 flex text-white grid text-center text-l font-mukta">Whatever helps your mind quiet down is a good choice.</div>

       <div class="flex w-screen justify-center items-center ">
       <div class="grid gap-6 grid-rows-3 lg:grid-cols-3">
         <.option_card id="silence" title="No background" link={next_link} option="silence" >
         No music, no ambient track. Zip, nada.
         </.option_card>
         <.option_card id="music" title="Music" link={next_link} option="music" >
         Let ambient music take you places
         </.option_card>
         <.option_card id="ambient" title="Nature FX" link={next_link} option="ambient" >
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

  def deliver_practice(assigns) do
    fileurl = ""

    ~H"""
    <div class="w-screen grid">
    <div class="w-screen my-4 flex text-white grid text-center text-lg font-mukta"><strong>Your practice is about to begin!</strong> </div>

    <div class="place-self-center lg:w-4/12 my-4 px-10 flex text-white grid text-center text-l font-mukta"><%= message_to_user(@choice1, @duration, @background) %></div>
    <div class="place-self-center lg:w-4/12 my-4 px-10 flex text-white grid text-center text-l font-mukta">Dispense with any distractions and press play. May you benefit from this practice.</div>

    <div class="border-4 p-4 w-42 bg-slate-400 place-self-center">
     <.meditation_player choices={files_to_play(@choice1, @duration, @background)}></.meditation_player>
    </div>
    <br>
    <div class="place-self-center lg:w-4/12 my-4 pb-4 px-10 flex text-white grid text-center text-l font-mukta">Please consider subscribing to our newsletter below to stay up to date with new developments.</div>
     <.my_form changeset={assigns.changeset}>
     </.my_form>
    </div>
    """
  end

  defp files_to_play(type, duration, background) do

    narration_file = case {type, duration} do
      {"nidra", "short"} -> "/audio/nidra_short.mp3"
      {"nidra", "medium"} -> "/audio/nidra_medium.mp3"
      {"nidra", "long"} -> "/audio/nidra_long.mp3"
      {"antar", "short"} -> "/audio/antar_short.mp3"
      {"antar", "medium"} -> "/audio/antar_medium.mp3"
      {"antar", "long"} -> "/audio/antar_long.mp3"
      {"scan", "short"} -> "/audio/scan_short.mp3"
      {"scan", "medium"} -> "/audio/scan_medium.mp3"
      {"scan", "long"} -> "/audio/scan_long.mp3"
    end

    background_file = case {background, duration} do
      {"silence", _} -> nil
      {"music", "short"} -> "/audio/music_short.mp3"
      {"music", "medium"} -> "/audio/music_medium.mp3"
      {"music", "long"} -> "/audio/music_long.mp3"
      {"ambient", "short"} -> "/audio/ambient_short.mp3"
      {"ambient", "medium"} -> "/audio/ambient_medium.mp3"
      {"ambient", "long"} -> "/audio/ambient_long.mp3"
    end

    %{narration: narration_file, background: background_file}

  end

  def my_form(assigns) do
    ~H"""
    <.form class="text-white text-center text-xl font-mukta" let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <div class=""><%= label f, :name %></div>
    <%= text_input f, :name, class: "py-2 mb-4 text-black" %>
    <div class="text-black"><%= error_tag f, :name %></div>
    <div><%= label f, :email %></div>
    <%= email_input f, :email, class: "py-2 mb-4 text-black" %>
    <div class="text-black"><%= error_tag f, :email %></div>
    <%= submit "Submit", class: "w-40 font-mukta text-white bg-gradient-to-r from-gray-500 via-gray-600 to-gray-700 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-gray-300 dark:focus:ring-gray-800 shadow-lg shadow-gray-500/50 dark:shadow-lg dark:shadow-gray-800/80 font-medium rounded-lg text-sm px-5 py-2.5 text-center mb-2" %>
    </.form>
    """
  end

  def meditation_player(assigns) do

    IO.inspect(assigns, label: "MEDPLAYER")
    ~H"""
    <audio id="background" class="hidden" controls>
    <source src={@choices[:background]}  type="audio/mpeg">
    Your browser does not support the audio element.
    </audio>
    <audio id="narration" class="hidden" controls>
    <source src={@choices[:narration]} type="audio/mpeg">
    Your browser does not support the audio element.
    </audio>
    <div class="">
    <button class="font-mukta text-white bg-gradient-to-r from-gray-500 via-gray-600 to-gray-700 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-gray-300 dark:focus:ring-gray-800 shadow-lg shadow-gray-500/50 dark:shadow-lg dark:shadow-gray-800/80 font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-2 mb-2" onclick="document.getElementById('background').play(); document.getElementById('narration').play()">Play</button>
    <button class="font-mukta text-white bg-gradient-to-r from-gray-500 via-gray-600 to-gray-700 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-gray-300 dark:focus:ring-gray-800 shadow-lg shadow-gray-500/50 dark:shadow-lg dark:shadow-gray-800/80 font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-2 mb-2" onclick="document.getElementById('background').pause(); document.getElementById('narration').pause()">Pause</button>
    </div>
    """
  end

  def handle_params(params, uri, socket) do
    new_socket =
      assign(socket,
        choice1: params["choice1"],
        duration: params["duration"],
        background: params["background"],
        uri: uri
      )

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
      <div class="w-80 border-4 border-neutral-200 h-48 rounded-md bg-slate-300  divide-y">
        <h3 class="hover:bg-slate-400 pt-4 pb-2 text-xl text-stone-800 text-center font-heebo">
        <%= live_patch @title, [to: assigns.link<>assigns.option, id: assigns[:id]] %></h3>
        <p class="p-8 text-stone-800 text-center font-mukta"><%= render_slot(@inner_block) %></p>
      </div>
    """
  end

  def handle_event("save", %{"members" => subscriber_params}, socket) do
    case Mailing.create_members(subscriber_params) do
      {:ok, _member} ->
        new_socket = assign(socket, changeset: Mailing.change_members(%Members{}))
        IO.inspect(subscriber_params, label: "NEW SUBSCRIBER")

        Newsletter.Emails.welcome(%{
          email: subscriber_params["email"],
          name: subscriber_params["name"]
        })
        |> Nsdr.Mailer.deliver()
        |> IO.inspect(label: "EMAIL SENT")

        {:noreply, new_socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("validate", %{"members" => members_params}, socket) do
    changeset =
      %Members{}
      |> Mailing.change_members(members_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end
end

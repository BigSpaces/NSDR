defmodule NsdrWeb.StepController do
  use NsdrWeb, :controller

  def step1(conn, _params) do
    IO.puts("HELLO THERE")
    render(conn, "index.html")
  end

  def step2(conn, incoming_params) do
    render(conn, "step2.html", incoming_params: incoming_params)
  end

  def step3(conn, incoming_params) do

    render(conn, "step3.html", incoming_params: incoming_params)
  end

  def play(conn, incoming_params) do
    render(conn, "play.html", incoming_params: incoming_params)
  end

end

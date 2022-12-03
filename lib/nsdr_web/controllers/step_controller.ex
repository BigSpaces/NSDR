defmodule NsdrWeb.StepController do
  use NsdrWeb, :controller

  def step1(conn, _params) do
    render(conn, "index.html")
  end

  def step2(conn, _params) do
    render(conn, "step2.html")
  end
end

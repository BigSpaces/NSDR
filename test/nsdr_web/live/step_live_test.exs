defmodule NsdrWeb.StepLiveTest do
  use NsdrWeb.ConnCase
  doctest NsdrWeb.StepLive
  alias NsdrWeb.StepLive
  import Phoenix.LiveViewTest

  test "disconnected mount", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome!"
  end

  test "clicking choices", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    view |> element("#nidra") |> render_click() |> IO.inspect(label: "RENDER CLICK")
    assert_patch(view, "/step2?choice1=nidra")
    view |> element("#short") |> render_click()
    assert_patch(view, "/step3?choice1=nidra&duration=short")
    view |> element("#silence") |> render_click()
    assert_patch(view, "/play?choice1=nidra&duration=short&background=silence")
  end

  test "step 1 has all choices", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    assert view |> element("#nidra") |> render() =~ "Nidra / NSDR"
    assert view |> element("#antar") |> render() =~ "Inner Silence"
    assert view |> element("#scan") |> render() =~ "Body Scan"
  end
end

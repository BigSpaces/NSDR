defmodule NsdrWeb.MembersLiveTest do
  use NsdrWeb.ConnCase

  import Phoenix.LiveViewTest
  import Nsdr.MailingFixtures

  @create_attrs %{email: "some email", name: "some name"}
  @update_attrs %{email: "some updated email", name: "some updated name"}
  @invalid_attrs %{email: nil, name: nil}

  defp create_members(_) do
    members = members_fixture()
    %{members: members}
  end

  describe "Index" do
    setup [:create_members]

    test "lists all member", %{conn: conn, members: members} do
      {:ok, _index_live, html} = live(conn, Routes.members_index_path(conn, :index))

      assert html =~ "Listing Member"
      assert html =~ members.email
    end

    test "saves new members", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.members_index_path(conn, :index))

      assert index_live |> element("a", "New Members") |> render_click() =~
               "New Members"

      assert_patch(index_live, Routes.members_index_path(conn, :new))

      assert index_live
             |> form("#members-form", members: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#members-form", members: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.members_index_path(conn, :index))

      assert html =~ "Members created successfully"
      assert html =~ "some email"
    end

    test "updates members in listing", %{conn: conn, members: members} do
      {:ok, index_live, _html} = live(conn, Routes.members_index_path(conn, :index))

      assert index_live |> element("#members-#{members.id} a", "Edit") |> render_click() =~
               "Edit Members"

      assert_patch(index_live, Routes.members_index_path(conn, :edit, members))

      assert index_live
             |> form("#members-form", members: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#members-form", members: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.members_index_path(conn, :index))

      assert html =~ "Members updated successfully"
      assert html =~ "some updated email"
    end

    test "deletes members in listing", %{conn: conn, members: members} do
      {:ok, index_live, _html} = live(conn, Routes.members_index_path(conn, :index))

      assert index_live |> element("#members-#{members.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#members-#{members.id}")
    end
  end

  describe "Show" do
    setup [:create_members]

    test "displays members", %{conn: conn, members: members} do
      {:ok, _show_live, html} = live(conn, Routes.members_show_path(conn, :show, members))

      assert html =~ "Show Members"
      assert html =~ members.email
    end

    test "updates members within modal", %{conn: conn, members: members} do
      {:ok, show_live, _html} = live(conn, Routes.members_show_path(conn, :show, members))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Members"

      assert_patch(show_live, Routes.members_show_path(conn, :edit, members))

      assert show_live
             |> form("#members-form", members: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#members-form", members: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.members_show_path(conn, :show, members))

      assert html =~ "Members updated successfully"
      assert html =~ "some updated email"
    end
  end
end

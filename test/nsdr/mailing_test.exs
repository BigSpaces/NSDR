defmodule Nsdr.MailingTest do
  use Nsdr.DataCase

  alias Nsdr.Mailing

  describe "member" do
    alias Nsdr.Mailing.Members

    import Nsdr.MailingFixtures

    @invalid_attrs %{email: nil, name: nil}

    test "list_member/0 returns all member" do
      members = members_fixture()
      assert Mailing.list_member() == [members]
    end

    test "get_members!/1 returns the members with given id" do
      members = members_fixture()
      assert Mailing.get_members!(members.id) == members
    end

    test "create_members/1 with valid data creates a members" do
      valid_attrs = %{email: "some email", name: "some name"}

      assert {:ok, %Members{} = members} = Mailing.create_members(valid_attrs)
      assert members.email == "some email"
      assert members.name == "some name"
    end

    test "create_members/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mailing.create_members(@invalid_attrs)
    end

    test "update_members/2 with valid data updates the members" do
      members = members_fixture()
      update_attrs = %{email: "some updated email", name: "some updated name"}

      assert {:ok, %Members{} = members} = Mailing.update_members(members, update_attrs)
      assert members.email == "some updated email"
      assert members.name == "some updated name"
    end

    test "update_members/2 with invalid data returns error changeset" do
      members = members_fixture()
      assert {:error, %Ecto.Changeset{}} = Mailing.update_members(members, @invalid_attrs)
      assert members == Mailing.get_members!(members.id)
    end

    test "delete_members/1 deletes the members" do
      members = members_fixture()
      assert {:ok, %Members{}} = Mailing.delete_members(members)
      assert_raise Ecto.NoResultsError, fn -> Mailing.get_members!(members.id) end
    end

    test "change_members/1 returns a members changeset" do
      members = members_fixture()
      assert %Ecto.Changeset{} = Mailing.change_members(members)
    end
  end
end

defmodule MbankingWeb.UserControllerTest do
  use MbankingWeb.ConnCase
  alias Mbanking.Accounts.Entities.User
  alias Mbanking.Accounts.Repositories.AccountRepository
  alias Mbanking.UserFixture
  require Logger

  def fixture(:user) do
    {:ok, user} = AccountRepository.create_user(UserFixture.valid_user_pending_api())
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.api_user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_user_path(conn, :create), user: UserFixture.valid_user())
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_user_path(conn, :show, id))

      assert %{
               "id" => id,
               "birth_date" => "2010-04-17",
               "city" => "some city",
               "country" => "some country",
               "cpf" => "dlKn8Teh4Mr0GeZR%2FQsBXw%3D%3D",
               "email" => "tAMWaeTm59Tw9hx4H%2F%2BKQw%3D%3D",
               "gender" => "male",
               "name" => "D9i1UQ%2BZjQEgoz9rUXI0fg%3D%3D",
               "state" => "some state"
             } = json_response(conn, 200)["data"]
    end

    test "try register user with already registered email returns error", %{conn: conn} do
      UserFixture.create_user()

      conn = post(conn, Routes.api_user_path(conn, :create), user:
      %{
        birth_date: ~D[2010-04-17],
        city: "some city",
        country: "some country",
        cpf: "05679935074",
        email: "email@email",
        gender: "teste",
        name: "some name",
        state: "some state",
        status: "completed"
      })
      assert json_response(conn, 422)["errors"] != %{}

    end

    test "insert user with referral code", %{conn: conn} do
      user_referral = UserFixture.create_referral_user()

      user_params = %{
        birth_date: ~D[2010-04-17],
        city: "some city",
        country: "some country",
        cpf: "11310402019",
        email: "email@email",
        gender: "male",
        name: "some name",
        state: "some state",
        referral_code: user_referral.referral_code
      }

      conn = post(conn, Routes.api_user_path(conn, :create), user: user_params)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_user_path(conn, :show, id))

      assert %{
               "id" => id,
               "birth_date" => "2010-04-17",
               "city" => "some city",
               "country" => "some country",
               "cpf" => "dlKn8Teh4Mr0GeZR%2FQsBXw%3D%3D",
               "email" => "tAMWaeTm59Tw9hx4H%2F%2BKQw%3D%3D",
               "gender" => "male",
               "name" => "D9i1UQ%2BZjQEgoz9rUXI0fg%3D%3D",
               "state" => "some state"
             } = json_response(conn, 200)["data"]
    end

    test "create new pending account user", %{conn: conn} do
      conn =
        post(conn, Routes.api_user_path(conn, :create), user: UserFixture.valid_user_pending_api())

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_user_path(conn, :show, id))

      assert %{
               "id" => id,
               "status" => "pending"
             } = json_response(conn, 200)["data"]
    end

    test "insert user with accounts already registered with account status pending", %{conn: conn} do
      conn =
        post(conn, Routes.api_user_path(conn, :create), user: UserFixture.valid_user_pending_api())

      conn =
        post(conn, Routes.api_user_path(conn, :create),
          user: UserFixture.valid_user_complete_api()
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_user_path(conn, :show, id))

      assert %{
               "id" => id,
               "status" => "completed"
             } = json_response(conn, 200)["data"]
    end

    test "insert user with accounts already registered with account status completed should return error",
         %{conn: conn} do
      conn = post(conn, Routes.api_user_path(conn, :create), user: UserFixture.valid_user())

      conn = post(conn, Routes.api_user_path(conn, :create), user: UserFixture.valid_user())
      assert json_response(conn, 400)["error"] != %{}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_user_path(conn, :create), user: UserFixture.invalid_user())
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "update user should return data", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, "/api/users/#{user.id}", user: UserFixture.valid_user_complete_api())
      assert %{"id" => ^id} = json_response(conn, 201)["data"]
    end

    test "update user with referral code should return data", %{
      conn: conn,
      user: %User{id: id} = user
    } do
      user_referral = UserFixture.create_referral_user()

      user_params =
        UserFixture.valid_user_complete_api() |> Map.put_new(:referral_code, user_referral.referral_code)

      conn = put(conn, "/api/users/#{user.id}", user: user_params)
      assert %{"id" => ^id} = json_response(conn, 201)["data"]

    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end

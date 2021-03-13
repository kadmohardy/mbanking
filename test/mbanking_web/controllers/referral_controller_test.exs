defmodule MbankingWeb.ReferralControllerTest do
  @moduledoc false
  use MbankingWeb.ConnCase

  alias Mbanking.UserFixture

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all referrals", %{conn: conn} do
      user_referral = UserFixture.create_referral_user()
      user_params = %{
        birth_date: ~D[2010-04-17],
        city: "some2 city",
        country: "some2 country",
        cpf: "31724325647",
        email: "email2@email",
        gender: "male",
        name: "some name",
        state: "some state",
        status: "completed",
        referral_code: user_referral.referral_code
      }
      conn = post(conn, Routes.api_user_path(conn, :create), user: user_params)

      conn = get(conn, "/api/referrals/#{user_referral.id}")

      assert json_response(conn, 200)["data"] |> Enum.count() == 1
    end

  end
end

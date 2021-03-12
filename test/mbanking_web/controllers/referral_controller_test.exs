defmodule MbankingWeb.ReferralControllerTest do
  use MbankingWeb.ConnCase

  alias Mbanking.Referrals
  alias Mbanking.Referrals.Referral

  @create_attrs %{
    referral_code: "some referral_code"
  }
  @update_attrs %{
    referral_code: "some updated referral_code"
  }
  @invalid_attrs %{referral_code: nil}

  def fixture(:referral) do
    {:ok, referral} = Referrals.create_referral(@create_attrs)
    referral
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all referrals", %{conn: conn} do
      conn = get(conn, Routes.referral_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create referral" do
    test "renders referral when data is valid", %{conn: conn} do
      conn = post(conn, Routes.referral_path(conn, :create), referral: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.referral_path(conn, :show, id))

      assert %{
               "id" => id,
               "referral_code" => "some referral_code"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.referral_path(conn, :create), referral: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update referral" do
    setup [:create_referral]

    test "renders referral when data is valid", %{
      conn: conn,
      referral: %Referral{id: id} = referral
    } do
      conn = put(conn, Routes.referral_path(conn, :update, referral), referral: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.referral_path(conn, :show, id))

      assert %{
               "id" => id,
               "referral_code" => "some updated referral_code"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, referral: referral} do
      conn = put(conn, Routes.referral_path(conn, :update, referral), referral: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete referral" do
    setup [:create_referral]

    test "deletes chosen referral", %{conn: conn, referral: referral} do
      conn = delete(conn, Routes.referral_path(conn, :delete, referral))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.referral_path(conn, :show, referral))
      end
    end
  end

  defp create_referral(_) do
    referral = fixture(:referral)
    %{referral: referral}
  end
end

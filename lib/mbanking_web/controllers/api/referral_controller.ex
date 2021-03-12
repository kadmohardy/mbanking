defmodule MbankingWeb.Api.ReferralController do
  use MbankingWeb, :controller
  alias Mbanking.Referrals.Services.ListReferrals
  action_fallback MbankingWeb.FallbackController

  def index(conn, %{"user_id" => user_id}) do
    with {:ok, referrals} <- ListReferrals.execute(user_id) do
      conn
      |> render("index.json", referrals: referrals)
    end
  end
end

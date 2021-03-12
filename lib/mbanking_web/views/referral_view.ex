defmodule MbankingWeb.Api.ReferralView do
  use MbankingWeb, :view
  require Logger

  def render("index.json", %{referrals: referrals}) do
    %{data: render_many(referrals, __MODULE__, "referral.json")}
  end

  def render("show.json", %{referral: referral}) do
    %{data: render_one(referral, __MODULE__, "referral.json")}
  end

  def render("referral.json", %{referral: referral}) do
    %{id: referral.user.id, name: Cipher.decrypt(referral.user.name)}
  end
end

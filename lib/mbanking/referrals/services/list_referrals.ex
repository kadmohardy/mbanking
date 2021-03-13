defmodule Mbanking.Referrals.Services.ListReferrals do
  @moduledoc false
  alias Mbanking.Accounts.Repositories.AccountRepository
  alias Mbanking.Referrals.Repositories.ReferralRepository

  def execute(user_id) do
    user = AccountRepository.get_user(user_id)

    if user && user.status == "completed" do
      {:ok, ReferralRepository.list_referrals(user.id)}
    else
      {:error, "Essa funcionalidade é permitida apenas para contas com status completo."}
    end
  end
end

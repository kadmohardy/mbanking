defmodule Mbanking.ReferralsTest do
  @moduledoc false

  use Mbanking.DataCase

  alias Mbanking.Accounts.Repositories.AccountRepository
  alias Mbanking.Referrals.Repositories.ReferralRepository

  alias Mbanking.UserFixture

  describe "referrals" do
    test "list_referrals/0 returns all referrals" do
      user_referral = UserFixture.create_referral_user()

      {:ok, _user} =
        UserFixture.valid_user()
        |> AccountRepository.create_user_with_referral(user_referral)

      assert ReferralRepository.list_referrals(user_referral.id) |> Enum.count() == 1
    end

    test "get_referral_by_user/1 returns a user referral" do
      user_referral = UserFixture.create_referral_user()

      {:ok, user} =
        UserFixture.valid_user()
        |> AccountRepository.create_user_with_referral(user_referral)

      referral = ReferralRepository.get_referral_by_user(user.id)
      assert referral.user_id == user.id
      assert referral.user_referral_id == user_referral.id
    end
  end
end

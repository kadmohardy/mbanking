defmodule Mbanking.Referrals.Repositories.ReferralRepository do
  @moduledoc """
  The Referrals context.
  """

  import Ecto.Query, warn: false
  alias Mbanking.Repo

  alias Mbanking.Referrals.Entities.Referral

  @doc """
  Returns the list of referrals.

  ## Examples

      iex> list_referrals()
      [%Referral{}, ...]

  """
  def list_referrals(user_id) do
    Repo.all(
      from r in Referral,
        where: r.user_referral_id == ^user_id,
        preload: [:user]
    )
  end

  @doc """
  Gets a single referral.

  Raises `Ecto.NoResultsError` if the Referral does not exist.

  ## Examples

      iex> get_referral!(123)
      %Referral{}

      iex> get_referral!(456)
      ** (Ecto.NoResultsError)

  """
  def get_referral_by_user(user_id), do: Repo.get_by(Referral, user_id: user_id)

end

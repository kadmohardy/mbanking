defmodule Mbanking.Utils.Validations do
  @moduledoc false

  def validate_cpf_is_valid(cpf) do
    cpf_value = %Cpf{number: cpf}
    Brcpfcnpj.cpf_valid?(cpf_value)
  end
end

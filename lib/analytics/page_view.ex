defmodule Analytics.PageView do
  defstruct [
    user_id: nil,
    session_id: nil,
    starts_at: nil,
    ends_at: nil,
    time: 0,
    path: nil
  ]

  def new(user_id, session_id, path) do
    %__MODULE__{
      user_id: user_id,
      session_id: session_id,
      starts_at: DateTime.utc_now(),
      ends_at: DateTime.utc_now(),
      time: 0,
      path: path
    }
  end

  def registry_key(%__MODULE__{user_id: user_id, session_id: session_id}) do
    Integer.to_string(user_id) <> ":" <> session_id
  end
end

defmodule UpcomingShowFinder.Finder do
  use GenServer

  def start_link, do: GenServer.start_link(__MODULE__, %{})

  def init(state) do
    schedule_find
    {:ok, state}
  end

  def handle_info(:find, state) do
    IO.puts(":find was started")
    schedule_find
    {:noreply, state}
  end

  defp schedule_find, do: Process.send_after(self(), :find, 5 * 1000)
end

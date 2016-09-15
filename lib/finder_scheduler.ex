defmodule UpcomingShowFinder.FinderScheduler do
  use GenServer
  alias UpcomingShowFinder.Finder

  def start_link, do: GenServer.start_link(__MODULE__, %{})

  def init(state) do
    schedule_find
    {:ok, state}
  end

  def handle_info(:find, state) do
    Finder.prepare_for_scraping
    schedule_find
    {:noreply, state}
  end

  defp schedule_find, do: Process.send_after(self(), :find, 5 * 1000)
end

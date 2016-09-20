defmodule UpcomingShowFinder.RoyaleParser do
  def block_element_selector, do: "#tribe-events-content .tribe-events-loop .type-tribe_events"

  def headliner_selector, do: ".tribe-events-event-details .tribe-events-list-event-title a"

  def openers_selector, do: ".tribe-events-event-details .tribe-events-meta-group .tribe-meta-value"

  def price_selector, do: ".tribe-events-event-details .tribe-events-meta-group .tribe-meta-value"

  def date_selector, do: ".tribe-events-event-details .tribe-events-event-meta .tribe-event-date-start"

  def parse_headliner_elements(headliner_elements) do
    headliner_elements
    |> Floki.text
    |> String.trim
  end

  def parse_openers_elements(openers_elements) do
    first_element_text  = List.first(openers_elements)
                          |> Floki.text
                          |> String.trim

    is_dollar_amount = Regex.match?(~r/\$\d/, first_element_text)

    get_openers(first_element_text, is_dollar_amount)
  end

  defp get_openers(_, true) do
    nil
  end

  defp get_openers(first_element_text, false) do
    first_element_text
  end

  def parse_price_elements(price_elements) do
    Enum.map(price_elements, &check_price_element(&1))
    |> Enum.reject(&(nil == &1))
    |> List.last
  end

  defp check_price_element(element) do
    element_text = Floki.text(element) |> String.trim
    is_dollar_amount = Regex.match?(~r/\$\d/, element_text)

    get_price(element_text, is_dollar_amount)
  end

  defp get_price(_, false) do
    nil
  end

  defp get_price(element_text, true) do
    element_text
  end

  def parse_date_elements(date_elements) do
    datetime = date_elements
               |> Floki.text
               |> String.trim
               # |> String.trim <> " 2016"
               # |> Timex.parse!("%A, %B %e @ %k:%M %P %Y", :strftime)
               # |> Timex.format!("%FT%TZ", :strftime)
               # |> Ecto.DateTime.cast!
  end
end

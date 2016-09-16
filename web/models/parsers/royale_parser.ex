defmodule UpcomingShowFinder.RoyaleParser do
  def block_element_selector, do: "#tribe-events-content .tribe-events-loop .type-tribe_events"

  def headliner_selector, do: ".tribe-events-event-details .tribe-events-list-event-title a"

  def openers_selector, do: ".tribe-events-event-details .tribe-events-meta-group .tribe-meta-value"

  def parse_openers_elements(openers_elements) do
    first_element  = List.first(openers_elements)
                     |> Floki.text
                     |> String.trim
    is_dollar_amount = Regex.match?(~r/\$\d/, first_element)

    get_openers(first_element, is_dollar_amount)
  end

  def get_openers(first_element, true) do
    ""
  end

  def get_openers(first_element, false) do
    first_element
  end
end

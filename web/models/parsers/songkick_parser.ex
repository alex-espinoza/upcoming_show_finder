defmodule UpcomingShowFinder.SongkickParser do
  require IEx

  @hostname "https://www.songkick.com"

  def block_element_selector, do: "#event-listings ul.event-listings li[title]"
  def headliner_selector, do: "p.artists a span strong"
  def openers_selector, do: "p.artists a span"
  def price_selector, do: ""
  def date_selector, do: "time"
  def information_url_selector, do: "a.thumb"
  def ticket_url_selector, do: "a.thumb"

  def parse_headliner_elements(headliner_element) do
    headliner_element
    |> Floki.text
    |> String.trim
  end

  def parse_openers_elements(openers_element) do
    openers = openers_element
    |> Floki.text
    |> String.trim
    |> String.split("\n")
    |> Enum.at(1)

    sanitize_openers_string(openers)
  end

  def sanitize_openers_string(openers) when is_bitstring(openers) do
    openers |> String.trim
  end

  def sanitize_openers_string(nil) do
    nil
  end

  def parse_price_elements(price_element) do
  end

  def parse_date_elements(date_element) do
    date_element
    |> Floki.attribute("datetime")
    |> List.first
    |> String.split("T")
    |> List.first
    |> Timex.parse!("%Y-%m-%d", :strftime)
    |> Timex.format!("%FT%TZ", :strftime)
  end

  def parse_information_url_elements(information_url_element) do
    href = information_url_element
    |> Floki.attribute("href")
    |> List.first

    @hostname <> href
  end

  def parse_ticket_url_elements(ticket_url_element) do
    href = ticket_url_element
    |> Floki.attribute("href")
    |> List.first

    @hostname <> href
  end
end

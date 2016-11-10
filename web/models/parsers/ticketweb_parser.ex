defmodule UpcomingShowFinder.TicketWebParser do
  require IEx

  def block_element_selector, do: ".content-container .section-body .event-list li"
  def headliner_selector, do: ".media-body .vertical-center .event-name a"
  def openers_selector, do: ""
  def price_selector, do: ""
  def date_selector, do: ".media-body .vertical-center .event-date"
  def information_url_selector, do: ""
  def ticket_url_selector, do: ".media-action .event-status a"

  def parse_headliner_elements(headliner_elements) do
    headliner_elements
    |> Enum.at(0)
    |> Floki.text
    |> String.trim
  end

  def parse_openers_elements(openers_elements) do
  end

  def parse_price_elements(price_elements) do
  end

  def parse_date_elements(date_elements) do
    date_string = date_elements
    |> Floki.text
    |> String.trim
    |> String.split(" ")
    |> Enum.take(3)
    |> Enum.join(" ")

    year = determine_if_show_is_next_year(date_string)

    date_string
    |> Kernel.<>(year)
    |> Timex.parse!("%a %b %_d %Y", :strftime)
    |> Timex.format!("%FT%TZ", :strftime)
  end

  def parse_information_url_elements(information_url_elements) do
  end

  def parse_ticket_url_elements(ticket_url_elements) do
    parsed_url = ticket_url_elements
    |> Floki.attribute("data-ng-href")
    |> Enum.at(0)
    |> String.split("{{")
    |> Enum.at(0)
  end

  def determine_if_show_is_next_year(date_string) do
    current_time = Ecto.DateTime.utc
    {_, current_year_and_month} = Timex.format(current_time, "%-m %Y", :strftime)
    [current_month, current_year] = String.split(current_year_and_month, " ")
    show_month = Timex.parse!(date_string, "%a %b %_d", :strftime) |> Timex.format!("%-m", :strftime)

    current_month = String.to_integer(current_month)
    current_year = String.to_integer(current_year)
    show_month = String.to_integer(show_month)

    get_year(show_month, current_month, current_year)
  end

  def get_year(show_month, current_month, current_year) when show_month < current_month do
    current_year = current_year + 1
    " " <> Integer.to_string(current_year)
  end

  def get_year(show_month, current_month, current_year) when show_month >= current_month do
    " " <> Integer.to_string(current_year)
  end
end

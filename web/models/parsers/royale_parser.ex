defmodule UpcomingShowFinder.BoweryBostonParser do
  @hostname "http://www.boweryboston.com"

  def block_element_selector, do: "#content .list-view .list-view-item"
  def headliner_selector, do: ".list-view-details .headliners a"
  def openers_selector, do: ".list-view-details .supports a"
  def price_selector, do: ".ticket-price .price-range"
  def date_selector, do: ".list-view-details .dates"
  def information_url_selector, do: ".list-view-details .headliners a"
  def ticket_url_selector, do: ".ticket-price h3"

  def parse_headliner_elements(headliner_elements) do
    headliner_elements
    |> Floki.text
    |> String.trim
  end

  def parse_openers_elements(openers_elements) do
    openers_elements
    |> Floki.text
    |> String.trim
  end

  def parse_price_elements(price_elements) do
    price_elements
    |> Floki.text
    |> String.trim
  end

  def parse_date_elements(date_elements) do
    date_string = date_elements
    |> Floki.text
    |> String.trim
    |> String.split(" - ")
    |> Enum.at(0)

    year = determine_if_show_is_next_year(date_string)

    date_string
    |> Kernel.<>(year)
    |> Timex.parse!("%a %_m/%d %Y", :strftime)
    |> Timex.format!("%FT%TZ", :strftime)
  end

  def parse_information_url_elements(information_url_elements) do
    href = information_url_elements
    |> Floki.attribute("href")
    |> Enum.at(0)

    @hostname <> href
  end

  def parse_ticket_url_elements(ticket_url_elements) do
    parsed_url = ticket_url_elements
    |> Floki.find("a")
    |> Floki.attribute("href")
    |> Enum.at(0)
  end

  def determine_if_show_is_next_year(date_string) do
    current_time = Ecto.DateTime.utc
    {_, current_year_and_month} = Timex.format(current_time, "%-m %Y", :strftime)
    [current_month, current_year] = String.split(current_year_and_month, " ")
    show_month = String.split(date_string, "/")
    |> Enum.at(0)
    |> String.split(" ")
    |> Enum.at(1)

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

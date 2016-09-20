defmodule UpcomingShowFinder.Finder do
  require Logger
  import Ecto
  import Ecto.Query
  alias UpcomingShowFinder.Repo
  alias UpcomingShowFinder.Source
  alias UpcomingShowFinder.Show

  def prepare_to_scrape do
    Logger.info("Finder is preparing to scrape for new shows")
    sources = Repo.all(Source)
    Enum.each(sources, &scrape(&1))
  end

  defp scrape(source) do
    parser_module = Module.concat([UpcomingShowFinder, "#{source.parser}Parser"])

    source
    |> make_http_request
    |> parse_response_body_for_block_elements(parser_module)
    |> parse_each_block_element(parser_module, source.id)
  end

  defp make_http_request(source) do
    HTTPoison.get!(source.url)
  end

  defp parse_response_body_for_block_elements(response, parser_module) do
    block_element_selector = apply(parser_module, :block_element_selector, [])
    Floki.find(response.body, block_element_selector)
  end

  defp parse_each_block_element(block_elements, parser_module, source_id) do
    Enum.each(block_elements, &create_show_from_data_in_element(&1, parser_module, source_id))
  end

  defp create_show_from_data_in_element(block_element, parser_module, source_id) do
    parse_show_data_from_element(block_element, parser_module, source_id)
    |> save_show
  end

  defp parse_show_data_from_element(block_element, parser_module, source_id) do
    headliner_selector = apply(parser_module, :headliner_selector, [])
    openers_selector = apply(parser_module, :openers_selector, [])
    price_selector = apply(parser_module, :price_selector, [])
    date_selector = apply(parser_module, :date_selector, [])

    headliner = Floki.find(block_element, headliner_selector)
                |> parse_headliner_elements(parser_module)

    openers = Floki.find(block_element, openers_selector)
              |> parse_openers_elements(parser_module)

    price = Floki.find(block_element, price_selector)
            |> parse_price_elements(parser_module)

    date = Floki.find(block_element, date_selector)
           |> parse_date_elements(parser_module)

    %{headliner: headliner, openers: openers, price: price, date: date, source_id: source_id}
  end

  defp save_show(show_data) do
    changeset = Show.changeset(%Show{}, show_data)
    IO.puts("---")
    IO.inspect(changeset)
    Repo.insert!(changeset)
  end

  defp parse_headliner_elements(headliner_elements, parser_module) do
    apply(parser_module, :parse_headliner_elements, [headliner_elements])
  end

  defp parse_openers_elements(openers_elements, parser_module) do
    apply(parser_module, :parse_openers_elements, [openers_elements])
  end

  defp parse_price_elements(price_elements, parser_module) do
    apply(parser_module, :parse_price_elements, [price_elements])
  end

  defp parse_date_elements(date_elements, parser_module) do
    apply(parser_module, :parse_date_elements, [date_elements])
  end
end

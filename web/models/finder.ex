defmodule UpcomingShowFinder.Finder do
  require Logger
  import Ecto
  import Ecto.Query
  alias UpcomingShowFinder.Repo
  alias UpcomingShowFinder.Source

  def prepare_to_scrape do
    Logger.info("Finder is preparing to scrape for new shows")
    sources = Repo.all(Source)
    Enum.each(sources, &scrape(&1))
  end

  def scrape(source) do
    parser_module = Module.concat([UpcomingShowFinder, "#{source.parser}Parser"])

    source
    |> make_http_request
    |> parse_response_body_for_block_elements(parser_module)
    |> parse_each_block_element(parser_module)
  end

  def make_http_request(source) do
    HTTPoison.get!(source.url)
  end

  def parse_response_body_for_block_elements(response, parser_module) do
    block_element_selector = apply(parser_module, :block_element_selector, [])
    Floki.find(response.body, block_element_selector)
  end

  def parse_each_block_element(block_elements, parser_module) do
    #IO.inspect(List.first(block_elements))
    Enum.each(block_elements, &create_show_from_data_in_element(&1, parser_module))
  end

  def create_show_from_data_in_element(block_element, parser_module) do
    headliner_selector = apply(parser_module, :headliner_selector, [])
    openers_selector = apply(parser_module, :openers_selector, [])
    # price_selector = apply(parser_module, :price_selector, [])
    # date_selector = apply(parser_module, :date_selector, [])

    headliner = Floki.find(block_element, headliner_selector)
                |> Floki.text
                |> String.trim

    openers = Floki.find(block_element, openers_selector)
              |> parse_openers_elements(parser_module)

    IO.puts("---")
    IO.puts(headliner)
    IO.inspect(openers)
  end

  def parse_openers_elements(openers_elements, parser_module) do
    apply(parser_module, :parse_openers_elements, [openers_elements])
  end
end


# defmodule Scraper do
#   def get_page_info do
#     response = HTTPoison.get!("http://httparrot.herokuapp.com/get")
#     {_, response} = JSON.decode(response.body)
#     response
#   end

#   # https://varvy.com/pagespeed/wicked-fast.html
#   def parse(url \\ "http://www.boweryboston.com/") do
#     response = HTTPoison.get!(url)
#     #Floki.find(response.body, "a")
#     Floki.find(response.body, ".list-view-item")
#   end
# end

require 'watir'
require 'watir-webdriver'

class Product
  attr_accessor :name, :price
end

module SortOptions
  Relevance = 0
  Featured = 1
  PriceLowToHigh = 2
  PriceHighToLow = 3
  AvgCustomerReview = 4
  NewestArrivals = 5
end

module Order
  Ascending = 0
  Descending = 1
end

SORTBY = ['Relevance',
                   'Featured',
                   'Price: Low to High',
                   'Price: High to Low',
                   'Avg. Customer Review',
                   'Newest Arrivals'] 

@product_array = []

Given (/^I am on the Amazon home page$/) do
  @browser = Watir::Browser.new
  @browser.goto "http://www.amazon.com"

  # Verification
  raise "Navigation to www.amazon.com failed." unless @browser.url.include?('www.amazon.com')
end

When(/^I search for "([^"]*)"$/) do |arg1|
  @browser.text_field(:name => "field-keywords").set arg1
  @browser.send_keys :return

  # Verification
  raise "Search for #{arg1} failed." unless @browser.div(:class=>'s-first-column').h2(:id=>'s-result-count').present?
end

When(/^I sort it by price from lowest to highest$/) do
  sort_option = SortOptions::PriceLowToHigh
  # Set the department in order to Sort
  @browser.select_list(:id => 'searchDropdownBox').option(:text => 'Cell Phones & Accessories').select
  @browser.select_list(:id => 'sort').option(:text => SORTBY[sort_option]).select
  # Wait for sorted page to refresh
  sleep(10)
  validate_price_sort(Order::Ascending)
end

Then(/^I return the name and price of the top (\d+) results$/) do |arg1|
  return_name_and_price(arg1.to_i)
  print_product_array
end

Then(/^I sort it by Avg\. Customer Review$/) do
  sort_option = SortOptions::AvgCustomerReview
  @browser.select_list(:id => 'sort').option(:text => SORTBY[sort_option]).select
  sleep(10)
  validate_review_sort()
end

def return_name_and_price(top_count)
  @product_array = []
  for i in 0..(top_count - 1)
    result_id = "result_#{i}"
    result_li = @browser.ul(:id => 's-results-list-atf').li(:id => result_id)
    
    product = Product.new
    product.name = result_li.h2.text
    product.price = result_li.span(:class=>'a-size-base').text
    @product_array << product
  end
end

def validate_price_sort(order)
  ordered_prices = []
  price_spans = @browser.spans(:class=> 'a-size-base')
  price_spans.each do |span|
    if span.text[0] == '$'
      ordered_prices << span.text
    end
  end
  
  if  order == Order::Ascending
    raise "Sort by Price failed." unless ordered_prices == ordered_prices.sort
  else
    raise "Sort by Price failed." unless ordered_prices == ordered_prices.reverse
  end
end

def validate_review_sort()
  
end

def print_product_array
  @product_array.each do |product|
    puts product.name
    puts product.price
    puts "-"*40
  end
end


require 'watir'
require 'watir-webdriver'

class Product
  attr_accessor :name, :price
end

@product_array = []

Given (/^I am on the Amazon home page$/) do
  @browser = Watir::Browser.new
  @browser.goto "http://www.amazon.com"
end

When(/^I search for "([^"]*)"$/) do |arg1|
  @browser.text_field(:name => "field-keywords").set arg1
  @browser.send_keys :return
end

When(/^I sort it by price from lowest to highest$/) do
  # Set the department in order to Sort
  @browser.select_list(:id => 'searchDropdownBox').option(:text => 'Cell Phones & Accessories').select
  @browser.select_list(:id => 'sort').option(:text => 'Price: Low to High').select
  # Wait for sorted page to refresh
  sleep(10)
end

Then(/^I return the name and price of the top (\d+) results$/) do |arg1|
  return_name_and_price(arg1.to_i)
  print_product_array
end

Then(/^I sort it by Avg\. Customer Review$/) do
  @browser.select_list(:id => 'sort').option(:text => 'Avg. Customer Review').select
  sleep(10)
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

def print_product_array
  @product_array.each do |product|
    puts product.name
    puts product.price
    puts "-"*40
  end
end


require_relative '../../lib/meli'
require 'meli'

class ModelsController < ApplicationController

  def index
    @models = Model.delete_all
  end

  def search
    @query = params[:search_field]
    @result = find_result_of @query
    create_search_items @result

    redirect_to models_result_path
  end

  def result
    @models = Model.all
  end

  def find_result_of(search_query)
    @meli = Meli.new
    path='/sites/MLA/search?q='
    path.concat(search_query.to_s)
    response = @meli.get(path)
    @response_map = JSON.parse response.body
  end

  def create_search_items a_hash
    a_hash["results"].each do |result|
      @item = Model.new
      @item.title = result["title"]
      @item.price = result["price"]
      @item.permalink = result["permalink"]
      @item.image = result["thumbnail"]
      @item.save
    end
  end
end
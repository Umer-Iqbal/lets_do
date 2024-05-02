class SearchResource::SearchResourceComponent < ViewComponent::Base
  def initialize(url: )
    @url = url
  end
end
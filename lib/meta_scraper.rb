class MetaScraper

  def initialize(url)
    @doc = Nokogiri::HTML(open(url))
    binding.pry
  end

  def call
    categories.each do |cat_doc|
      scrape_cat(cat_doc)
    end
  end

  private
    def categories
      @categories ||= @doc.search(".list-group-item").first.text
    end

    def scrape_cat(cat)
      #Scrape an individual category

    end
  def topics

  end

  def verse

  end
end

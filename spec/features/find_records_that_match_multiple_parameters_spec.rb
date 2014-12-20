require_relative "../../lib/api_service_searching"
require_relative "../fixtures/movie"

RSpec.describe "Finding data that match multiple parameters" do
  let(:data_set) { Movie.random_collection }
  let(:random_movie) { data_set.sample }

  let(:movies_with_country) { data_set.select { |d| d.country == random_movie.country } }
  let(:movies_with_year) { data_set.select { |d| d.year == random_movie.year } }
  let(:movies_with_rating) { data_set.select { |d| d.rating == random_movie.rating } }

  let(:results) { movies_with_country & movies_with_year & movies_with_rating }

  it "Returns records that match the requested value" do
    query_string = "country=#{random_movie.country},year=#{random_movie.year},rating=#{random_movie.rating || 'none'}"
    returned = ApiServiceSearching.where(
      data_set,
      query_string
    )

    expect(returned).to eq(results)
  end
end

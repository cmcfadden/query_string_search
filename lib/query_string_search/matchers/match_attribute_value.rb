class MatchAttributeValue < QueryStringSearch::AbstractMatcher
  def match?(target)
    match_with_contingency do
      Comparator.does(value).equal?(target_value(target))
    end
  end

  def self.build_me?(search_type, search_param)
    search_param &&
      search_type &&
      all_reserved_words.none? { |r| r.match(search_param) }
  end
end

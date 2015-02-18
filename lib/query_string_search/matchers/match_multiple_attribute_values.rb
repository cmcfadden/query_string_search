class MatchMultipleAttributeValues < QueryStringSearch::AbstractMatcher
  def match?(data)
    match_with_contingency do
      Comparator.does(desired_value).contain?(actual_value(data))
    end
  end

  def self.reserved_words
    [
      /^\w+\|\w+/
    ]
  end

  def desired_value=(x)
    super(x.split("|"))
  end

  def self.build_me?(_, search_param)
    reserved_words.any? { |r| r.match(search_param) }
  end
end

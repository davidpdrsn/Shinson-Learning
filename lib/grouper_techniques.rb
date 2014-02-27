class Grouper
  module Techniques
    def for_user_grouped_by(user, *groupings)
      Grouper.new(user.sorted_techniques).group_by(*groupings)
    end
  end
end

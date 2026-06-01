class Tagging < ApplicationRecord
  self.primary_key = [:post_id, :tag_id]
end

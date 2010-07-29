module Moxie
  class Forum < ActiveRecord::Base
    set_table_name "moxie_forums"

    has_many :topics
  end
end
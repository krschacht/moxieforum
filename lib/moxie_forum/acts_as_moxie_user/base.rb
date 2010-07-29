module MoxieForum
  module ActsAsMoxieUser

    module Base
      def self.included(klass)
        klass.class_eval do
          extend Config
        end
      end
      
      module Config
        def acts_as_moxie_user
          
          has_many :posts,  :foreign_key => 'author_id', 
                            :order => "created_at", 
                            :class_name => 'Moxie::Post'

          has_many :topics, :foreign_key => 'author_id', 
                            :order => "created_at", 
                            :class_name => 'Moxie::Topic'
          
          include MoxieForum::ActsAsMoxieUser::Base::InstanceMethods
        end        
        
      end
      
      module InstanceMethods
        def shout
          "hi"
        end
        
      end
      
      
    end
  end
end

::ActiveRecord::Base.send :include, MoxieForum::ActsAsMoxieUser::Base

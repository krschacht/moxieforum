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
        
        def profile_pic
          if self.id == nil
            "<span style='color: red;'><b>WARNING:</b> There is no current_user helper method within your application_controller.rb. Create this method such that it returns the instance of your logged in user object. The forum will not work correctly until you do this.</span>"
          else
            "[user.profile_pic]"
          end
        end
        
        def display_name
          "[user.display_name]"
        end
        
        def admin?
          false
        end
        
        def moderator?
          false
        end
        
      end # InstanceMethods      
    end
  end
end

::ActiveRecord::Base.send :include, MoxieForum::ActsAsMoxieUser::Base

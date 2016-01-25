class Star < ActiveRecord::Base
  belongs_to :starable, :polymorphic => true
end

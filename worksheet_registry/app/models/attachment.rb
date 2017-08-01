class Attachment < ActiveRecord::Base
  belongs_to :worksheet

  enum state: [:saved, :sent_for_processing, :processed]
end

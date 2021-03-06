class Worksheet < ActiveRecord::Base
  has_many :attachments

  enum decision: ['rejected', 'confirmed']

  def processing
    if self
      .attachments
      .where('attachments.state = ?', Attachment.states['processed'])
      .count ==
    self
      .attachments
      .count
      update!(processed: true)
    end
  end
end

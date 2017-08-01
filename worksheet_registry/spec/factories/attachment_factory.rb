FactoryGirl.define do
  factory :attachment, class: Attachment do
    filename '1_test.png'
    original_filename 'test.png'
    state 0
    worksheet { create('worksheet') }
  end
end

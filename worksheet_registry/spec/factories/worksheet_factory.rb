FactoryGirl.define do
  factory :worksheet, class: Worksheet do
  end

  trait :with_attachment do
    attachments { [create('attachment')] }
  end
end

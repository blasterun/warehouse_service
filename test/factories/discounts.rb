FactoryBot.define do
  factory :discount do
    attribute_matcher "objects_sum"
    amount_cents nil
    percentage 10.0
    operator_from nil
    operator_to nil
    quantity_from nil
    quantity_to nil
    use_persantage true

    factory :first_100_objects_5_persent_discount do
      attribute_matcher 'object_index'
      percentage 5
      use_persantage true
      operator_from '>='
      operator_to '<='
      quantity_from 0
      quantity_to 99
    end

    factory :second_100_objects_10_persent_discount do
      attribute_matcher 'object_index'
      percentage 10
      use_persantage true
      operator_from '>='
      operator_to '<='
      quantity_from 100
      quantity_to 199
    end

    factory :more_then_200_objects_15_persent_discount do
      attribute_matcher 'object_index'
      percentage 15
      use_persantage true
      operator_from '>='
      quantity_from 200
    end

  end
end

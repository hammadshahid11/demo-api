FactoryBot.define do
   factory :product do 
     name {Faker::Commerce.product_name}
     brand {Faker::Company.name}
     
     price {'1000'}
   
   end

end
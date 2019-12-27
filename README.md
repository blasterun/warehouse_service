# Warehouse service
You can prefill some data by `rake db:seed` to have something to work with

All business logic test cases according to requirements for specific cases with clients located at `./test/models`

All other tests in `./test/controllers`

# All basic endpoints located here:
> (for required params look at test)

> for all routes look at `rake routes` or routes.rb

get `/api/pricing_models`

get `/api/clients`

get `/api/discounts`

get `/api/clients/1/invoices`

get `/api/clients/1/discounts`

get `/api/clients/1/storage_objects`

# start test and code check

`rails test`

`rubocop`

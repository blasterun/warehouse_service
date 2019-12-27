# Warehouse service
You can prefill some data by `rake db:seed` to have same data into beginning


All buisness logic test cases according to requirements for specific cases with clients located at `./test/models`
All other test in `./test/controllers`

# All basic endpoints located here:
* (for required params look at test)
* for all routes look at rake routes or routes.rb

get `/api/pricing_models`
get `/api/clients`
get `/api/discounts`

get `/api/clients/1/invoices`
get `/api/clients/1/discounts`
get `/api/clients/1/storage_objects`

# start test and code check
`rails test`
`rubocop`

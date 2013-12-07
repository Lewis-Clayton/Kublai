Kublai - BTCChina API Wrapper
======
[![Gem Version](https://badge.fury.io/rb/kublai.png)](http://badge.fury.io/rb/kublai)

What
==========
Kublai is a lightweight API Wrapper for BTCChina written in Ruby.

The API is a lot more basic than MtGox's. Even so not all API methods are implemented currently in Kublai. However, you can add in more like this:

JSON Request
	{"method":"requestWithdrawal","params":["BTC",0.1],"id":1}

	def request_withdrawal(amount)
	  amount = cut_off(amount, 8)
	  post_data = initial_post_data
	  post_data['method']='requestWithdrawal'
	  post_data['params']=['BTC', amount]
	  request(post_data)
	end

Why
==========
Python, Java, PHP and C++ all have documented wrappers on the BTCChina site. Ruby is not well supported at this time this is an effort to chage that.

http://btcchina.org/api-trade-documentation-en

## Installation

Add this line to your application's Gemfile:

    gem 'kublai'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kublai

## Usage
```
access_key = "20c0bc14-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
secret_key = "66d218e5-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
kublai = Kublai::BTCChina.new(access_key, secret_key )

kublai.ticker
=> {"high"=>"5999.00", "low"=>"3821.13", "buy"=>"4978.96", "sell"=>"4990.00", "last"=>"4978.96", "vol"=>"149135.77100000"}

kublai.current_price
=> 4855.995

kublai.buy(4856, 6)
Error Code: -32003
Error Message: Insufficient CNY balance
=> false

kublai.buy(4856, 1.001339102)
=> true
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Who
==========
Lewis Clayton mail@l.ew.is

Licence
==========

MIT License
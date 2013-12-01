Kublai
======


What
==========

Kublai is a lightweight API Wrapper for BTCChina written in Ruby.

Why
==========

Python, Java, PHP and C++ all have documented wrappers on the BTCChina site. Ruby is not so well supported at this time. http://btcchina.org/api-trade-documentation-en


How
==========

	 require './kublai.rb'
	 access_key = "20c0bc14-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
	 secret_key = "66d218e5-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
	 kublai = Kublai.new(access_key, secret_key )
	 kublai.get_account_info


When
==========
This has not been tested thoughly so if you have any problems submit an issue.

This is still a work in progress. Pull requests are appreciated. 


Who
==========

Lewis Clayton mail@l.ew.is

Licence
==========

MIT License


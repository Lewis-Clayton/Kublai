require 'base64'
require "net/https"
require "uri"
require 'json'


class Kublai

  def initialize(access='', secret='')
    @access_key = access
    @secret_key = secret
  end
  
  def get_account_info
    post_data = initial_post_data
    post_data['method'] = 'getAccountInfo'
    post_data['params'] = []
    post_request(post_data)
  end

  def get_deposit_address
    get_account_info['profile']['btc_deposit_address']
  end

  def get_market_depth
    post_data = initial_post_data
    post_data['method'] = 'getMarketDepth2'
    post_data['params'] = []
    post_request(post_data)["market_depth"]
  end

  def buy(price, amount)
    price = price.to_f.round(5)
    amount = amount.to_f.round(8)
    post_data = initial_post_data
    post_data['method']='buyOrder'
    post_data['params']=[price, amount]
    post_request(post_data)
  end

  def sell(price, amount)
    price = price.to_f.round(5)
    amount = amount.to_f.round(8)
    post_data = initial_post_data
    post_data['method']='sellOrder'
    post_data['params']=[price, amount]
    post_request(post_data)
  end

  def cancel(order_id)
    post_data = initial_post_data
    post_data['method']='cancelOrder'
    post_data['params']=[order_id]
    post_request(post_data)
  end

  def current_price
    market_depth = get_market_depth
    ask = market_depth['ask'][0]['price']
    bid = market_depth['bid'][0]['price']
    (ask + bid) / 2
  end

  def ticker
    get_request("https://data.btcchina.com/data/ticker")
  end

  private

  def sign(params_string)
    signiture = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), @secret_key, params_string)
    'Basic ' + Base64.strict_encode64(@access_key + ':' + signiture)
  end

  def get_request(url)
    uri = URI.parse(url)
    request = Net::HTTP::Get.new(uri.request_uri)
    connection(uri, request)
  end

  def initial_post_data
    post_data = {}
    post_data['tonce']  = (Time.now.to_f * 1000000).to_i.to_s
    post_data
  end

  def post_request(post_data)
    uri = URI.parse("https://api.btcchina.com/api_trade_v1.php")
    payload = params_hash(post_data)
    signiture_string = sign(params_string(payload.clone))
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = payload.to_json
    request.initialize_http_header({"Accept-Encoding" => "identity", 'Json-Rpc-Tonce' => post_data['tonce'], 'Authorization' => signiture_string, 'Content-Type' => 'application/json', "User-Agent" => "Kublai"})
    connection(uri, request)
  end

  def connection(uri, request)
    http = Net::HTTP.new(uri.host, uri.port)
    # http.set_debug_output($stderr)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    http.read_timeout = 20
    http.open_timeout = 5
    response(http.request(request))
  end

  def response(response_data)
    if response_data.code == '200' && response_data.body['result']
      JSON.parse(response_data.body)['result']
    elsif response_data.code == '200' && response_data.body['ticker']
      JSON.parse(response_data.body)['ticker']
    elsif response_data.code == '200' && response_data.body['error']
      error = JSON.parse(response_data.body)
      warn("Error Code: #{error['error']['code']}")
      warn("Error Message: #{error['error']['message']}")
      false
    else
      raise
    end
  end

  def params_string(post_data)
    post_data['params'] = post_data['params'].join(',')
    params_hash(post_data).collect{|k, v| "#{k}=#{v}"} * '&'
  end

  def params_hash(post_data)
    post_data['accesskey'] = @access_key
    post_data['requestmethod'] = 'post'
    post_data['id'] = post_data['tonce'] unless post_data.keys.include?('id')
    fields=['tonce','accesskey','requestmethod','id','method','params']
    ordered_data = {}
    fields.each do |field|
      ordered_data[field] = post_data[field]
    end
    ordered_data
  end
end


if Rails.env == 'production'
  Geocoder.configure(
    # Geocoding options
    # timeout: 3,                 # geocoding service timeout (secs)
    lookup: :google,            # name of geocoding service (symbol)
    ip_lookup: :freegeoip,      # name of IP address geocoding service (symbol) NOTE: Geocoder's default IP address lookup has changed from FreeGeoIP.net to IPInfo.io. If you explicitly specify :freegeoip in your configuration you must choose a different IP lookup before FreeGeoIP is discontinued on July 1, 2018. If you do not explicitly specify :freegeoip you do not need to change anything.
    # language: :en,              # ISO-639 language code
    use_https: false,           # use HTTPS for lookup requests? (if supported)
    http_proxy: ENV['QUOTAGUARD_URL'],            # HTTP proxy server (user:pass@host:port)
    # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
    #api_key: '',               # API key for geocoding service
    cache: Redis.new,                 # cache object (must respond to #[], #[]=, and #del)
    # cache_prefix: 'geocoder:',  # prefix (string) to use for all cache keys

    # Exceptions that should not be rescued by default
    # (if you want to implement custom error handling);
    # supports SocketError and Timeout::Error
    # always_raise: [],

    # Calculation options
    # units: :mi,                 # :km for kilometers or :mi for miles
    # distances: :linear          # :spherical or :linear
  )
else
  Geocoder.configure(
    # Geocoding options
    # timeout: 3,                 # geocoding service timeout (secs)
    lookup: :google,            # name of geocoding service (symbol)
    ip_lookup: :freegeoip,      # name of IP address geocoding service (symbol)
    # language: :en,              # ISO-639 language code
    use_https: false,           # use HTTPS for lookup requests? (if supported)
    #http_proxy: ENV['QUOTAGUARD_URL'],            # HTTP proxy server (user:pass@host:port)
    # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
    #api_key: '',               # API key for geocoding service
    cache: Redis.new,                 # cache object (must respond to #[], #[]=, and #del)
    # cache_prefix: 'geocoder:',  # prefix (string) to use for all cache keys

    # Exceptions that should not be rescued by default
    # (if you want to implement custom error handling);
    # supports SocketError and Timeout::Error
    # always_raise: [],

    # Calculation options
    # units: :mi,                 # :km for kilometers or :mi for miles
    # distances: :linear          # :spherical or :linear
  )  
end
class UrlParser 
    attr_reader :scheme, :domain, :path, :fragment_id

    def initialize(url)
        @url = url
        @scheme = @url.split('/')[0].split(':')[0]
        @domain = @url.split('/')[2].split(':')[0] 
        if @url.split('/')[2].include? ':' 
            @port = @url.split('/')[2].split(':')[1]
        else 
            @port = nil 
        end
        @path = @url.split('/')[3].split('?')[0]
        @querystring = {}
    end

    def query_string
        qs = @url.split('/')[3].split('?')[1].split('#')[0].split('&')
        qs.each do |item|
            param = item.split('=')
            @querystring[param[0]] = param[1]
        end 
        @querystring
    end

    def path 
        if @path == "" 
            @path = nil
        end 
        @path
    end

    def port 
        if (@port == "" || @port == nil) && scheme == "https"
            @port = 443.to_s
        elsif (@port == "" || @port == nil) && scheme == "http"
            @port = 80.to_s
        end 
        @port
    end

    def fragment_id
        @fragment_id = @url.split('/')[3].split('?')[1].split('#')[1]
    end
end
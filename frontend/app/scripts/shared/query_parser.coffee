define ->
  
  QueryParser =
    params: ->
      query = window.location.search.substring(1)
      vars = query.split('&')
      params = {}
      for pair in vars
        do(pair) ->
          pair = pair.split('=')
          params[ decodeURIComponent(pair[0]) ] = decodeURIComponent(pair[1])
          
      console.log params
      params

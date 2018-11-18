import 'whatwg-fetch'

export default (
  method,
  path,
  query = {},
  body = {},
  headers = {},
) ->
  # necessary method & path
  throw new Error('necessary method & path') if !method && !path
  # build options of fetch
  options = () ->
    headersSent = Object.assign({}, { 'content-type': 'application/json' }, headers);
    opt =
      method: method
      headers: headersSent
    # if has body, insert body to opt
    if body instanceof FormData
      delete opt.headers['content-type']
      Object.assign(opt, { body: body })
    else if Object.keys(body).length != 0
      Object.assign(opt, { body: JSON.stringify(body) })
    return opt
  options = options()
  # build queryString of fetch
  queryString = ->
    queryStr = ''
    if Object.keys(query).length != 0
      Object.keys(query).forEach((key) ->
        if {}.hasOwnProperty.call(query, key)
          value = query[key];
          if key == Object.keys(query)[0]
            queryStr += "?#{key}=#{value}"
          else
            queryStr += "&#{key}=#{value}"
      )
    return queryStr
  queryString = queryString()
  # let's fetch
  try
    res = await fetch("#{window.$host}#{path}#{queryString}", options)
    data = ''
    try
      data = await res.json()
    catch err
      data = {}
    window.location.href = '/login' if res.status == 401 && !window.location.href.endsWith('/login')
    return Object.assign({}, { ok: false, status: res.status, data }) if (res.status >= 400)
    return Object.assign({}, { ok: true, status: res.status, data })
  catch err
    return { ok: false, msg: err }

export default
  guard: -> # Navigate to somewhere if 401
    window.location.href = '/login' unless window.localStorage.getItem('user.token')?
  entity: (id, token) -> # Get Token Stored
    if id?
      window.localStorage.setItem('user.id', id)
      window.localStorage.setItem('user.token', token)
    return
      id: window.localStorage.getItem('user.id')
      token: window.localStorage.getItem('user.token') 
  revoke: () -> # Revoke the Token
    window.localStorage.clear()

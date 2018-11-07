export default
  login: () -> # Login
    console.log('Hello')
  guard: (resp) -> # Navigate to somewhere if 401
    if resp is undefined
      # Local check
      window.location.href = '/login' unless window.localStorage.getItem('user.token')?
      return
    # Check response
    console.log('Guard')
  token: () -> # Get Token Stored
    console.log('Token')
  revoke: () -> # Revoke the Token
    console.log('Revoke')

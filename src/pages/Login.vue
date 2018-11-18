<template lang="pug">
#login
  form.md-layout(novalidate, @submit.prevent="submitPrevent")
    md-card.md-layout-item.md-size-50.md-small-size-100
      md-card-header
        .md-title
          | Login / Register
      md-card-content
        .md-layout.md-gutter
          .md-layout-item.md-size-50.md-small-size-100
            md-field
              label(for="username")
                | Username
              md-input(name="username", autocomplete="username", v-model="form.username")
          .md-layout-item.md-size-50.md-small-size-100
            md-field
              label(for="password")
                | Password
              md-input(name="password", autocomplete="password", type="password", v-model="form.password")
      md-card-actions
        md-button.md-primary(type="submit", @click="login")
          | Login
        md-button.md-primary(type="submit")
          | Register
  md-dialog-alert(
    :md-active.sync="unauthorizedDialog"
    md-content="Username or Password Incorrect"
    md-confirm-text="Retry")
</template>

<script lang="coffee">
import request from '@/utils/request'
import user from '@/utils/user'

export default
  name: 'Login'
  data: ->
    unauthorizedDialog: false
    form:
      username: ''
      password: ''
  methods:
    login: () ->
      req =
        username: this.form.username
        password: this.form.password
      res = await request('POST', "/users/login", {}, req)
      if res.ok
        user.entity(res.data.user.id, res.data.token)
        this.$router.push({ path: '/' })
      else if res.status == 401
        this.unauthorizedDialog = true
    submitPrevent: () -> true
</script>

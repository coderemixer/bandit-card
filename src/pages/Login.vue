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
              md-input(name="username", autocomplete="username", :model="form.username")
          .md-layout-item.md-size-50.md-small-size-100
            md-field
              label(for="password")
                | Password
              md-input(name="password", autocomplete="password", type="password", :model="form.password")
      md-card-actions
        md-button.md-primary(type="submit", @click="login")
          | Login
        md-button.md-primary(type="submit")
          | Register
</template>

<script lang="coffee">
import r2 from 'r2'

export default
  name: 'Login'
  data: ->
    form:
      username: ''
      password: ''
  methods:
    login: () ->
      console.log('Hello')
    submitPrevent: () -> true
</script>

<template lang="pug">
#home
  md-empty-state(
    md-icon="flash_on",
    md-label="Create your first card"
    md-description="Create cards before you start learning.")
      md-button.md-primary.md-raised
        | Create first card
</template>

<script lang="coffee">
import user from '@/utils/user'

export default
  name: 'Home'
  created: () ->
    user.guard()
</script>

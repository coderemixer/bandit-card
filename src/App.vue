<template lang="pug">
md-app#app(md-waterfall md-mode='fixed')
  md-app-toolbar.md-primary
    md-button.md-icon-button(@click='toggleMenu', v-if='!menuVisible')
      md-icon
        | menu
    span.md-title
      | Bandit Card

  md-app-drawer(:md-active.sync='menuVisible', md-persistent='full')
    md-toolbar.md-transparent(md-elevation='0')
      span
        | Navigation
      .md-toolbar-section-end
        md-button.md-icon-button.md-dense(@click='toggleMenu')
          md-icon
            | keyboard_arrow_left
    md-list
      md-list-item(@click='toggleMenu')
        md-icon
          | home
        span.md-list-item-text
          | Home
      md-list-item(@click='toggleMenu')
        md-icon
          | bookmarks
        span.md-list-item-text
          | Bookmarks
      md-list-item(@click='toggleMenu')
        md-icon
          | shop
        span.md-list-item-text
          | CardHub
      md-list-item(@click='toggleMenu')
        md-icon
          | list
        span.md-list-item-text
          | Manage
      md-list-item(@click='toggleMenu')
        md-icon
          | trending_up
        span.md-list-item-text
          | Stat
      md-list-item(@click='toggleMenu')
        md-icon
          | person
        span.md-list-item-text
          | Profile
      md-divider
      md-list-item
        md-menu(md-size='auto')
          md-button(md-menu-trigger)
            span.md-list-item-text
              | Language
          md-menu-content
            md-menu-item
              | English
            md-menu-item
              | 简体中文
            md-menu-item
              | 繁體中文
            md-menu-item
              | 日本語
  md-app-content
    router-view
</template>

<script>
export default {
  name: 'App',
  data: () => ({
    menuVisible: false,
  }),
  methods: {
    toggleMenu() {
      this.menuVisible = !this.menuVisible;
    },
  },
};
</script>

<style lang="stylus">
#app
  font-family 'Avenir', Helvetica, Arial, sans-serif
  -webkit-font-smoothing antialiased
  -moz-osx-font-smoothing grayscale
  min-height 100vh

.md-drawer
  width 230px
  max-width calc(100vw - 125px)
</style>

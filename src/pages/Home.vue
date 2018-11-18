<template lang="pug">
#home
  .md-layout.md-gutter
    .projects.md-layout-item.md-size-30
      md-list.md-double-line
        md-subheader
          | Projects
        md-list-item(v-for="project in projects", key="project.id", @click="switchProject(project.id)")
          .md-list-item-text
            span
              | {{ project.name }}
            span
              | {{ project.description }}
        md-list-item(@click="loadMore()", v-if="page * 10 < count")
          .md-list-item-text
            span
              | Load More...
    .cards.md-layout-item
      md-empty-state(
        v-if="card === null",
        md-icon="flash_on",
        md-label="Create your first card"
        md-description="Create cards before you start learning.")
          md-button.md-primary.md-raised(@click='$router.push({ path: "/manage" })')
            | Create first card
      .card(v-else)
        md-card.md-primary
          md-card-header
            md-card-header-text
              .md-title(v-if="showAnswer")
                | Answer
              .md-title(v-else)
                | Question
          md-card-content
            .stat
              | Last Answered: {{ card.updated_at }}
              br
              | Failures / Attempts: {{ card.failures }} / {{ card.attempts }}
            div(v-html="renderMarkdown(card.answer)", v-if="showAnswer")
            div(v-html="renderMarkdown(card.question)", v-else)
          md-card-actions
            md-button(v-if="!showAnswer", @click="showAnswer = true")
              | Show Answer
            md-button(v-if="showAnswer", @click="submitResult(0)")
              | Remembered
            md-button(v-if="showAnswer", @click="submitResult(1)")
              | Not Yet
</template>

<script lang="coffee">
import marked from 'marked'
import request from '@/utils/request'
import user from '@/utils/user'

export default
  name: 'Home'
  data: ->
    projects: []
    page: 1
    count: 1
    showAnswer: false
    project: null
    card: null
  methods:
    getProjects: () ->
      entity = user.entity()
      res = await request('GET', "/users/#{entity.id}/projects", { page: this.page }, {}, { token: entity.token })
      if res.ok
        this.projects.push(...res.data.projects)
        this.count = res.data.count
        this.switchProject(this.projects[0].id) if res.data.count
    loadMore: () ->
      this.page += 1
      this.getProjects()
    renderMarkdown: (markdown) -> marked(markdown)
    switchProject: (id) ->
      this.project = id
      entity = user.entity()
      res = await request('GET', "/projects/#{this.project}/challenge", {}, {}, { token: entity.token })
      if res.ok
        this.card = res.data
        this.showAnswer = false
    submitResult: (score) ->
      entity = user.entity()
      res = await request('PUT', "/cards/#{this.card.id}/challenge/#{score}", {}, {}, { token: entity.token })
      if res.ok
        this.card = res.data
        this.showAnswer = false
  created: () ->
    user.guard()
    this.getProjects()
</script>

<style lang="stylus" scoped>
.projects
  min-height 100vh
</style>

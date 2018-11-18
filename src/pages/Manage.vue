<template lang="pug">
#home
  .md-layout.md-gutter
    .projects.md-layout-item.md-size-30
      md-list.md-double-line
        md-subheader
          | Projects
        md-list-item(@click="showCreate = true")
          .md-list-item-text
            span
              | New Project
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
    .cards.md-layout-item.md-size-70
      md-empty-state(
        v-if="project === null",
        md-icon="storage",
        md-label="Create your first project"
        md-description="Create projects before you start learning.")
          md-button.md-primary.md-raised(@click="showCreate = true")
            | Create first project
      div(v-else)
        md-button.md-accent(@click="showDelete = true")
          | Delete Project
        md-table(md-card)
          md-table-row
            md-table-head(md-numeric)
              | ID
            md-table-head
              | Question
            md-table-head
              | Answer
            md-table-head
              | Created At
            md-table-head
              | Actions
          md-table-row(v-for="card in cards", :key="card.id")
            md-table-cell(md-numeric)
              | {{ card.id }}
            md-table-cell
              | {{ card.question }}
            md-table-cell
              | {{ card.answer }}
            md-table-cell
              | {{ card.created_at }}
            md-table-cell
              md-button.md-icon-button.md-primary(@click="editCard(card)")
                md-icon
                  | edit
              md-button.md-icon-button.md-accent(@click="deleteCard(card)")
                md-icon
                  | delete
        form.card-form
          md-card.md-layout-item
            md-card-header
              .md-title
                | Card Editor
            md-card-content
              .md-layout.md-gutter
                .md-layout-item.md-small-size-100
                  md-field
                    label
                      | ID (Leave blank for creating)
                    md-input(type="number", v-model="card.id")
              .md-layout.md-gutter
                .md-layout-item.md-small-size-100
                  md-field
                    label
                      | Question (Markdown Supported)
                    md-textarea(v-model="card.question")
                .md-layout-item.md-small-size-100
                  md-field
                    label
                      | Answer (Markdown Supported)
                    md-textarea(v-model="card.answer")
            md-card-actions
              md-button.md-primary(@click="submitCard")
                | Submit
  md-dialog-confirm(
    :md-active.sync="showDelete",
    md-title="Are You Sure To Delete This Project"
    md-content="This Process CAN NOT BE REVERTED!!!"
    md-confirm-text="DELETE"
    md-cancel-text="Cancel"
    @md-confirm="deleteProject()"
  )
  md-dialog(:md-active.sync="showCreate")
    md-dialog-title
      | Create Project
    form.project-form
      .md-layout.md-gutter
        .md-layout-item.md-small-size-100
          md-field
            label
              | Project Name
            md-input(v-model="projectForm.name")
      .md-layout.md-gutter
        .md-layout-item.md-small-size-100
          md-field
            label
              | Project Description
            md-input(v-model="projectForm.description")
    md-dialog-actions
      md-button.md-primary(@click="submitProject")
        | Submit
</template>

<script lang="coffee">
import marked from 'marked'
import request from '@/utils/request'
import user from '@/utils/user'

export default
  name: 'Manage'
  data: ->
    projects: []
    page: 1
    count: 1
    project: null
    showCreate: false
    showDelete: false
    cards: []
    projectForm:
      name: ''
      description: ''
    card:
      id: ''
      question: ''
      answer: ''
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
    switchProject: (id) ->
      entity = user.entity()
      this.project = id
      res = await request('GET', "/projects/#{this.project}", {}, {}, { token: entity.token })
      if res.ok
        this.cards = res.data.cards
        for page in [2..Math.ceil(res.data.count / 10)] by 1
          res = await request('GET', "/projects/#{this.project}", { page: page }, {}, { token: entity.token })
          this.cards.push(...res.data.cards) if res.ok
    editCard: (card) ->
      this.card.id = card.id
      this.card.question = card.question
      this.card.answer = card.answer
    submitCard: () ->
      entity = user.entity()
      if this.card.id is ''
        res = await request('POST', "/projects/#{this.project}/cards", {}, {
          question: this.card.question
          answer: this.card.answer
        }, { token: entity.token })
        window.location.reload() if res.ok
      else
        res = await request('PUT', "/cards/#{this.card.id}", {}, {
          question: this.card.question
          answer: this.card.answer
        }, { token: entity.token })
        window.location.reload() if res.ok
    submitProject: () ->
      unless this.projectForm.name == ''
        entity = user.entity()
        res = await request('POST', "/users/#{entity.id}/projects", {}, {
          name: this.projectForm.name
          description: this.projectForm.description
          is_public: false
        }, { token: entity.token })
        window.location.reload() if res.ok
    deleteCard: (card) ->
      entity = user.entity()
      res = await request('DELETE', "/cards/#{card.id}", {}, {}, { token: entity.token })
      window.location.reload() if res.ok
    deleteProject: ->
      entity = user.entity()
      res = await request('DELETE', "/projects/#{this.project}", {}, {}, { token: entity.token })
      window.location.reload() if res.ok
  created: () ->
    user.guard()
    this.getProjects()
</script>

<style lang="stylus" scoped>
.projects
  min-height 100vh

.card-form
  margin 20px 0 0 0

.project-form
  margin 20px
</style>

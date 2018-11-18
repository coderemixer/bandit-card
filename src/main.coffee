import Vue from 'vue'
import {
  MdApp,
  MdButton,
  MdCard,
  MdContent,
  MdDialog,
  MdDialogAlert,
  MdDialogConfirm,
  MdDivider,
  MdDrawer,
  MdEmptyState,
  MdField,
  MdIcon,
  MdList,
  MdMenu,
  MdSubheader,
  MdTable,
  MdToolbar,
} from 'vue-material/dist/components'
import 'vue-material/dist/vue-material.min.css'
import 'vue-material/dist/theme/default.css'
import App from './App'
import router from './router'

Vue.config.productionTip = false

window.$host = 'https://api.bandit.coderemixer.com'
window.$host = 'http://localhost:9292' if window.location.href.startsWith('http://localhost') # For debugging

Vue.use val for val in [
  MdApp
  MdButton
  MdCard
  MdContent
  MdDialog
  MdDialogAlert
  MdDialogConfirm
  MdDivider
  MdDrawer
  MdEmptyState
  MdField
  MdIcon
  MdList
  MdMenu
  MdSubheader
  MdTable
  MdToolbar
]

new Vue
  el: '#app'
  router: router
  components: { App }
  template: '<App/>'

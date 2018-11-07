import Vue from 'vue'
import {
  MdApp,
  MdButton,
  MdCard,
  MdContent,
  MdDivider,
  MdDrawer,
  MdEmptyState,
  MdField,
  MdIcon,
  MdList,
  MdMenu,
  MdToolbar,
} from 'vue-material/dist/components'
import 'vue-material/dist/vue-material.min.css'
import 'vue-material/dist/theme/default.css'
import App from './App'
import router from './router'

Vue.config.productionTip = false

Vue.use val for val in [
  MdApp
  MdButton
  MdCard
  MdContent
  MdDivider
  MdDrawer
  MdEmptyState
  MdField
  MdIcon
  MdList
  MdMenu
  MdToolbar
]

new Vue
  el: '#app'
  router: router
  components: { App }
  template: '<App/>'

// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue';
import {
  MdApp,
  MdButton,
  MdContent,
  MdDivider,
  MdDrawer,
  MdEmptyState,
  MdIcon,
  MdList,
  MdMenu,
  MdToolbar,
} from 'vue-material/dist/components';
import 'vue-material/dist/vue-material.min.css';
import 'vue-material/dist/theme/default.css';
import App from './App';
import router from './router';

Vue.config.productionTip = false;

[
  MdApp,
  MdButton,
  MdContent,
  MdDivider,
  MdDrawer,
  MdEmptyState,
  MdIcon,
  MdList,
  MdMenu,
  MdToolbar,
].forEach(val => Vue.use(val));

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>',
});

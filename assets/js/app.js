import Vue from 'vue'
import VueResource from 'vue-resource'
import BootstrapVue from "bootstrap-vue"
import Autocomplete from 'v-autocomplete'
import router from './router'
import App from './App.vue'
import "bootstrap/dist/css/bootstrap.min.css"
import "bootstrap-vue/dist/bootstrap-vue.css"
import "phoenix_html"

Vue.use(VueResource)
Vue.use(BootstrapVue)
Vue.use(Autocomplete)

new Vue({
  el: '#app',
  router,
  render: h => h(App)
})

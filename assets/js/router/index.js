import Vue from 'vue'
import Router from 'vue-router'
import Index from '../components/Index.vue'
import Query from '../components/Query.vue'
import 'v-autocomplete/dist/v-autocomplete.css'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Index',
      component: Index
    },
    {
      path: '/query',
      name: 'Query',
      component: Query
    }
  ]
})
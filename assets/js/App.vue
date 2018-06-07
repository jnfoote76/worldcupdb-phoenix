<template>
  <div id="app">
    <Query></Query>
  </div>
</template>

<script>
import Query from './components/Query.vue'
export default {
  name: 'app',
  components: {
    Query
  },
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  margin-left: 10px;
  margin-right: 10px;
}
</style>
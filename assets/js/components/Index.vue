<template>
  <div class="index">
      <img src="/images/soccer_ball.jpg" />
      <h1>Mondial DB: A World Cup Database</h1>
      <div v-if="autocompleteLoaded">
        <form>
          <select v-model="selected">
            <option v-for="(option, index) in queries" :key="index" :value="index" :disabled="option.disabled">
              {{ option.name }}
            </option>
          </select>
          <br />

          <InputSet :fields="queries[selected].prompts" v-model="formFields"></InputSet>
          <br />
          <router-link tag="button" :to="{ name: 'Query', query: { selected: selected, formFields: formFields.join() }}">
            Run Query
          </router-link>
        </form>
      </div>

      <div v-if="!autocompleteLoaded">
        <div class="fa fa-spinner fa-spin big-icon"></div>
      </div>
  </div>
</template>

<script>
import InputSet from './InputSet.vue'
import Items from '../items.js'
import Queries from './queries.js'

export default {
  components: {
    InputSet
  },
  data () {
    return {
      queries: Queries([], [], []),
      formFields: [],
      selected: 0,
      autocompleteLoaded: false
    }
  },
  mounted () {
    var playerPromise = this.$http.get('/api/players');
    var countryPromise = this.$http.get('/api/countries');
    var stadiumPromise = this.$http.get('/api/stadiums');

    Promise.all([playerPromise, countryPromise, stadiumPromise]).then(([playerResponse, countryResponse, stadiumResponse]) => {
      if (playerResponse.ok && countryResponse.ok && stadiumResponse.ok) {
        var playerData = playerResponse.body.data;
        var countryData = countryResponse.body.data;
        var stadiumData = stadiumResponse.body.data;

        var playerNames = [];
        for (var i = 0; i < playerData.length; i++) {
          playerNames.push(playerData[i].name);
        }

        var countryNames = [];
        for (var i = 0; i < countryData.length; i++) {
          countryNames.push(countryData[i].name);
        }

        var stadiumNames = [];
        for (var i = 0; i < stadiumData.length; i++) {
          stadiumNames.push(stadiumData[i].name);
        }

        this.queries = Queries(playerNames, countryNames, stadiumNames);
        this.autocompleteLoaded = true
      } else {
        console.log(playerResponse.text());
        console.log(countryResponse.text());
        console.log(stadiumResponse.text());
      }
    })
  },
  methods: {
    printData () {
      console.log(this.formFields);
    }
  },
  watch: {
    formFields: (val) => {
      console.log("Field values changed");
      console.log(val);
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.index {
  margin-top: 100px;
  text-align: center;
}

InputSet {
  display: inline;
}

img {
  height: 250px;
  width: 350px;
}

h1 {
  font-weight: normal;
}

input {
  margin-left: 5px;
  margin-right: 5px;
  margin-bottom: 5px;
}

select {
  margin-bottom: 20px;
  margin-left: 5px;
}

.submit {
  margin-top: 10px;
}

.big-icon {
    font-size: 64px;
}

</style>

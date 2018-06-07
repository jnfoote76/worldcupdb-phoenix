<template>
  <div class="query">
    <div v-if="autocompleteLoaded" class="outside-table">
      <img src="/images/soccer_ball.jpg" />
      <h1>Mondial DB: A World Cup Database</h1>
      <form>
        <select v-model="selected">
          <option v-for="(option, index) in queries" :key="index" :value="index" :disabled="option.disabled">
            {{ option.name }}
          </option>
        </select>
        <br />

        <InputSet ref="inputSet" :fields="queries[selected].prompts" v-model="formFields"></InputSet>
        <b-button v-on:click="runQuery()">Run Query</b-button>
      </form>
    </div>

    <div v-if="!autocompleteLoaded" class="outside-table">
      <div class="fa fa-spinner fa-spin big-icon"></div>
    </div>

    <div v-if="queryResultsLoaded">
      <b-table striped hover :items="queryResponseData"></b-table>
    </div>

    <div v-if="querySubmitted && !queryResultsLoaded" class="outside-table">
      <div class="fa fa-spinner fa-spin big-icon"></div>
    </div>
  </div>
</template>

<script>
import InputSet from './InputSet.vue'
import Queries from './queries.js'

export default {
  components: {
    InputSet
  },
  data () {
    return {
      queries: Queries([], [], []),
      queryResponseData: [],
      formFields: [],
      selected: 0,
      autocompleteLoaded: false,
      queryResultsLoaded: false,
      querySubmitted: false
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
    },
    runQuery() {
      this.querySubmitted = true;
      this.queryResultsLoaded = false;
      var query = this.queries[this.selected];
      var queryUrl = '/api/query/' + query.id;
      console.log(query.prompts);
      var completedFields = this.collectAutocompleteValues();
      console.log(completedFields);
      var fields = this.fieldsForQuery(query.prompts, completedFields);
      console.log(fields);

      console.log("Entering if statement");
      if (Object.keys(fields).length > 0) {
        queryUrl += '?';
        console.log(queryUrl);
        for (var fieldName in fields) {
          queryUrl += fieldName + '=' + fields[fieldName] + '&';
          console.log(queryUrl);
        }

        queryUrl = queryUrl.slice(0, -1);
      }

      this.$http.get(queryUrl).then(response => {
        this.queryResponseData = response.body.data;
        this.queryResultsLoaded = true;
        this.querySubmitted = false;
      }, response => {
        console.log(response.text);
      })
    },
    fieldsForQuery(prompts, values) {
      var queryFields = {}
      for (var i = 0; i < prompts.length; i++) {
        var prompt = prompts[i];
        var value = values[i];
        if (value !== undefined && value !== null && value !== "") {
          queryFields[prompt.id] = value;
        }
      }

      return queryFields;
    },
    collectAutocompleteValues() {
      console.log("Current formFields value: ");
      console.log(this.formFields);
      var completedFields = this.formFields;
      var autocompleteFields = this.$refs.inputSet.$refs.autocompleteInput;
      console.log(autocompleteFields);
      var autoCompleteIndex = 0;
      var prompts = this.queries[this.selected].prompts;
      for (var i = 0; i < prompts.length; i++) {
        var currField = prompts[i];
        if (currField.type === 'autocomplete') {
          completedFields[i] = autocompleteFields[autoCompleteIndex].searchText;
          autoCompleteIndex++;
        }
      }

      return completedFields;
    }
  },
  props: ['initialQuery', 'initialFormFieldValues'],
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
.query {
  margin-top: 20px;
}

.outside-table {
  text-align: center;
}

InputSet {
  display: inline;
}

img {
  height: 200px;
  width: 300px;
  margin-bottom: 15px;
  margin-top: 10px;
  margin-bottom: 20px;
}

h1 {
  font-weight: normal;
  margin-bottom: 20px;
}

input {
  margin-left: 100px;
  margin-right: 5px;
  margin-bottom: 10px;
}

select {
  margin-bottom: 20px;
  margin-left: 5px;
  margin-right: 5px;
}

.submit {
  margin-top: 10px;
}

.big-icon {
  font-size: 64px;
}

.b-table {
  margin-top: 80px;
}
</style>

<template>
    <span class="input-set">
        <span v-for="(field, index) in fields" :key="field.id">
            <span>{{field.prompt}}: </span>
            <v-autocomplete v-if="field.type === 'autocomplete'" ref="autocompleteInput" 
            :items="autocompleteItems[index]" v-model="formFields[index]" 
            :get-label="getLabel" v-on:update-items='updateAutocompleteFields(index, field.items, $event)' 
            v-on:item-selected='emitFormFields' :auto-select-one-item='false' />
            <input v-if="field.type === 'number'" type="number" v-model="formFields[index]" v-on:input="emitFormFields" />
            <select v-if="field.type === 'select'" v-model="formFields[index]" v-on:input="emitFormFields">
                <option v-for="(item, index) in field.items" :value="item.value" :key="index">
                    {{ item.name }}
                </option>
            </select>
        </span>
    </span>
</template>

<script>
import ItemTemplate from './ItemTemplate.vue'
export default {
    name: 'InputSet',
    data () {
        return {
            formFields: [],
            autocompleteItems: [],
            autocompleteTemplate: ItemTemplate
        }
    },
    mounted () {
        for (var i = 0; i < this.$props.fields.length; i++) {
            var field = this.$props.fields[i];
            if (field.type === 'autocomplete') {
                this.autocompleteItems.push([])
            }
            this.formFields[i] = null;
        }
    },
    methods: {
        getLabel (item) {
            return item
        },
        updateAutocompleteFields(index, allItems, enteredText) {
            this.$set(this.autocompleteItems, index, allItems.filter((item) => {
                return (new RegExp(enteredText.toLowerCase())).test(item.toLowerCase())
            }));
        },
        emitFormFields(event) {
            console.log(event);
            console.log(this.formFields);
            this.$nextTick(() => {
                this.$emit('input', this.formFields);
            });
        },
    },
    props: ['fields'],
    watch: {
        fields(newVal, oldVal) {
            for (var i = 0; i < this.$refs.autocompleteInput.length; i++) {
                this.$refs.autocompleteInput[i].searchText = "";
            }

            this.formFields = [];
            this.autocompleteItems = [];
            for (var i = 0; i < newVal.length; i++) {
                var field = newVal[i];
                if (field.type === 'autocomplete') {
                    this.autocompleteItems.push([]);
                }
                this.formFields[i] = null;
            }

            this.$emit('input', this.formFields);
        }
    }
}
</script>

<style lang="stylus" scoped>
.v-autocomplete
  display inline-block
  margin-right 10px
  .v-autocomplete-input-group
    .v-autocomplete-input
      width 150px
      position relative
      display inline
      font-size 1.5em
      box-shadow none
      outline none
      line-height 5px
  .v-autocomplete-list
    width 150px
    border none
    border-top none
    max-height 400px
    border-bottom 1px solid #157977
    .v-autocomplete-list-item
      cursor pointer
      padding 10px
      &:last-child
        border-bottom none
      &:hover
        background-color #eee
      abbr
        opacity 0.8
        font-size 0.8em
        display block
        font-family sans-serif
pre
  text-align left
  white-space pre-wrap
  background-color #eee
  border 1px solid silver
  padding 20px !important
  border-radius 10px
  font-family monospace !important
.left
  text-align left
.note
  border-left 5px solid #ccc
  padding 10px
input
  display inline
  margin-right 10px
select
  margin-right 10px
</style>


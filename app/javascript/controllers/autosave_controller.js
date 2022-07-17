import { Controller } from "@hotwired/stimulus";
import  debounce  from 'lodash/debounce'

export default class extends Controller {
  static values = {
    debounce: Number
  }
  connect () {
    if (this.debounceValue > 0) {
      this.save = debounce(this.save, this.debounceValue)
    }
  }

  save () {
    console.log('Saving')
    this.element.requestSubmit()
  }
}

import ApplicationController from "controllers/application_controller"
import TomSelect from 'tom-select'

export default class extends ApplicationController {
  static values = {
    model: String,
    value: String,
    label: String,
    selected: String
  }

  connect () {
    var settings = {
      valueField: this.valueValue,
      labelField: this.labelValue,
      searchField: this.labelValue,
      maxItems: 1,
      loadThrottle: 50,
      load: this.search,
    }
    if (this.selectedValue != '') {
      var initial_option = {}
      initial_option[this.valueValue] = this.selectedValue
      initial_option[this.labelValue] = this.selectedValue

      settings['items'] = [this.selectedValue]
      settings['options'] = [initial_option]
    }

    this.control = new TomSelect(this.element, settings)
    super.connect()
  }

  search = (search, callback) =>
    this.stimulate("TomSelect#lookup", this.modelValue, search).then(({ payload }) =>
      callback(payload)
    )

  disconnect() {
    if (this.control) this.control.destroy()
  }
}

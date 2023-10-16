import ApplicationController from "controllers/application_controller"
import TomSelect from 'tom-select'

export default class extends ApplicationController {
  static values = {
    model: String,
    value: String,
    label: String
  }

  connect () {
    this.control = new TomSelect(this.element, {
      valueField: this.valueValue,
      labelField: this.labelValue,
      searchField: this.labelValue,
      maxItems: 1,
      loadThrottle: 50,
      load: this.search,
    })
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

import ApplicationController from "controllers/application_controller"
import TomSelect from 'tom-select'

export default class extends ApplicationController {
  static values = {
    reflex: String,
    options: String
  }

  connect () {
    this.control = new TomSelect(this.element, {
      valueField: 'number',
      labelField: 'description',
      searchField: 'description',
      maxItems: 1,
      loadThrottle: null,
      load: this.search,
      //plugins: ['dropdown_input'],
    })
    super.connect()
  }

  search = (search, callback) =>
    this.stimulate(this.reflexValue, search).then(({ payload }) =>
      callback(payload)
    )

  disconnect() {
    if (this.control) this.control.destroy()
  }
}

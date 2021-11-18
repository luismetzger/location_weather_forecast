import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'field', 'latitude' ]

  connect() {
    if ((typeof(google)) != 'undefined') {
      this.initMap()
    }
  }

  initMap() {
    this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
    this.autocomplete.setFields(['address_components', 'geometry', 'name'])
    this.autocomplete.addListener('place_changed', this.placeChanged.bind(this))
  }

  placeChanged() {
    let place = this.autocomplete.getPlace()

    if (!place.geometry) {
      window.alert(`No information available for: ${place.name}`)
      return
    }
  }
}

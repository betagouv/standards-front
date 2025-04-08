import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
  }

  submit(event) {
    const form = event.target.closest("form")

    // Get the startup_ghid from the URL
    const pathParts = window.location.pathname.split('/')
    const startupGhidIndex = pathParts.indexOf('startups') + 1
    const startupGhid = pathParts[startupGhidIndex]

    // Create FormData and append startup_ghid
    const formData = new FormData(form)
    formData.append('startup_ghid', startupGhid)

    fetch(form.action, {
      method: form.method,
      body: formData,
      headers: {
        'Accept': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        // Optional: Show a success indicator
      }
    })
    .catch(error => {
      console.error("Error saving audit criterion:", error)
    })

    // Prevent the default form submission
    event.preventDefault()
  }
}

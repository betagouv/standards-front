import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "questionCard"]

  connect() {
    // Check initial state of all question cards
    this.updateAllQuestionCardStates()
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
        // Update the question card state
        this.updateQuestionCardState(form)
      }
    })
    .catch(error => {
      console.error("Error saving audit criterion:", error)
    })

    // Prevent the default form submission
    event.preventDefault()
  }

  updateQuestionCardState(form) {
    // Find the question card containing this form
    const questionCard = form.closest('.question-card')
    if (!questionCard) return

    // Check if all checkboxes in this card are checked
    const checkboxes = questionCard.querySelectorAll('input[type="checkbox"]')
    const allChecked = Array.from(checkboxes).every(checkbox => checkbox.checked)

    // Update the card state
    if (allChecked) {
      if (!questionCard.classList.contains('completed')) {
        questionCard.classList.add('completed')
      }
    } else {
      questionCard.classList.remove('completed')
    }
  }

  updateAllQuestionCardStates() {
    // Update all question cards on page load
    const questionCards = document.querySelectorAll('.question-card')
    questionCards.forEach(card => {
      const checkboxes = card.querySelectorAll('input[type="checkbox"]')
      const allChecked = Array.from(checkboxes).every(checkbox => checkbox.checked)

      if (allChecked) {
        card.classList.add('completed')
      } else {
        card.classList.remove('completed')
      }
    })
  }
}

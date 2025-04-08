import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "questionCard"]

  connect() {
    // Check initial state of all question cards
    this.updateAllQuestionCardStates()
    // Check initial state of all tabs
    this.updateAllTabStates()
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
        // Update the tab state
        this.updateTabState(form)
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

  updateTabState(form) {
    // Find the tab panel containing this form
    const tabPanel = form.closest('.fr-tabs__panel')
    if (!tabPanel) return

    // Find the tab button for this panel
    const tabId = tabPanel.id
    const tabButton = document.querySelector(`[aria-controls="${tabId}"]`)
    if (!tabButton) return

    // Check if all question cards in this tab panel are completed
    const questionCards = tabPanel.querySelectorAll('.question-card')
    const allCompleted = Array.from(questionCards).every(card => card.classList.contains('completed'))

    // Update the tab button state
    // Update the tab button state
    tabButton.classList.toggle('fr-icon-checkbox-circle-fill', allCompleted)
    tabButton.classList.toggle('fr-icon-checkbox-circle-line', !allCompleted)
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

  updateAllTabStates() {
    // Update all tabs on page load
    const tabPanels = document.querySelectorAll('.fr-tabs__panel')
    tabPanels.forEach(panel => {
      // Find the tab button for this panel
      const tabId = panel.id
      const tabButton = document.querySelector(`[aria-controls="${tabId}"]`)
      if (!tabButton) return

      // Check if all question cards in this tab panel are completed
      const questionCards = panel.querySelectorAll('.question-card')
      const allCompleted = Array.from(questionCards).every(card => card.classList.contains('completed'))

      // Update the tab button state
      tabButton.classList.toggle('fr-icon-checkbox-circle-fill', allCompleted)
      tabButton.classList.toggle('fr-icon-checkbox-circle-line', !allCompleted)
    })
  }
}

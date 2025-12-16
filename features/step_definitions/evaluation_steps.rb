# frozen_string_literal: true

require 'cucumber/rspec/doubles'

Sachantque("je suis {string} avec l'email {string}") do |name, email|
  @user = FactoryBot.create(
    :user,
    :with_active_mission,
    fullname: name,
    primary_email: email
  )
end

Sachantque("je suis {string} avec l'email secondaire {string}") do |name, email|
  @user = FactoryBot.create(
    :user,
    :with_active_mission,
    fullname: name,
    secondary_email: email
  )
end

Given('je participe au produit {string}') do |name|
  startup = FactoryBot.create(:startup, name: name)

  @user.missions.last.startups << startup

  @user.reload
  @user.missions.reload
  @user.active_startups.reload
end

Quand('je me connecte') do
  step(%(je me connecte avec l'email "#{@user.primary_email}"))
end

Quand('je me connecte avec mon email secondaire') do
  step(%(je me connecte avec l'email "#{@user.secondary_email}"))
end

Quand("je me connecte avec l'email {string}") do |email|
  hash = {
    provider: 'proconnect',
    info: {
      email: email
    }
  }

  OmniAuth.config.mock_auth[:developer] = OmniAuth::AuthHash.new(hash)

  steps %(
    Quand je me rends sur la page d'accueil
    Et que je clique sur "Évaluez vos services"
    Et que je clique sur "Se connecter"
  )
end

Quand('je complète le standard {string}') do |nom|
  steps %(
    Quand je clique sur "#{nom}"
    Et que je choisis "Oui" pour chaque critère
    Et que je clique sur "Enregistrer ma réponse"
  )
end

Quand('je retourne au sommaire de l\'évaluation en cours') do
  step("je clique sur 'Évaluation du produit'")
end

Quand("je choisis {string} pour chaque critère") do |choix|
  page
    .all('.question-section fieldset')
    .each do |fieldset|
    within(fieldset) { choose(choix) }
  end
end

Alors("la page contient {string} pour le standard {string}") do |state, name|
  within("ol.fr-task-list__items") do |ol|
    within("li", text: name) do |item|
      expect(item).to have_text(state)
    end
  end
end

# frozen_string_literal: true

Sachantque("je suis {string} avec l'email {string}") do |name, email|
  @user = FactoryBot.create(
    :user,
    :with_active_mission,
    fullname: name,
    primary_email: email
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
  hash = {
    provider: 'developer',
    info: {
      email: @user.primary_email
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

Quand('je retourne au sommaire de l\'audit en cours') do
  step("je clique sur 'Audit du produit'")
end

Quand("je choisis {string} pour chaque critère") do |choix|
  page
    .all('.question-section fieldset')
    .each do |fieldset|
    within(fieldset) { choose(choix) }
  end
end

Quand('je coche toutes les cases') do
  page
    .all('input[type="checkbox"]')
    .map { |node| node.sibling("label").text }
    .each { |label| step(%(je coche "#{label}")) }
end

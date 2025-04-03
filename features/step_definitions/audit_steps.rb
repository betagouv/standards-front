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
    uid: @user.primary_email
  }

  OmniAuth.config.mock_auth[:developer] = OmniAuth::AuthHash.new(hash)

  steps %(
    Quand je me rends sur la page d'accueil
    Et que je clique sur "Connexion"
  )
end

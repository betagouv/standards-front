# frozen_string_literal: true

module LanguageHelper
  QUESTION_PREFIX = "Est-ce que"

  def questionize(phrase)
    remove_final_dot(
      elide(QUESTION_PREFIX, phrase)
    ) + " ?"
  end

  def elide(preposition, word)
    if vocalic?(word)
      "#{preposition.chop}'#{word}"
    else
      "#{preposition} #{word}"
    end
  end

  private

  def vocalic?(str)
    vowel?(str.chars.first)
  end

  def vowel?(char)
    I18n.transliterate(char.downcase).in?(%w[a e i o u])
  end

  def remove_final_dot(str)
    str.gsub(/\.$/, "")
  end
end

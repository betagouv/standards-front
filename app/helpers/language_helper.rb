# frozen_string_literal: true

module LanguageHelper
  QUESTION_PREFIX = "Est-ce que"

  def questionize(phrase)
    remove_final_dot(phrase)
      .then { |str| downcase_first_char(str) }
      .then { |str| elide(QUESTION_PREFIX, str) }
      .then { |str| str + " ?" }
  end

  def elide(preposition, rest)
    if vocalic?(rest)
      "#{preposition.chop}'#{rest}"
    else
      "#{preposition} #{rest}"
    end
  end

  private

  def vocalic?(str)
    vowel?(str.chars.first)
  end

  def vowel?(char)
    I18n.transliterate(char.downcase).in?(%w[a e i o u y])
  end

  def remove_final_dot(str)
    str.gsub(/\.$/, "")
  end

  def downcase_first_char(str)
    first_char, *rest = str.chars

    [ first_char.downcase, rest ].join
  end
end

# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.plural /^(.*)([lrnd])$/i, '\1\2es'
  inflect.singular /^(.*[aeiou])([lrnd])es$/i, '\1\2'
  inflect.plural /^(.*)z$/i, '\1ces'
  inflect.singular /^(.*)ces$/i, '\1z'
  inflect.plural /^(.*)ta$/i, '\1tas'
  inflect.singular /^(.*)ves$/i, '\1ve'

  inflect.irregular('el', 'los')
  inflect.irregular('binance', 'binances')
end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end

# frozen_string_literal: true

# NOTE: loading our EMDB models extensions (i.e reopening the
# espace_membre-ruby classes) can only be done with un-monitored code
# in the `lib` folder and loaded in an initializer, because if
# Zeitwerk gets involved and tries to reload a class like
# EspaceMembre::Startup, it will re-register our class and wipe/forget
# the gem's original code (and our code can't function without it).
#
# gem/model.rb
# ---
# module EspaceMembre
#   class Model < Something
#   end
# end
#
# ours/model.rb
# ---
# module EspaceMembre
#   class Model < Something
#     def overload
#       "custom"
#     end
#   end
# end
#
# if Zeitwerk was watching this, it would re-register the
# EspaceMembre::Model class/constant when the file ours/model.rb
# changes and "forget" the initial class in the gem folder.
#
# There might be a better way[1] but I couldn't figure it out.
#
# [1]: https://github.com/fxn/zeitwerk#reopening-third-party-namespaces
ActiveSupport.on_load(:active_record) do
  load Rails.root.join("lib/models/espace_membre/startup.rb")
end

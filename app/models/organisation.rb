# == Schema Information
#
# Table name: organisations
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  history     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Index: name

# app/models/organisation.rb
class Organisation < ApplicationRecord
end

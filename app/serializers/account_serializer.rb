class AccountSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :username
end

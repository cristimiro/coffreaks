# frozen_string_literal: true

# Admin schema
class AdminSchema < GraphQL::Schema
  mutation(Admin::Types::MutationType)
  query(Admin::Types::QueryType)
end

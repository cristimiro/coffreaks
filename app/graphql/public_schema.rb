# frozen_string_literal: true

# Public schema
class PublicSchema < GraphQL::Schema
  mutation(Public::Types::MutationType)
  query(Public::Types::QueryType)
end

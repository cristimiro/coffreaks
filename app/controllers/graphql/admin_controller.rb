class Graphql::AdminController < GraphqlController
  def execute
    result = AdminSchema.execute(
      params[:query],
      variables: prepare_variables(params[:variables]),
      context: {},
      operation_name: params[:operationName]
    )
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end
end

defmodule HetznerCloud.RequestError do
  @moduledoc """
  ##Errors

  Errors are indicated by HTTP status codes. Further, the response of the request which generated the error contains an error code, an error message, and, optionally, error details. The schema of the error details object depends on the error code.

  > The error response contains the following keys: [:code, :message, :details]

  **1** : forbidden - Insufficient permissions for this request
  **2** : invalid_input - Error while parsing or processing the input
  **3** : json_error - Invalid JSON input in your request
  **4** : locked - The item you are trying to access is locked (there is already an action running)
  **5** : not_found - Entity not found
  **6** : rate_limit_exceeded - Error when sending too many requests
  **7** : resource_limit_exceeded - Error when exceeding the maximum quantity of a resource for an account
  **8** : resource_unavailable - The requested resource is currently unavailable
  **9** : service_error - Error within a service
  **10** : uniqueness_error - One or more of the objects fields must be unique
  **11** : protected - The action you are trying to start is protected for this resource
  **12** : maintenance - Cannot perform operation due to maintenance
  """
  defstruct type: nil, details: nil, message: nil, headers: nil, code: nil
end

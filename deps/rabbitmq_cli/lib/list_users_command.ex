## The contents of this file are subject to the Mozilla Public License
## Version 1.1 (the "License"); you may not use this file except in
## compliance with the License. You may obtain a copy of the License
## at http://www.mozilla.org/MPL/
##
## Software distributed under the License is distributed on an "AS IS"
## basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
## the License for the specific language governing rights and
## limitations under the License.
##
## The Original Code is RabbitMQ.
##
## The Initial Developer of the Original Code is GoPivotal, Inc.
## Copyright (c) 2007-2016 Pivotal Software, Inc.  All rights reserved.


defmodule ListUsersCommand do
  

  def list_users([extra|_] = args, _) do
    {:too_many_args, args}
  end

  def list_users([], %{node: node_name, timeout: timeout} = opts) do
    info(opts)
    node_name
    |> Helpers.parse_node
    |> :rabbit_misc.rpc_call(:rabbit_auth_backend_internal, :list_users, [], timeout)
  end

  def usage, do: "list_users"

  defp info(%{quiet: true}), do: nil
  defp info(_), do: IO.puts "Listing users ..."
end

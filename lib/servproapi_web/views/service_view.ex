defmodule ServproapiWeb.ServiceView do
    use ServproapiWeb, :view

    def render("list.json", %{requests: requests}) do

        requests = Enum.map(requests, fn request -> 
            %{
                client: request.client,
                subject: request.subject,
                details: request.details,
                start_date: request.start_date,
                end_date: request.end_date,
                skill: request.skill.name,
                user: request.accepted_user_id
            }
        end)

        %{
            message: "Sucess!",
            meta: nil,
            data: requests
        }
    end
    
  end
  
defmodule ServproapiWeb.ServiceView do
    use ServproapiWeb, :view
    alias ServproapiWeb.ServiceView

    def render("200.json", %{data: data}) do
        %{
            message: "Sucess!",
            meta: nil,
            data: nil
        }
    end

    def render("list.json", %{requests: requests}) do
        %{
            message: "Sucess!",
            meta: nil,
            data: render_many(requests, ServiceView, "request.json")
        }
    end

    def render("request.json", %{service: request}) do
        %{
            client: request.client,
            subject: request.subject,
            details: request.details,
            start_date: request.start_date,
            end_date: request.end_date,
            skill: request.skill.name,
            user: request.accepted_user_id
        }
    end
    
  end
  
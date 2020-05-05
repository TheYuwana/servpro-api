defmodule ServproapiWeb.ErrorView do
  use ServproapiWeb, :view

  def render("400.json", %{data: data}) do
    %{
        code: 400,
        message: "Bad request",
        meta: nil,
        data: data
    }
  end

  def render("401.json", %{message: message}) do
    %{
        code: 401,
        message: message,
        meta: nil,
        data: nil
    }
  end

  def render("404.json", %{message: message}) do
    %{
        code: 404,
        message: message,
        meta: nil,
        data: nil
    }
  end

  def render("500.json", %{message: message, data: data}) do
    %{
        code: 500,
        message: message,
        meta: nil,
        data: data
    }
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
  
end

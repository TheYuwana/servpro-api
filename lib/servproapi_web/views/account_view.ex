defmodule ServproapiWeb.AccountView do
    use ServproapiWeb, :view
  
    def render("200.json", %{data: data}) do
        %{
            message: "Sucess!",
            meta: nil,
            data: data
        }
    end
    
  end
  
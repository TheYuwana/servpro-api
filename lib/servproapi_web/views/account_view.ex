defmodule ServproapiWeb.AccountView do
    use ServproapiWeb, :view
  
    def render("200.json", %{data: data}) do
        %{
            message: "Sucess!",
            meta: nil,
            data: data
        }
    end

    def render("user.json", %{user: user}) do

        skills = Enum.map(user.skills, fn user_skill -> 
            %{
                name: user_skill.skill.name,
                scale: user_skill.scale
            }
        end)

        %{
            message: "Sucess!",
            meta: nil,
            data: %{
                id: user.id,
                name: user.name,
                age: user.age,
                picture: user.picture,
                skills: skills
            }
        }
    end
    
  end
  
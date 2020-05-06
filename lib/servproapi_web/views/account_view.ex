defmodule ServproapiWeb.AccountView do
    use ServproapiWeb, :view
    alias ServproapiWeb.AccountView
  
    def render("200.json", %{data: data}) do
        %{
            message: "Sucess!",
            meta: nil,
            data: data
        }
    end

    def render("201.json", %{data: data}) do
        %{
            message: "Created!",
            meta: nil,
            data: data
        }
    end

    def render("list_skills.json", %{skills: skills}) do
        %{
            message: "Sucess!",
            meta: nil,
            data: render_many(skills, AccountView, "skill.json")
        }
    end

    def render("user.json", %{user: user}) do
        %{
            message: "Sucess!",
            meta: nil,
            data: %{
                id: user.id,
                name: user.name,
                age: user.age,
                picture: user.picture,
                skills: render_many(user.skills, AccountView, "user_skill.json")
            }
        }
    end
    
    def render("user_skill.json", %{account: user_skill}) do
        %{
            name: user_skill.skill.name,
            scale: user_skill.scale
        }
    end

    def render("skill.json", %{account: skill}) do
        %{
            id: skill.id,
            name: skill.name
        }
    end

  end
  
# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

alias Servproapi.{Service, Account}

IO.puts("========================")
IO.puts("Running migrations")
IO.puts("========================")

IO.puts("========================")
IO.puts("Adding Users")
IO.puts("========================")

case Account.list_users() do
    [] -> 
        users = [
            %{name: "admin", picture: "avatar_1", age: 99},
            %{name: "Jonathan", picture: "avatar_2", age: 99}
        ]

        Enum.each(users, fn user -> 
            Account.create_user(user)
        end)

    users ->
        IO.inspect("Database already populated with #{Enum.count(users)} users")
end

IO.puts("========================")
IO.puts("Adding Skills")
IO.puts("========================")

case Account.list_skills() do
    [] -> 
        skills = [
            %{name: "Javascript"},
            %{name: "Elixir"},
            %{name: "Coaching"},
            %{name: "Design"},
            %{name: "Game development"},
            %{name: "Tester"},
            %{name: "Devops"},
            %{name: "Cooking"},
            %{name: "Crafting"},
            %{name: "Magic"}
        ]

        Enum.each(skills, fn skill -> 
            Account.create_skill(skill)
        end)

    skills ->
        IO.inspect("Database already populated with #{Enum.count(skills)} skills")
end

IO.puts("========================")
IO.puts("Adding User SKill")
IO.puts("========================")

case Account.list_user_skills() do
    [] -> 
        {:ok, jon} = Account.get_user_by_name("Jonathan")
        {:ok, cooking} = Account.get_skill_by_name("Cooking")
        {:ok, javascript} = Account.get_skill_by_name("Javascript")

        user_skills = [
            %{
                scale: 3,
                user: jon,
                skill: cooking
            },
            %{
                scale: 10,
                user: jon,
                skill: javascript
            }
        ]

        Enum.each(user_skills, fn item -> 
            Account.create_user_skill(item.scale, item.user, item.skill)
        end)

    skills ->
        IO.inspect("Database already populated with #{Enum.count(skills)} skills")
end

IO.puts("========================")
IO.puts("Adding Requests")
IO.puts("========================")

case Service.list_requests() do
    [] -> 
        {:ok, today} = DateTime.now("Etc/UTC")
        {:ok, admin} = Account.get_user_by_name("admin")
        {:ok, jon} = Account.get_user_by_name("Jonathan")

        {:ok, javascript} = Account.get_skill_by_name("Javascript")
        {:ok, design} = Account.get_skill_by_name("Design")
        {:ok, coaching} = Account.get_skill_by_name("Coaching")
        {:ok, magic} = Account.get_skill_by_name("Magic")
        {:ok, cooking} = Account.get_skill_by_name("Cooking")
        
        skills = Account.list_skills()
        # aruba = Enum.at(countries, 0)

        requests = [
            %{
                client: "Lepaya",
                subject: "An interesting assignment",
                details: "Are you up for the task? Then get ready to setup the best webserive for one of our clients using VueJs and Node! Contact us for more information.",
                start_date: today |> DateTime.add(1*86400, :second),
                end_date: today |> DateTime.add(2*86400, :second),
                skill: javascript,
                user: admin
            },
            %{
                client: "N7 Studio",
                subject: "Interactive UI design",
                details: "We are looking for a talented designer to create one of the the most interactive UI for our users. Think of smooth flows, minimal steps and fance animations.",
                start_date: today |> DateTime.add(3*86400, :second),
                end_date: today |> DateTime.add(5*86400, :second),
                skill: design,
                user: admin
            },
            %{
                client: "We are now!",
                subject: "Looking for some assertiveness training",
                details: "There is a special group of shy people that needs guidance for assertivness. We are looking for someone that has the patience and time to help these people come out of their shell!",
                start_date: today |> DateTime.add(3*86400, :second),
                end_date: today |> DateTime.add(5*86400, :second),
                skill: coaching,
                user: jon
            },
            %{
                client: "Evermore",
                subject: "Specialty in Fire magic",
                details: "Here at Evermore, we specialize in special elemental magic. We are searching for a talented magic user to help us find the secrets to the fireball spell.",
                start_date: today |> DateTime.add(5*86400, :second),
                end_date: today |> DateTime.add(10*86400, :second),
                skill: magic,
                user: admin
            },
            %{
                client: "Kitchen Madness!",
                subject: "A new dish for fish!",
                details: "This week we are going to focus our efford in dishes for our fish friends! Do you have a keen eye for what fish people like? Then I am sure you can come up with one delicious dish!",
                start_date: today |> DateTime.add(14*86400, :second),
                end_date: today |> DateTime.add(21*86400, :second),
                skill: cooking,
                user: admin
            },
            %{
                client: "Evermore",
                subject: "Temporary chef",
                details: "In a few weeks, we will be holding our traditional Evermore banquet. You will be working with several other chefs from all sorts of species to create a feast that even the mightiets of dragons can enjoy!",
                start_date: today |> DateTime.add(21*86400, :second),
                end_date: today |> DateTime.add(28*86400, :second),
                skill: cooking,
                user: admin
            }
        ]

        Enum.each(requests, fn item -> 
            Service.create_request(item, item.user, item.skill)
        end)

    requests ->
        IO.inspect("Database already populated with #{Enum.count(requests)} requests")
end